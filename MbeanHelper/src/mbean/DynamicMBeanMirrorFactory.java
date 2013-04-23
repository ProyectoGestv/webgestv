package mbean;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.Map.Entry;

import javax.management.Attribute;
import javax.management.AttributeList;
import javax.management.AttributeNotFoundException;
import javax.management.InstanceAlreadyExistsException;
import javax.management.InstanceNotFoundException;
import javax.management.IntrospectionException;
import javax.management.InvalidAttributeValueException;
import javax.management.ListenerNotFoundException;
import javax.management.MBeanException;
import javax.management.MBeanRegistrationException;
import javax.management.MBeanServer;
import javax.management.MBeanServerConnection;
import javax.management.MalformedObjectNameException;
import javax.management.NotCompliantMBeanException;
import javax.management.Notification;
import javax.management.NotificationListener;
import javax.management.ObjectName;
import javax.management.ReflectionException;
import javax.management.monitor.Monitor;
import javax.management.remote.JMXConnectionNotification;
import javax.management.remote.JMXConnector;

import model.MyDynamicMBeanMirror;

public class DynamicMBeanMirrorFactory implements NotificationListener{
	
	public static MBeanServer masterMbeanServer = null;
    public static MonitorListener listener = new MonitorListener();
    private static MessageListener attlist = new MessageListener();
    private static List<Monitor> monitors = new ArrayList<Monitor>();

    public static MyDynamicMBeanMirror newMBeanMirror( MBeanServerConnection mbsc, ObjectName objectName) throws IOException, InstanceNotFoundException, IntrospectionException {
    	MyDynamicMBeanMirror mirror = new MyDynamicMBeanMirror(mbsc, objectName);
        return mirror;
    }
    
    public static void setMBeanMasterServer(MBeanServer mbServer) {
    	masterMbeanServer=mbServer;
    }
    
	public static void register(String dirip, String port, String domain, String type, String name){
		MBSAConnection connection=MBSAConnections.searchConnection(dirip, port);
		if(connection==null){
			connection = new MBSAConnection(dirip, port, domain);
			connection.connect();
			if(connection.getConn()!=null){
				MBSAConnections.add(connection);
				importAll(connection, type, name);				
			}
		}else{
			System.out.println("Ya existe una conexión en la dirección "+dirip+":"+port);
			connection.connect();
			if(connection.getConn()!=null){
				importAll(connection, type, name);				
			}
		}
	}
	
	private static void importAll(MBSAConnection connection, String type, String nom){ 
		
		if(connection.getConn()!=null){
	        Set<ObjectName> names = connection.queryMbeanDomain(type, nom);
			ObjectName mirrorName = null;
	        for (ObjectName name : names) {
	            try {
	                mirrorName = new ObjectName(""+name);
	                MyDynamicMBeanMirror mirror = DynamicMBeanMirrorFactory.newMBeanMirror(connection.getAgentMbeanServer(), name);
	                if(!mirrorName.toString().equals("JMImplementation:type=MBeanServerDelegate")){
		                masterMbeanServer.registerMBean(mirror, mirrorName);
		            	mirror.addNotificationListener(attlist, null, null);
		            	System.out.println("MBean "+mirrorName+" registrado.");
	                }
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

	public static void removeAll(String ip, String port){
		MBSAConnection connection=MBSAConnections.searchConnection(ip, port);
		Set<ObjectName> names = connection.getMbeanNames();
        for (ObjectName name : names) {
            try {
            	if(!name.toString().equals("JMImplementation:type=MBeanServerDelegate"))
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
	
	public static void removeAll(MBSAConnection connection){
		Set<ObjectName> names = connection.getMbeanNames();
        for (ObjectName name : names) {
            try {
            	if(!name.toString().equals("JMImplementation:type=MBeanServerDelegate"))
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
				//reconnect(connection);
			} catch (ListenerNotFoundException e) {
				e.printStackTrace();
			}
		}
	}

	public static String setAttribute(String domain, String name, String type, String attribute, String value){
		String retorno="OK";
		//mbeanServer = ManagementFactory.getPlatformMBeanServer();
		Attribute attr = new Attribute(attribute, value);
		if(masterMbeanServer!=null){
			try {
				masterMbeanServer.setAttribute(new ObjectName(domain+":type="+type+",name="+name), attr);
			} catch (InstanceNotFoundException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (InvalidAttributeValueException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (AttributeNotFoundException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (MalformedObjectNameException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (ReflectionException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (MBeanException e) {
				e.printStackTrace();
				retorno=e.toString();
			}
		}
		return retorno;
	}

	public static String setAttributes(String domain, String name, String type, HashMap<String, String> attributes){
		
		String retorno="OK";
		//mbeanServer = ManagementFactory.getPlatformMBeanServer();
		if(masterMbeanServer!=null){
			AttributeList listattr = new AttributeList();
			for (Entry<String, String> attribute : attributes.entrySet()) {
				listattr.add(new Attribute(attribute.getKey(), attribute.getValue()));			
			}
			try {
				masterMbeanServer.setAttributes(new ObjectName(domain+":type="+type+",name="+name), listattr);
			} catch (InstanceNotFoundException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (MalformedObjectNameException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (ReflectionException e) {
				e.printStackTrace();
				retorno=e.toString();
			}
		}
		return retorno;
	}
	
	public static String getMRInfo(String domain, String type){
		String retorno="Error";
		
		return retorno;
	}
	
	public static String getMAInfo(String domain, String type, String name){
		String retorno="Error";
		
		return retorno;
	}
	
	public static String setMonitor(String domain, String type, String name, String attribute, String monitor, String value){
		String retorno="Error";
		
		return retorno;
	}
	
	public static String getAttribute(String domain, String name, String type, String attribute){
		String retorno="Error";
		//mbeanServer = ManagementFactory.getPlatformMBeanServer();
		if(masterMbeanServer!=null){
			try {
				retorno = (String) masterMbeanServer.getAttribute(new ObjectName(domain+":type="+type+",name="+name), attribute);
			} catch (InstanceNotFoundException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (AttributeNotFoundException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (MalformedObjectNameException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (ReflectionException e) {
				e.printStackTrace();
				retorno=e.toString();
			} catch (MBeanException e) {
				e.printStackTrace();
				retorno=e.toString();
			}
		}
		return retorno;
	}
}


