package com.adnan;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.*;

import static com.googlecode.objectify.ObjectifyService.ofy;

class userdetails {
	String googleid;
	String password;
	
	userdetails(String g, String p) {
		this.googleid = g;
		this.password = p;
	}
}
// Backs up CreateStream.html form submission. Trivial since there's no image uploaded, just a URL
@SuppressWarnings("serial")
public class Welcome extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		userdetails s = new userdetails(req.getParameter("googleid"), req.getParameter("password"));
		// persist to datastore
		//ofy().save().entity(s).now();
		resp.sendRedirect("/CreateStream.html");
	}
}
	
