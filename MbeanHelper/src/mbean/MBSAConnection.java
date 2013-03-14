package mbean;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Set;

import javax.management.MBeanServerConnection;
import javax.management.MalformedObjectNameException;
import javax.management.ObjectName;

import javax.management.remote.JMXConnector;
import javax.management.remote.JMXConnectorFactory;
import javax.management.remote.JMXServiceURL;

public class MBSAConnection {

	private MBeanServerConnection agentMbeanServer = null;
	private JMXConnector conn = null;
	private JMXServiceURL url = null;
	private String dirip;
	private String port;
	private Set<ObjectName> mbeanNames = null;
	private Set<ObjectName> mbeanServices = null;
	
	public MBSAConnection(String dirip, String port) {
		this.dirip=dirip;
		this.port=port;
		try {
			this.url = new JMXServiceURL("service:jmx:rmi:///jndi/rmi://" + dirip + ":"+port+"/jmxrmi");
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
	}
	
	public Set<ObjectName> queryMbeanNames(String key){
		Set<ObjectName> names = null;
		try {
			names = agentMbeanServer.queryNames(new ObjectName(key+":*"),null);
			setMbeanNames(names);
		} catch (MalformedObjectNameException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return names;
	}
	
	public Set<ObjectName> queryMbeanServices(String key){
		Set<ObjectName> names = null;
		try {
			names = agentMbeanServer.queryNames(new ObjectName(key+":*"),null);
			setMbeanServices(names);
		} catch (MalformedObjectNameException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return names;
	}

	public MBeanServerConnection connect(){
		try {
			conn = JMXConnectorFactory.connect(url);
			System.out.println("Conectado con el MBeanServerAgent "+ url.getURLPath());
			//connected = true;
			agentMbeanServer = conn.getMBeanServerConnection();
		} catch (IOException e2) {
			System.out.println("No se pudo conectar con el MBeanServerAgent "+ url.getURLPath());
		}
		return agentMbeanServer;
	}

	public MBeanServerConnection getAgentMbeanServer() {
		return agentMbeanServer;
	}

	public String getDirip() {
		return dirip;
	}

	public void setDirip(String dirip) {
		this.dirip = dirip;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public JMXConnector getConn() {
		return conn;
	}

	public Set<ObjectName> getMbeanNames() {
		return mbeanNames;
	}

	public void setMbeanNames(Set<ObjectName> mbeanNames) {
		this.mbeanNames = mbeanNames;
	}

	public Set<ObjectName> getMbeanServices() {
		return mbeanServices;
	}

	public void setMbeanServices(Set<ObjectName> mbeanServices) {
		this.mbeanServices = mbeanServices;
	}

	public void setConn(JMXConnector conn) {
		this.conn = conn;
	}
}
