package test;

import java.io.IOException;
import java.lang.management.ManagementFactory;
import java.net.InetAddress;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;

import javax.management.Attribute;
import javax.management.AttributeNotFoundException;
import javax.management.InstanceNotFoundException;
import javax.management.InvalidAttributeValueException;
import javax.management.MBeanException;
import javax.management.MBeanServer;
import javax.management.MalformedObjectNameException;
import javax.management.ObjectName;
import javax.management.ReflectionException;
import javax.management.remote.JMXConnectorServer;
import javax.management.remote.JMXConnectorServerFactory;
import javax.management.remote.JMXServiceURL;

import mbean.DynamicMBeanFactory;

public class TestMBeanServerAgent {

	public TestMBeanServerAgent() {
		String domain = "gestv";
		String type = "Webservices";
		java.net.URL r = this.getClass().getResource("/");
        MBeanServer mbeanServer = ManagementFactory.getPlatformMBeanServer();
		DynamicMBeanFactory.getDynamicBean(domain, type, r.getPath(), type);
        try {
			LocateRegistry.createRegistry(10000);
	        JMXServiceURL url = new JMXServiceURL("service:jmx:rmi:///jndi/rmi://" + InetAddress.getLocalHost().getHostName() + ":10000/jmxrmi");
	        JMXConnectorServer cs = JMXConnectorServerFactory.newJMXConnectorServer(url, null, mbeanServer);
	        cs.start();
	        System.out.println("Escuchando en " + cs.getAddress());
	        System.in.read();
	        Attribute attr = new Attribute("notificaciones", 3);
			try {
				mbeanServer.setAttribute(new ObjectName(domain+":type="+type), attr);
			} catch (InstanceNotFoundException e) {
				e.printStackTrace();
			} catch (InvalidAttributeValueException e) {
				e.printStackTrace();
			} catch (AttributeNotFoundException e) {
				e.printStackTrace();
			} catch (MalformedObjectNameException e) {
				e.printStackTrace();
			} catch (ReflectionException e) {
				e.printStackTrace();
			} catch (MBeanException e) {
				e.printStackTrace();
			}

	        System.in.read();
	        cs.stop();
		} catch (RemoteException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		@SuppressWarnings("unused")
		TestMBeanServerAgent agent = new TestMBeanServerAgent();
	}
}
