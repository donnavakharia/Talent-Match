package com.adnan;

import static com.googlecode.objectify.ObjectifyService.ofy;
import java.util.List;
import java.io.IOException;
import java.util.logging.Logger;
import com.adnan.schedule;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateSchedule extends HttpServlet{
	
	private static Logger log = Logger.getLogger(emailReport.class.getCanonicalName());
	private static String fromAddress = "donna006@gmail.com";
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

	String newSch = req.getParameter("chkBox_report");
	
	
	List<schedule> sc = OfyService.ofy().load().type(schedule.class)
			.list();
	//Collections.sort(th);
	for (schedule s : sc) {
		ofy().delete().entity(s);
	}
	
	schedule sc_new = new schedule(newSch);
	ofy().save().entity(sc_new).now();
	resp.sendRedirect("/TrendingResults.jsp");
}
	
}
