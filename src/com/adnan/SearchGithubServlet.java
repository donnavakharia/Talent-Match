package com.adnan;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.*;

import static com.googlecode.objectify.ObjectifyService.ofy;

// Backs up CreateStream.html form submission. Trivial since there's no image uploaded, just a URL
@SuppressWarnings("serial")
public class SearchGithubServlet extends HttpServlet {
	private static Logger log = Logger.getLogger(SearchGithubServlet.class.getCanonicalName());
	private static String fromAddress = "donna006@gmail.com";
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		
		StringBuffer response1 = new StringBuffer();
		String jobID = req.getParameter("jobID");
		//String[] streams = streamName.split(",");
		//for (int i = 0; i < streams.length; i++) {

		List<AddPosting> th = OfyService.ofy().load()
				.type(AddPosting.class).list();
		Collections.sort(th);
		for (AddPosting s : th) {
			if (s.jobID.equals(jobID)) {

				System.out.println(s.jobID);
				System.out.println(s.title);
				System.out.println(s.category);
				System.out.println(s.skills);
				System.out.println(s.experience);
				System.out.println(s.hiringManager);
				System.out.println(s.hiringManagerEmail);
				String newLoc = "";
				String loc[] = s.location.split(" ");
				for (int i = 0; i < loc.length; i++) {
					if (i == loc.length)
						newLoc += loc[i];
					else
						newLoc += loc[i] + "%20";
				}

				String url = "https://api.github.com/search/users?q=language:"
						+ s.skills
						+ "+location:"
						+ newLoc
						+ "&sort=followers";

				System.out.println("\n" + url + "\n");

				URL obj = new URL(url);
				HttpURLConnection con = (HttpURLConnection) obj
						.openConnection();

				// optional default is GET
				con.setRequestMethod("GET");

				//add request header
				con.setRequestProperty("User-Agent", "Mozilla/5.0");

				int responseCode = con.getResponseCode();
				System.out.println("\nSending 'GET' request to URL : "
						+ url);
				System.out.println("Response Code : " + responseCode);

				BufferedReader in = new BufferedReader(
						new InputStreamReader(con.getInputStream()));
				String inputLine;
				

				while ((inputLine = in.readLine()) != null) {
					response1.append(inputLine);
				}
				in.close();

				//print result
				System.out.println(response1.toString());
				
				/////////

				/////////////

				//OfyService.ofy().save().entity(s).now();
				//OfyService.ofy().delete().entity(s);
			}
		}
		resp.sendRedirect("/SearchGithub.jsp?result="+ response1.toString());
				
		
		
	}
	
	
}