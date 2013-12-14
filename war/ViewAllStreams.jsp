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
	<a href="/TrendingResults.jsp">Trending</a> |
	<a href="/FacebookLogin.jsp">Social</a>


	<h2>View All Streams</h2>
	
	<table border="0">
	
			 <col width="220">
			 <col width="220">
			  <col width="220">
			 <col width="220">
			 <col width="220">
	<tr>
		<%
			List<Stream> th = OfyService.ofy().load().type(Stream.class).list();
			Collections.sort(th);
			int count=1;
			int size = th.size();
			
				
				//for(int i=0; i<size; i++){
					for (Stream s : th) {
						String output = " <div class=\"img\"><img width=\"150\" height=\"150\" src=\"" + s.coverImageUrl+ "\">" + "<br>" + "<a href=\"ShowStream.jsp?streamId=" + s.id + "&streamName=" + s.name + "&nextImage=0\">" + "<div style=\'width: 150; text-align: center;\'>"+s.name + "</div></a>";
				    if (((count++) % 4)==0){
				        out.println("<td>"+output+"</td></tr><tr>");
				    }else{
				        out.println("<td>"+output+"</td>");
				    }
				}
				//}
			%>
		
	</table>
</body>
</html>