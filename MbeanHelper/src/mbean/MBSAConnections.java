package mbean;

import java.util.ArrayList;
import java.util.List;

import javax.management.remote.JMXConnector;

public class MBSAConnections {

	private static List<MBSAConnection> connections = new ArrayList<MBSAConnection>();

	public static void add(MBSAConnection connection) {
		connections.add(connection);
	}	

	public static void removeConnection(JMXConnector conn){
		connections.remove(searchConnection(conn));
	}
	
	public static void removeConnection(MBSAConnection agent){
		connections.remove(agent);
	}
	
	public static MBSAConnection searchConnection(JMXConnector conn){
		MBSAConnection agentMBeanServer = null;
		for (MBSAConnection agent : connections) {
			if(agent.getConn()==conn){
				agentMBeanServer=agent;
				break;
			}
		}
		return agentMBeanServer;
	}
	
	public static MBSAConnection searchConnection(String dirip, String port){
		MBSAConnection agentMBeanServer = null;
		for (MBSAConnection agent : connections) {
			if(agent.getDirip().equals(dirip) && agent.getPort().equals(port)){
				agentMBeanServer=agent;
				break;
			}
		}
		return agentMBeanServer;
	}
	
	public static boolean verifyConnection(String dirip, String port){
		boolean exist=false;
		for (MBSAConnection agent : connections) {
			if(agent.getDirip().equals(dirip) && agent.getPort().equals(port)){
				exist=true;
				break;
			}
		}
		return exist;
	}
}
