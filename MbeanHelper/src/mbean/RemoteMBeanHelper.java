package mbean;

import java.util.HashMap;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import model.MyDynamicMBean;

@Path("/")
public class RemoteMBeanHelper {

	// This method is called if HTML is request
	@POST
	@Path("/register")
	@Produces(MediaType.TEXT_PLAIN)
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public String register(@FormParam("domain") String domain,
			@FormParam("type") String type) {
		java.net.URL r = this.getClass().getResource("/");
		MyDynamicMBean mBean = DynamicMBeanFactory.getDynamicBean(domain, type, r.getPath(),null);
		if (mBean == null)
			return "Error";
		else
			return mBean.getMBeanInfo().toString();
	}

	@DELETE
	@Path("/{domain}/{type}")
	@Produces(MediaType.TEXT_PLAIN)
	public String remove(@PathParam("domain") String domain,
			@PathParam("type") String type) {
		return DynamicMBeanFactory.removeDynamicBean(domain, type);
	}
	
	@PUT
	@Path("/{domain}/{type}/{attribute}")
	  @Produces(MediaType.TEXT_PLAIN)
	  @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	  public String setAttribute(@PathParam("domain") String domain,
				@PathParam("type") String type, 
				@PathParam("attribute") String attribute,
				@FormParam("value") String value) {
	    return DynamicMBeanFactory.setAttribute(domain, type, attribute, value);
	  }

	@PUT
	@Path("/{domain}/{type}/attributes")
	  @Produces(MediaType.TEXT_PLAIN)
	  @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	  public String setAttributes(@PathParam("domain") String domain, @PathParam("type") String type, @FormParam("name") List<String> names, @FormParam("value") List<String> values) {
		HashMap<String, String> attrhm = new HashMap<String, String>();
		for(int i=0;i<names.size();i++){
			attrhm.put(names.get(i), values.get(i));
			//System.out.println(names.get(i)+"="+values.get(i));
		}
		return DynamicMBeanFactory.setAttributes(domain, type, attrhm);
	  }
}
