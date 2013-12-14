<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="com.adnan.Stream"%>

<%@ page import="com.adnan.LeaderShipEntity "%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="com.adnan.Type"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.lang.*"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<h1>Connex.us</h1>
<body>
	<right> <%
 	UserService userService = UserServiceFactory.getUserService();
 	User user = userService.getCurrentUser();
 	if (user != null) {
 		pageContext.setAttribute("user", user);
 	}
 %><p align=right>
		Hello, ${fn:escapeXml(user.nickname)}! <a
			href="<%=userService.createLogoutURL("/Welcome.jsp",
					request.getRequestURI())%>">Sign
			out</a>
	</p>
	</right>
	<a href="/Manage.jsp">Manage</a> |
	<a href="/CreateStream.jsp">Create</a> |
	<a href="/ViewAllStreams.jsp">View</a> |
	<a href="/Search.jsp">Search</a> |
	<a href="/TrendingResults.jsp">Trending</a> |
	<a href="/FacebookLogin.jsp">Social</a>

	<br>
	<br>



	<div id="content">
		<table border="0">
			<col width="800">
			<col width="200">
			<tr>
				<td>
					<h2>Top 3 trending streams</h2> <%
 	List<Stream> records = OfyService.ofy().load().type(Stream.class)
 			.list();
 	Collections.sort(records);
 	List<LeaderShipEntity> top = OfyService.ofy().load()
 			.type(LeaderShipEntity.class).list();
 	Collections.sort(top);
 	String message = "";
 	String newMsg = "msg";

 	int myID = 0;
 	if (!top.isEmpty()) {
 		
 		Date max = top.get(0).getCreateDate();
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
 		String v1 = "";
 		String v2 = "";
 		String v3 = "";
 %>

					<table border="0">

						<col width="200">
						<col width="200">
						<col width="200">
						<tr>

							<%
								for (Stream s : records) {
										if (stream1.equals(s.name)) {
											String viewcount = String.valueOf(viewcount1);
											//message = message + "Stream 1- " + stream1 + " ViewCount- " + viewcount1;
							%>
							<td>
								<div class="img">
									<img width="100" height="100" src="<%=s.coverImageUrl%>"
										alt="Cover Image"> <a class="img_desc"
										href="ShowStream.jsp?streamId=<%=s.id%>&streamName=<%=s.name%>&nextImage=0">
										<div style='width: 100; text-align: center;'><%=s.name%></div>
										<div style='width: 100; text-align: center;'><%=viewcount%>
											views in past hour
										</div>

									</a>

								</div>
							</td>

							<%
								}

										if (stream2.equals(s.name)) {
											String viewcount = String.valueOf(viewcount2);
											// message = message + "Stream 2- " + stream2 + " ViewCount- " + viewcount2;
							%>
							<td>
								<div class="img">
									<img width="100" height="100" src="<%=s.coverImageUrl%>"
										alt="Cover Image"> <a class="img_desc"
										href="ShowStream.jsp?streamId=<%=s.id%>&streamName=<%=s.name%>&nextImage=0">
										<div style='width: 100; text-align: center;'><%=s.name%></div>
										<div style='width: 100; text-align: center;'><%=viewcount%>
											views in past hour
										</div>
									</a>

								</div>
							</td>

							<%
								}

										if (stream3.equals(s.name)) {
											String viewcount = String.valueOf(viewcount3);
							%>
							<td>
								<div class="img">
									<img width="100" height="100" src="<%=s.coverImageUrl%>"
										alt="Cover image"> <a class="img_desc"
										href="ShowStream.jsp?streamId=<%=s.id%>&streamName=<%=s.name%>&nextImage=0">
										<div style='width: 100; text-align: center;'><%=s.name%></div>
										<div style='width: 100; text-align: center;'><%=viewcount%>
											views in past hour
										</div>
									</a>

								</div>

								</div>
							</td>
							<%
								}

									}
									message = "Top Trending Streams - Stream 1- " + stream1
											+ "      ViewCount- " + viewcount1 + "      Stream 2- "
											+ stream2 + "       ViewCount- " + viewcount2
											+ "        Stream 3- " + stream3 + "       ViewCount- "
											+ viewcount3;

									newMsg = message.replaceAll(" ", "%20");

								}
							%>
							</td>
						</tr>
					</table>
				</td>
				<td valign="top">


					<table>
						<h3>Email Trending Report</h3>
						<form name="emailReport" action="UpdateSchedule" method="get">
							<tr>
								<input type="radio" id="opt" name="chkBox_report" value='0'>No
								Reports
								<br>
							</tr>
							<tr>
								<input type="radio" id="opt" name="chkBox_report" value='5'>Every
								5 minutes
								<br>
							</tr>
							<tr>
								<input type="radio" id="opt" name="chkBox_report" value='1'>Every
								1 hour
								<br>
							</tr>
							<tr>
								<input type="radio" id="opt" name="chkBox_report" value='24'>Every
								day
								<br>
							</tr>
					</table> <!-- input type="hidden" name="message" value=<%=newMsg%>--> <br>
					<input type="submit" value="Update Rate"> <!-- input id="send" type="button" value="Update Rate"-->
					</form>
			</tr>
		</table>
	</div>
	</div>
</body>
</html>

