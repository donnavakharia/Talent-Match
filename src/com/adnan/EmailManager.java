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
public class EmailManager extends HttpServlet {
	private static Logger log = Logger.getLogger(EmailManager.class.getCanonicalName());
	private static String fromAddress = "donna006@gmail.com";
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		List<AddPosting> th = OfyService.ofy().load().type(AddPosting.class).list();
		Collections.sort(th);
		boolean flag=true;
		String username = req.getParameter("username");
		String jobID = req.getParameter("jobID");
		String emailTo = req.getParameter("email");
		String from = req.getParameter("from");
		String userlink = "https://talent-match.appspot.com/SearchUser.jsp?jobID="+jobID + "&username="+username;
		String message = "Hi, \n\nPlease find below link to a matching profile for Job: " + jobID +"\n\n" + userlink +
				"\n\nSent by " + from + "\n\nRegards,\nThe Talent-Match Team\nhttps://talent-match.appspot.com";
		send(emailTo,"Profile Match for Job "+jobID, message);
		resp.sendRedirect("/Manage.jsp");
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
	      msg.setFrom(new InternetAddress(fromAddress, "Talent-Match Team"));
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