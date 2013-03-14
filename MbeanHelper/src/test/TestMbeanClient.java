package test;

import java.net.URI;
import java.util.Scanner;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.config.ClientConfig;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.representation.Form;

public class TestMbeanClient {
	public static void main(String[] args) {
		ClientConfig config = new DefaultClientConfig();
		Client client = Client.create(config);
		ClientResponse response;
		String dominio,tipo,valor,atributo;
		WebResource service = client.resource(getBaseURI());
		
		Scanner scanner = new Scanner(System.in);
		while (true) {
			System.out.println("1. Registrar");
			System.out.println("2. Remover");
			System.out.println("3. Set Attribute");
			System.out.println("4. Set Multiple Attributes");
			System.out.println("5. Salir");
			int selection = scanner.nextInt();
			if (selection == 5) {
				break;
			}
			switch (selection) {
			case 1:
				System.out.println("Registrando Mbean");
				scanner.nextLine();
				System.out.println("Dominio=");
				dominio=scanner.nextLine();
				System.out.println("Tipo=");
				tipo=scanner.nextLine();
				Form form = new Form();
			    form.add("domain", dominio);
			    form.add("type", tipo);
			    response = service.path("register").type(MediaType.APPLICATION_FORM_URLENCODED).post(ClientResponse.class, form);
			    System.out.println("Respuesta: " + response.getEntity(String.class));
				break;
			case 2:
				System.out.println("Removiendo Mbean");
				scanner.nextLine();
				System.out.println("Dominio=");
				dominio=scanner.nextLine();
				System.out.println("Tipo=");
				tipo=scanner.nextLine();
			    System.out.println("Respuesta: " + service.path(dominio+"/"+tipo).delete(String.class));
				break;
			case 3:
				System.out.println("Set Attribute Mbean");
				scanner.nextLine();
				System.out.println("Dominio=");
				dominio=scanner.nextLine();
				System.out.println("Tipo=");
				tipo=scanner.nextLine();
				System.out.println("Atributo=");
				atributo=scanner.nextLine();
				System.out.println("Valor=");
				valor=scanner.nextLine();
				Form form2 = new Form();
			    form2.add("value", valor);
			    System.out.println("Respuesta: " + service.path(dominio+"/"+tipo+"/"+atributo).type(MediaType.APPLICATION_FORM_URLENCODED).put(String.class, form2));
				break;
			case 4:
				System.out.println("Set Multiple Attributes Mbean");
				scanner.nextLine();
				System.out.println("Dominio=");
				dominio=scanner.nextLine();
				System.out.println("Tipo=");
				tipo=scanner.nextLine();
				boolean next=true;
				Form forms = new Form();				
				do{
					System.out.println("Atributo=");
					atributo=scanner.nextLine();
				    forms.add("name", atributo);
					System.out.println("Valor=");
					valor=scanner.nextLine();
				    forms.add("value", valor);
					System.out.println("Insert another ? (y, n)");
					String res =scanner.nextLine();
					if(res.equals("y"))
						next=true;
					else
						next=false;
				}while(next);
			    System.out.println("Respuesta: " + service.path(dominio+"/"+tipo+"/attributes").type(MediaType.APPLICATION_FORM_URLENCODED).put(String.class, forms));
				break;
			default:
				System.out.println("opcion no valida.");
				break;
			}
		}
	}

	private static URI getBaseURI() {
		return UriBuilder.fromUri("http://localhost:8080/registrator").build();
	}

}