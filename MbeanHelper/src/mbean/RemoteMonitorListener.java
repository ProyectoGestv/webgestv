package mbean;


import javax.management.*;
import javax.management.monitor.*;

public class RemoteMonitorListener implements NotificationListener {

    public RemoteMonitorListener() {
        super();
    }

    public void handleNotification(Notification notification, Object handback) {
        MonitorNotification notif = (MonitorNotification)notification;
        String object=notif.getObservedObject().toString();
        String attribute=notif.getObservedAttribute();
        String type = notification.getType();
        try {
            if (type.equals(MonitorNotification.THRESHOLD_VALUE_EXCEEDED)) {
                System.out.println("<<Remote>> " + attribute + " from " + object + " has reached the threshold\n");
            }
            else if (type.equals(MonitorNotification.THRESHOLD_HIGH_VALUE_EXCEEDED)) {
                System.out.println("<<Remote>> " + attribute + " from " + object + " has reached the High threshold\n");
            }
            else if (type.equals(MonitorNotification.THRESHOLD_LOW_VALUE_EXCEEDED)) {
                System.out.println("<<Remote>> " + attribute + " from " + object + " has reached the Low threshold\n");
            }
            else if (type.equals(MonitorNotification.STRING_TO_COMPARE_VALUE_MATCHED)) {
                System.out.println("<<Remote>> " + attribute + " from " + object + " matches the compare value\n");
            }     
            else if (type.equals(MonitorNotification.STRING_TO_COMPARE_VALUE_DIFFERED)) {
                System.out.println("<<Remote>> " + attribute + " from " + object + " differs the compare value\n");
            }            
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
}