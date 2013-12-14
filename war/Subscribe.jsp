<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>

<%@ page import="com.adnan.OfyService"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<h1>Connex.us</h1>
</head>
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
	<a href="/Trending.jsp">Trending</a> |
	<a href="/FacebookLogin.jsp">Social</a>



	<%
	String email = user.getEmail();
		//Long streamId = new Long(request.getParameter("streamId"));
		String streamName = request.getParameter("streamName");
		//String[] streams = streamName.split(",");
		//for (int i = 0; i < streams.length; i++) {

			List<Stream> th = OfyService.ofy().load().type(Stream.class)
					.list();
			Collections.sort(th);
			String newSubs="";
			for (Stream s : th) {
				//for(int i=0; i<streams.length; i++) {		
					if (s.name.equals(streamName)) {
						//System.out.println("in if");
						if (s.subscribers != null) {
							
							if(!s.subscribers.contains(email))
							newSubs=s.subscribers+","+email;
							else
								newSubs=s.subscribers;
						}
						else
							newSubs=email;
					s.subscribers=newSubs;
					newSubs="";
					//System.out.println("newsub="+newSubs);
					OfyService.ofy().save().entity(s);
					
					response.sendRedirect("/Manage.jsp");
					//OfyService.ofy().delete().entity(s);
				}
			
		}
		
		
	%>
	<table>


	</table>
</body>
</html>