package mbean;


import java.io.File;
import java.io.FileNotFoundException;
import java.lang.management.ManagementFactory;
import javax.management.monitor.Monitor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import javax.management.Attribute;
import javax.management.AttributeList;
import javax.management.AttributeNotFoundException;
import javax.management.InstanceAlreadyExistsException;
import javax.management.InstanceNotFoundException;
import javax.management.InvalidAttributeValueException;
import javax.management.MBeanException;
import javax.management.MBeanRegistrationException;
import javax.management.MBeanServer;
import javax.management.MalformedObjectNameException;
import javax.management.NotCompliantMBeanException;
import javax.management.ObjectInstance;
import javax.management.ObjectName;
import javax.management.ReflectionException;

import org.simpleframework.xml.Serializer;
import org.simpleframework.xml.core.Persister;

import model.MyDynamicMBean;
import model.Monitors;
import model.MyMonitor;

public class DynamicMBeanFactory {

	public static MBeanServer mbeanServer;
	public static String filename = "example";
	public static String filenameM = "exampleMonitors";
    private static MonitorListener listener = new MonitorListener();
    private static MessageListener attlist = new MessageListener();
    private static List<Monitor> monitors = new ArrayList<Monitor>();

    public DynamicMBeanFactory(){
    	super();
    }
    
	public static MyDynamicMBean getDynamicBean(String domain, String type, String pathXml, String namefile) {
		//Register a MBean
		String filenameU=null;
		if(namefile==null)
			filenameU=filename;
		else
			filenameU=namefile;
		
		mbeanServer = ManagementFactory.getPlatformMBeanServer();
		MyDynamicMBean dynamicMBean = null;

		try {
			dynamicMBean = new MyDynamicMBean(pathXml+"/"+filenameU+".xml");
			dynamicMBean.setDomain(domain);
			dynamicMBean.setType(type);
			mbeanServer.registerMBean(dynamicMBean, new ObjectName(domain + ":type=" + type));
			mbeanServer.addNotificationListener(new ObjectName(domain + ":type=" + type), attlist, null, null);
		} catch (Exception e) {
			e.printStackTrace();
		}

		Monitors ms = loadMonitor(pathXml,filenameU);
		if(ms!=null){
			for (MyMonitor mm : ms.getMonitors()) {
				Monitor m = mm.getMonitor();
				String name = mm.getName()+"_"+type+"_"+m.getObservedAttribute();
				try {
					m.addObservedObject(new ObjectName(domain + ":type=" + type));
					mbeanServer.registerMBean(m, new ObjectName(name));
				} catch (InstanceAlreadyExistsException e) {
					e.printStackTrace();
				} catch (MBeanRegistrationException e) {
					e.printStackTrace();
				} catch (NotCompliantMBeanException e) {
					e.printStackTrace();
				} catch (MalformedObjectNameException e) {
					e.printStackTrace();
				}
		        try {
		        	m.addNotificationListener(listener, null, null);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
				monitors.add(m);
				m.start();
			}
		}

		return dynamicMBean;
	}
	
	
	public static String removeDynamicBean(String domain, String type){
		//Unregister MBean
		String retorno="";
		mbeanServer = ManagementFactory.getPlatformMBeanServer();
		try {
			Set<?> dynamicData;
			dynamicData = mbeanServer.queryMBeans(new ObjectName(domain+":type="+type), null);
			for (Iterator<?> it = dynamicData.iterator(); it.hasNext();) {
				ObjectInstance oi = (ObjectInstance) it.next();
				ObjectName oName = oi.getObjectName();
				mbeanServer.unregisterMBean(oName);
			}
			if(dynamicData.size()>0)
				retorno = "OK";
			else
				retorno = "Not Found";
		} catch (MalformedObjectNameException e) {
			e.printStackTrace();
		} catch (InstanceNotFoundException e) {
			e.printStackTrace();
		} catch (MBeanException e) {
			e.printStackTrace();
		}
		//Unregister CounterMonitor MBean associated
		Set<?> dynamicData;
		try {
			dynamicData = mbeanServer.queryMBeans(new ObjectName("Services:*"), null);
			for (Iterator<?> it = dynamicData.iterator(); it.hasNext();) {
				ObjectInstance oi = (ObjectInstance) it.next();
				ObjectName oName = oi.getObjectName();
				System.out.println("name="+oName.toString());
				if(oName.toString().contains("_"+type+"_")){
					Monitor m = null;
					for (int i=0;i<monitors.size(); i++) {
						if(((Monitor)monitors.get(i)).containsObservedObject(new ObjectName(domain+":type="+type))){
							m=(Monitor)monitors.get(i);
							break;
						}
					}
					if(m!=null){
						m.stop();
						try {
							mbeanServer.unregisterMBean(oName);
						} catch (MBeanRegistrationException e) {
							e.printStackTrace();
						} catch (InstanceNotFoundException e) {
							e.printStackTrace();
						}
						monitors.remove(m);
					}
				}
			}
		} catch (MalformedObjectNameException e) {
			e.printStackTrace();
		}
		
		return retorno;
	}
	
	public static String setAttribute(String domain, String type, String attribute, String value){
		String retorno="OK";
		mbeanServer = ManagementFactory.getPlatformMBeanServer();
		Attribute attr = new Attribute(attribute, value);
		try {
			mbeanServer.setAttribute(new ObjectName(domain+":type="+type), attr);
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
		return retorno;
	}
	
	public static String setAttributes(String domain, String type, HashMap<String, String> attributes){
		
		String retorno="OK";
		mbeanServer = ManagementFactory.getPlatformMBeanServer();

		AttributeList listattr = new AttributeList();
		for (Entry<String, String> attribute : attributes.entrySet()) {
			listattr.add(new Attribute(attribute.getKey(), attribute.getValue()));			
		}
		try {
			mbeanServer.setAttributes(new ObjectName(domain+":type="+type), listattr);
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
		return retorno;
	}
	
	public static Monitors loadMonitor(String xmlPath, String xmlFileName){
		Serializer serializer = new Persister();
		File source = new File(xmlPath+"/"+xmlFileName+"Monitors.xml");
		Monitors mm = null;
		try {
			mm = serializer.read(Monitors.class, source);
		} catch (FileNotFoundException e) {
			System.out.println("El MBean no tiene configuración de monitores.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mm;
	}
}