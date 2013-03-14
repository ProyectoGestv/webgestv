package test;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.util.Scanner;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.management.InstanceAlreadyExistsException;
import javax.management.InstanceNotFoundException;
import javax.management.IntrospectionException;
import javax.management.ListenerNotFoundException;
import javax.management.MBeanRegistrationException;
import javax.management.MBeanServer;
import javax.management.MalformedObjectNameException;
import javax.management.NotCompliantMBeanException;
import javax.management.Notification;
import javax.management.NotificationListener;
import javax.management.ObjectName;
import javax.management.remote.JMXConnectionNotification;
import javax.management.remote.JMXConnector;

import mbean.DynamicMBeanFactory;
import mbean.DynamicMBeanMirrorFactory;
import mbean.MBSAConnection;
import mbean.MBSAConnections;
import mbean.RemoteMessageListener;
import mbean.RemoteMonitorListener;
import model.MyDynamicMBeanMirror;

public class TestMBeanServerMaster implements NotificationListener {
	
	private static RemoteMessageListener attlist = new RemoteMessageListener();
    private static RemoteMonitorListener listener = new RemoteMonitorListener();
    private MBeanServer masterMbeanServer;
    
	public TestMBeanServerMaster() {
		Logger.getLogger("javax.management.remote").setLevel(Level.OFF);		
		masterMbeanServer = ManagementFactory.getPlatformMBeanServer();
		createLocalMBean();
		menu();
	}
	
	public void register(String dirip, String port){
		if(!MBSAConnections.verifyConnection(dirip, port)){
			MBSAConnection connection = new MBSAConnection(dirip, port);
			connection.connect();
			if(connection.getConn()!=null){
				connection.getConn().addConnectionNotificationListener(this, null, null);
				MBSAConnections.add(connection);
				importAll(connection);				
			}
		}else
			System.out.println("Ya existe una conexión en la dirección "+dirip+":"+port);
	}
	
	public void menu(){
		String ip,port;
		Scanner scanner = new Scanner(System.in);
		while (true) {
			System.out.println("1. Registrar MBeanServer");
			System.out.println("2. Remover MBeanServer");
			System.out.println("3. Salir");
			int selection = scanner.nextInt();
			if (selection == 3) {
				break;
			}
			switch (selection) {
			case 1:
				System.out.println("Registrando MbeanServer");
				scanner.nextLine();
				System.out.println("ip=");
				ip=scanner.nextLine();
				System.out.println("port=");
				port=scanner.nextLine();
				register(ip, port);
				break;
			case 2:
				System.out.println("Removiendo MbeanServer");
				scanner.nextLine();
				System.out.println("ip=");
				ip=scanner.nextLine();
				System.out.println("port=");
				port=scanner.nextLine();
				MBSAConnection connection=MBSAConnections.searchConnection(ip, port);
				if(connection!=null){
					try {
						connection.getConn().removeConnectionNotificationListener(this);
					} catch (ListenerNotFoundException e) {
						e.printStackTrace();
					}
					removeAll(connection);
					System.out.println("Removida la conexión a la dirección "+ip+":"+port);
				}else
					System.out.println("No se encontró ninguna conexión a la dirección "+ip+":"+port);
				break;	
			default:
				System.out.println("opcion no valida.");
				break;
			}
		}
		scanner.close();
	}
	
	private void importAll(MBSAConnection connection){ 
		
		if(connection.getConn()!=null){
	        Set<ObjectName> names = connection.queryMbeanNames("gestv");
			ObjectName mirrorName = null;
	        for (ObjectName name : names) {
	            try {
	                 mirrorName = new ObjectName(""+name);
	                MyDynamicMBeanMirror mirror = DynamicMBeanMirrorFactory.newMBeanMirror(connection.getAgentMbeanServer(), name);
	                masterMbeanServer.registerMBean(mirror, mirrorName);
	            	mirror.addNotificationListener(attlist, null, null);
	            } catch (IllegalArgumentException e) {
	            	System.out.println("El MBeanServerAgent \""+mirrorName+"\" no presenta interfaz de notificaciones");
	            } catch (InstanceAlreadyExistsException e) {
					System.out.println("El MBean "+mirrorName+" ya se encuentra registrado.");
				} catch (MBeanRegistrationException e) {
					e.printStackTrace();
				} catch (NotCompliantMBeanException e) {
					e.printStackTrace();
				} catch (InstanceNotFoundException e) {
					e.printStackTrace();
				} catch (IntrospectionException e) {
					e.printStackTrace();
				} catch (MalformedObjectNameException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
	        }
	        
	        names = connection.queryMbeanServices("Services");
	        for (ObjectName name : names) {
	            try {
	                mirrorName = new ObjectName(""+name);
	                connection.getAgentMbeanServer().addNotificationListener(mirrorName, listener, null, null);
	            } catch (Exception e) {
	            	e.printStackTrace();
	            }
	        }
		}
    }

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) {
		@SuppressWarnings("unused")
		TestMBeanServerMaster mmaster = new TestMBeanServerMaster();
	}
	
	private void createLocalMBean(){
		String domain = "gestv";
		String name = "attrs1";
		String type = "servicios";
		java.net.URL r = this.getClass().getResource("/");
		DynamicMBeanFactory.getDynamicBean(domain, name, type,r.getPath(),null);
	}

	@Override
	public void handleNotification(Notification notification, Object arg1) {
		JMXConnectionNotification notif = (JMXConnectionNotification)notification;
		JMXConnector conn = (JMXConnector)notif.getSource();
		if(notif.getType().equals("jmx.remote.connection.closed")){
			try {
				conn.removeConnectionNotificationListener(this);
				MBSAConnection connection=MBSAConnections.searchConnection(conn);
				removeAll(connection);
				System.out.println("La conexión RMI se cayó");
				reconnect(connection);
			} catch (ListenerNotFoundException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void reconnect(MBSAConnection connection){
		while(connection.getConn()==null){
			System.out.println("Reconectando...");
			connection.connect();
			if(connection.getConn()!=null){
				connection.getConn().addConnectionNotificationListener(this, null, null);				
				MBSAConnections.add(connection);
				importAll(connection);				
			} else{
				try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public void removeAll(MBSAConnection connection){
		Set<ObjectName> names = connection.getMbeanNames();
        for (ObjectName name : names) {
            try {
            	masterMbeanServer.unregisterMBean(name);
            } catch (IllegalArgumentException e) {
            	System.out.println("El MBean \""+name+"\" no presenta interfaz de notificaciones");
            } catch (MBeanRegistrationException e) {
				e.printStackTrace();
			} catch (InstanceNotFoundException e) {
				e.printStackTrace();
			}
        }
		MBSAConnections.removeConnection(connection);
		connection.setConn(null);
	}
}
