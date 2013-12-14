package com.adnan;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Date;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.googlecode.objectify.ObjectifyService.ofy;

public class emailReport extends HttpServlet {

	private static Logger log = Logger.getLogger(emailReport.class
			.getCanonicalName());
	private static String fromAddress = "donna006@gmail.com";
	private static String toAddress = "kamran.ks+aptmini@gmail.com,donna006@gmail.com";

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		List<Stream> records = OfyService.ofy().load().type(Stream.class)
				.list();
		Collections.sort(records);
		List<LeaderShipEntity> top = OfyService.ofy().load()
				.type(LeaderShipEntity.class).list();
		Collections.sort(top);
		String message = "";
		String newMsg = "msg";
		System.out.println("number of records" + records.size() + top.size());
		int myID = 0;
		if (!top.isEmpty()) {
			Date max = top.get(0).getCreateDate();// Integer.MIN_VALUE;
			for (int i = 0; i < top.size(); i++) {
				if (top.get(i).getCreateDate().after(max)) {
					max = top.get(i).getCreateDate();
					myID = i;
				}
			}

			String stream1 = top.get(myID).getStream1();
			String stream2 = top.get(myID).getStream2();
			String stream3 = top.get(myID).getStream3();
			int viewcount1 = top.get(myID).getViewCount1();
			int viewcount2 = top.get(myID).getViewCount2();
			int viewcount3 = top.get(myID).getViewCount3();
			
			for(LeaderShipEntity le : top) {
				if(le.entry_createddate.before(max)) {
					ofy().delete().entity(le);
				}
				
			}
			
			message = "Top Trending Streams\n\nStream 1: "
					+ stream1
					+ "\tViewCount: "
					+ viewcount1
					+ "\nStream 2: "
					+ stream2
					+ "\tViewCount: "
					+ viewcount2
					+ "\nStream 3: "
					+ stream3
					+ "\tViewCount: "
					+ viewcount3
					+ "\n\n\nRegards, \nDonna Vakharia\ndmv489\nconnexus-donna.appspot.com";
		}

		String optionSelected = req.getParameter("chkBox_report");

		List<schedule> sc = OfyService.ofy().load().type(schedule.class).list();

		for (schedule s : sc) {
			String[] toAdd = toAddress.split(",");

			for (int i = 0; i < toAdd.length; i++) {
				if (s.selectedSchedule
						.equals(req.getParameter("chkBox_report"))) {
					send(toAdd[i], "Connexus: Trending Report", message);
				}
			}
		}

		resp.sendRedirect("/TrendingResults.jsp");

	}

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
			log.log(Level.SEVERE, "Address Exception , mail could not be sent",
					addressException);
		} catch (MessagingException messageException) {
			log.log(Level.SEVERE,
					"Messaging Exception , mail could not be sent",
					messageException);
		}
	}

}
