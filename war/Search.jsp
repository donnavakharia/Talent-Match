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
	<right> <%  UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
      pageContext.setAttribute("user", user);
    }
%><p align=right>
		Hello, ${fn:escapeXml(user.nickname)}! <a
			href="<%= userService.createLogoutURL("/Welcome.jsp",request.getRequestURI()) %>">Sign
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
	<form name="serach" action="/Search" method="get">
		<input type="text" name="query"> <input type="submit"
			value="Search"></a>
	</form>
	<table>




	</table>
</body>
</html>