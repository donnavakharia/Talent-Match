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
public class CheckProfile extends HttpServlet {
	private static Logger log = Logger.getLogger(CheckProfile.class.getCanonicalName());
	private static String fromAddress = "donna006@gmail.com";
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		List<JobSeeker> th = OfyService.ofy().load().type(JobSeeker.class).list();
		Collections.sort(th);
		String u = req.getParameter("u");
		boolean flag=true;
		int count=0;
		for (JobSeeker s : th ) {
			if(s.postOwner.equals(u))
				count++;
		}
		
		if(count==0)
			resp.sendRedirect("/CreateProfile.jsp");
		else
		resp.sendRedirect("/ViewProfile.jsp?count="+count);
		
	}
	
	
}