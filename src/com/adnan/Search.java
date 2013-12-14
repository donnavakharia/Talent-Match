package com.adnan;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Collections;

public class Search extends HttpServlet{
	@SuppressWarnings("serial")
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		String query = req.getParameter("query");
		query = query.toLowerCase();
		String sname="";
		String stags="";
		// persist to datastore
		//ofy().save().entity(s).now();
		//Collections collections;
		System.out.println("Query: " + query);
		List<Stream> th = OfyService.ofy().load().type(Stream.class).list();
		Collections.sort(th);
		
		for (Stream s : th ) {
			sname=s.name.toLowerCase();
			stags=s.tags.toLowerCase();
			if(sname.contains(query)||stags.contains(query)) {
		  // APT: calls to System.out.println go to the console, calls to out.println go to the html returned to browser
		  // the line below is useful when debugging (jsp or servlet)
				System.out.println(query);
				System.out.println("<br><h1>s = " + s);
				ofy().save().entity(s).now();
			}
		
	}
		resp.sendRedirect("/SearchResults.jsp?query="+query);
	}
}
