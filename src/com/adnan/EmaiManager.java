package com.adnan;

import java.io.IOException;
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
public class EmaiManager extends HttpServlet {
	private static Logger log = Logger.getLogger(EmaiManager.class.getCanonicalName());
	private static String fromAddress = "donna006@gmail.com";
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		List<JobSeeker> th = OfyService.ofy().load().type(JobSeeker.class).list();
		Collections.sort(th);
		boolean flag=true;
		String newJob = req.getParameter("email");
		for (JobSeeker s : th ) {
			if(s.email.equals(newJob)) {
		  // APT: calls to System.out.println go to the console, calls to out.println go to the html returned to browser
		  // the line below is useful when debugging (jsp or servlet)
				//System.out.println("<br><h1>s = " + s);
				resp.sendRedirect("/Error.jsp");
				flag=false;
				//ofy().save().entity(s).now();
			}
		
		}
		
		if(flag) {
//String ID, String firstname, String lastname, String zipcode, String city, String state, String country, String interests, String jobtype, String email) {
			//title, category, location, skills, experience,hm,hmemail
			JobSeeker s = new JobSeeker(req.getParameter("user"),req.getParameter("email"), req.getParameter("firstname"), 
				req.getParameter("lastname"), req.getParameter("zipcode"), req.getParameter("city"),
				req.getParameter("state"),req.getParameter("country"),
				req.getParameter("interests"),req.getParameter("jobtype"),req.getParameter("email"));
		// persist to datastore
		ofy().save().entity(s).now();
		//String[] subs=req.getParameter("subscribers").split(",");
		//for(int i=0; i<subs.length; i++) {	
			//send(subs[i],"Connexus: Subscription confirmation for stream - "+req.getParameter("streamName"),req.getParameter("message"));
		//}
		
		resp.sendRedirect("/ViewProfile.jsp");
		}
	}
	
	
	/**
	   * Method defines the way to send a mail
	   * 
	   * @param toAddress : the address to which mail needs to be sent
	   * @param subject : subject of the mail
	   * @param msgBody : mail content
	   * @throws IOException
	   */
	  // Send the Mail
	  public void send(String toAddress, String subject, String msgBody)
	      throws IOException {

	    Properties props = new Properties();
	    Session session = Session.getDefaultInstance(props, null);

	    try {
	      Message msg = new MimeMessage(session);
	      msg.setFrom(new InternetAddress(fromAddress));
	      InternetAddress to = new InternetAddress(toAddress);
	      msg.addRecipient(Message.RecipientType.TO, to);
	      msg.setSubject(subject);
	      msg.setText(msgBody);
	      Transport.send(msg, new InternetAddress[] { to });

	    } catch (AddressException addressException) {
	      log.log(Level.SEVERE, "Address Exception , mail could not be sent", addressException);
	    } catch (MessagingException messageException) {
	      log.log(Level.SEVERE, "Messaging Exception , mail could not be sent", messageException);
	    }
	  }
}