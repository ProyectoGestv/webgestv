package model;

import java.io.IOException;

import javax.management.Attribute;
import javax.management.AttributeList;
import javax.management.AttributeNotFoundException;
import javax.management.DynamicMBean;
import javax.management.InstanceNotFoundException;
import javax.management.IntrospectionException;
import javax.management.InvalidAttributeValueException;
import javax.management.ListenerNotFoundException;
import javax.management.MBeanException;
import javax.management.MBeanInfo;
import javax.management.MBeanNotificationInfo;
import javax.management.MBeanServerConnection;
import javax.management.NotificationEmitter;
import javax.management.NotificationFilter;
import javax.management.NotificationListener;
import javax.management.ObjectName;
import javax.management.ReflectionException;


public class MyDynamicMBeanMirror implements DynamicMBean, NotificationEmitter{

	private final MBeanServerConnection mbsc;
	private final ObjectName objectName;
	private final MBeanInfo mbeanInfo;

	public MyDynamicMBeanMirror(MBeanServerConnection mbsc, ObjectName objectName) throws IOException, InstanceNotFoundException, IntrospectionException {
		this.mbsc = mbsc;
		this.objectName = objectName;
		try {
			this.mbeanInfo = mbsc.getMBeanInfo(objectName);
		} catch (ReflectionException e) {
			IntrospectionException ie = new IntrospectionException(e.getMessage());
			ie.initCause(e);
			throw ie;
		}
	}

	public MBeanServerConnection getMBeanServerConnection() {
		return mbsc;
	}

	public ObjectName getRemoteObjectName() {
		return objectName;
	}

	public Object getAttribute(String name) throws AttributeNotFoundException, MBeanException, ReflectionException {
		try {
			return mbsc.getAttribute(objectName, name);
		} catch (IOException e) {
			throw new MBeanException(e);
		} catch (InstanceNotFoundException e) {
			throw new MBeanException(e);
		}
	}

	public void setAttribute(Attribute attr) throws AttributeNotFoundException, InvalidAttributeValueException, MBeanException, ReflectionException {
		try {
			mbsc.setAttribute(objectName, attr);
		} catch (IOException e) {
			throw new MBeanException(e);
		} catch (InstanceNotFoundException e) {
			throw new MBeanException(e);
		}
	}

	public AttributeList getAttributes(String[] names) {
		try {
			return mbsc.getAttributes(objectName, names);
		} catch (RuntimeException e) {
			throw e;
		} catch (Exception e) {
			return new AttributeList();
		}
	}

	public AttributeList setAttributes(AttributeList attrs) {
		try {
			return mbsc.setAttributes(objectName, attrs);
		} catch (RuntimeException e) {
			throw e;
		} catch (Exception e) {
			return new AttributeList();
		}
	}

	public Object invoke(String opName, Object[] args, String[] sig) throws MBeanException, ReflectionException {
		try {
			return mbsc.invoke(objectName, opName, args, sig);
		} catch (IOException e) {
			throw new MBeanException(e);
		} catch (InstanceNotFoundException e) {
			throw new MBeanException(e);
		}
	}

	public MBeanInfo getMBeanInfo() {
		return mbeanInfo;
	}

	public void addNotificationListener(NotificationListener listener,  NotificationFilter filter, Object handback) {
        try {
        	getMBeanServerConnection().addNotificationListener(getRemoteObjectName(), listener, filter, null);
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

	public MBeanNotificationInfo[] getNotificationInfo() {
		return null;
	}

	public void removeNotificationListener(NotificationListener listener)
			throws ListenerNotFoundException {
	
	}

	public void removeNotificationListener(NotificationListener listener,
			NotificationFilter filter, Object handback)
			throws ListenerNotFoundException {

	}    
}
