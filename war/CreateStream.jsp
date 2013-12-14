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
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
<!-- Generic page styles -->
<link rel="stylesheet" href="css/style.css">
<!-- blueimp Gallery styles -->
<link rel="stylesheet"
	href="http://blueimp.github.io/Gallery/css/blueimp-gallery.min.css">
<!-- link type="text/css" rel="stylesheet" href="/stylesheets/main.css" /-->
<noscript>
	<link rel="stylesheet" href="css/jquery.fileupload-noscript.css">
</noscript>
<noscript>
	<link rel="stylesheet" href="css/jquery.fileupload-ui-noscript.css">
</noscript>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<link type="text/css" rel="stylesheet" href="css/style1.css" />

</head>
<body background="backgrd.jpeg">
	<div class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-fixed-top .navbar-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="https://talent-match.appspot.com">Talent-Match
				</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">

					<li><a href="https://github.com/apt-fall13/donna_vakharia.git">Source
							Code</a></li>

					<li><a href="https://cs.utexas.edu/~donna">&copy; Donna
							Vakharia</a></li>
				</ul>
			</div>
		</div>
	</div>
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
	<ul class="nav nav-tabs">
			<li><a href="/Manage.jsp">Manage</a></li>
			<li class="active"><a href="/CreateStream.jsp">Add Postings</a></li>
			<li><a href="/ViewAllStreams.jsp">View</a></li>
			<li><a href="/Search.jsp">Search</a></li>
			<li><a href="/TrendingResults.jsp">Trending</a></li>
			<li><a href="/FacebookLogin.jsp">Social</a></li>
		</ul>

	<!--  APT: this can be static so we put in html not jsp. Note that the added stream may take a few seconds to show up, 
so the ViewAllStreams.jsp that createStreamServlet redirects to may not contain the stream that's just been added -->
<body>
<div class="container">
	<h2>Add Postings</h2>
	
	<form name="createStreamInput" action="createStreamServlet"
		method="get">
		Job ID: <input type="text" name="jobID" required><br>  <br>
		Job Title: <input type="text" name="title"><br>  <br>
		Category: <input type="text" name="category"><br>  <br>
		Location: <input type="text" name="location"><br>  <br>
		Skills: <input type="text" name="skills"><br>  <br>
		Experience Required: <input type="text" name="experience"><br>  <br>
		Manager:<input type="text" name="hiringManager"><br>  <br>
		Manager's Contact Info (email):<input type="text" name="hiringManagerEmail"><br>  <br>
		<br> <input type="hidden" name="user"
			value=${fn:escapeXml(user.nickname)}>
		<br> <input	type="submit" value="Add">
	</form>

	<!--form name="createStreamInput" action="createStreamServlet"
		method="get">
		<input type="text" name="streamName"><br> Name your
		stream <br>
		<br> <input type="text" name="tags"><br> Tag your
		stream <br>
		<br> <input type="text" name="subscribers"><br> Add
		Subscribers <br>
		<br> <input type="text" name="message"><br> Optional
		Message for Invite <br>
		<br> <input type="text" name="url"><br> URL to cover
		image (Can be empty)<br>
		<br> <input type="hidden" name="user"
			value=${fn:escapeXml(user.nickname)}>
		<br> <input	type="submit" value="Create Stream">
	</form-->
</div>
</body>
</html>