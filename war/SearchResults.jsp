<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<%@ page import="com.adnan.OfyService"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

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
	<h2>Search</h2>
	<form name="serach" action="/SearchResults.jsp" method="get">
		<input type="text" name="query"> <input type="submit"
			value="Search"></a>
	</form>
	<h2>Search Results:</h2>
	Click on an image to view stream <br>
	<table>
		<%
			List<Stream> th = OfyService.ofy().load().type(Stream.class).list();
			Collections.sort(th);
			int resultsCount=0;
			//String query="donna";
			String query = request.getParameter("query");
			query = query.toLowerCase();
			String sname="";
			String stags="";
			for (Stream s : th) {
				sname=s.name.toLowerCase();
				stags=s.tags.toLowerCase();
				if(sname.contains(query)||stags.contains(query)) {
					resultsCount++;
					// APT: calls to System.out.println go to the console, calls to out.println go to the html returned to browser
					// the line below is useful when debugging (jsp or servlet)
					out.println("<br><a href=\"ShowStream.jsp?streamId=" + s.id
							+ "&streamName=" + s.name + "&nextImage=0\">"
							+ "<img width=\"100\" height=\"100\"" + "src="
							+ s.coverImageUrl + "><br>" + s.name + "</a>");
				}
		%>


		<%
			}
			
			if(resultsCount==0)
			{ out.println("<br> No matching results!"); }
			else {
				out.println("<br><br>"+resultsCount+" results for <b>"+ request.getParameter("query") +"</b>"); 
			}
		%>
		

	</table>
</body>
</html>