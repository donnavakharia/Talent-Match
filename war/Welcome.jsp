<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
<div class="container">
	<!-- img src="logo.jpeg" width="300" height="100"-->
	<img src="http://www.logomaker.com/logo-images/60456f4a75ea7c68.gif"/>
<a href="http://www.logomaker.com"><img src="http://www.logomaker.com/images/logos.gif" alt="logo design" border="0"/></a>

<%
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
%>

<table width=100% height=100%>
<tr><td width=50%><h2>Welcome recruiters! </h2><br><br>
<h4>
Talent-Match helps recruiters find matching profiles 
<br>from Github for their job postings.
<br>
<br>

<img src="octocat.jpeg">
<br>
<br>
Login to get started!
<br>
<br>
<a href="<%= userService.createLoginURL("/Manage.jsp",request.getRequestURI()) %>">
<button type="button" class="btn btn-success">Recruiter Login</button></a>
</h4>
<br>
<br>
<br>
</td>

<td width=50%><h2>Welcome Job-seekers! </h2><br><br>
<h4>
Our webapp has compiled jobs from Indeed and CareerBuilder that shows results matching your
profile without even searching for them!
<br>
<br>
<img src="indeed_logo.jpeg" width="200" height="100">
<br>
<img src="careerbuilder_logo.jpeg" width="250" height="150">
<br>
Click below to get started.
<br>
<br>
<a href="<%= userService.createLoginURL("/ViewProfile.jsp",request.getRequestURI()) %>">
<button type="button" class="btn btn-success">JobSeeker Login</button></a>
</h4>
<br>
<br>
<br>
</td></tr>


</table>


</div>

   

  </body>
</html>