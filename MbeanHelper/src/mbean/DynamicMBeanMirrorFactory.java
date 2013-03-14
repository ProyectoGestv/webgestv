package mbean;

import java.io.IOException;
import javax.management.InstanceNotFoundException;
import javax.management.IntrospectionException;
import javax.management.MBeanServerConnection;
import javax.management.ObjectName;

import model.MyDynamicMBeanMirror;

public class DynamicMBeanMirrorFactory {

    public static MyDynamicMBeanMirror newMBeanMirror( MBeanServerConnection mbsc, ObjectName objectName) throws IOException, InstanceNotFoundException, IntrospectionException {
    	MyDynamicMBeanMirror mirror = new MyDynamicMBeanMirror(mbsc, objectName);
        return mirror;
    }

}


