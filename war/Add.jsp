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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset="utf-8">
<title>Talent-Match - Add</title>
<meta name="description"
	content="File Upload widget with multiple file selection, drag&amp;drop support, progress bars, validation and preview images, audio and video for jQuery. Supports cross-domain, chunked and resumable file uploads and client-side image resizing. Works with any server-side platform (PHP, Python, Ruby on Rails, Java, Node.js, Go etc.) that supports standard HTML form file uploads.">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

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
		<h1>Add Postings</h1>
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
<ul class="nav nav-pills">
			<li><a href="/Manage.jsp">Manage</a></li>
			<li class="active"><a href="/Add.jsp">Add Postings</a></li>
			<li><a href="/Manage.jsp">Search</a></li>
		</ul>
		<hr>
	<!--  APT: this can be static so we put in html not jsp. Note that the added stream may take a few seconds to show up, 
so the ViewAllStreams.jsp that createStreamServlet redirects to may not contain the stream that's just been added -->
<div class="container">
<br>
	<!-- form name="createStreamInput" action="createStreamServlet"
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
	</form-->
	<form name="createStreamInput" action="createStreamServlet"	method="get">
	
		<div class="row">
		<label for="1" class="col-sm-1 control-label">
		Job ID</label>
		<div class="col-sm-2">
		<input type="text" id="1" name="jobID" required class="form-control" placeholder="Enter JobID"><br>  
		</div>
		</div>

		<div class="row">
		<label for="2" class="col-sm-1 control-label">
		Job Title</label>
		<div class="col-sm-3">
		<input type="text" name="title" id="2" class="form-control" placeholder="Enter job title. Eg. Java Developer"><br>  
		</div>
		</div>
		
		<div class="row">
		<label for="3" class="col-sm-1 control-label">
		Category </label>  <div class="col-sm-2">
		<input type="text" required name="category" id="3" class="form-control" placeholder="Eg. Dev, Test, etc."><br>  
		</div>
		</div>
		
		<div class="row">
		<label for="3" class="col-sm-1 control-label">
		Location</label> <div class="col-sm-2">
		<input type="text" id="3" required name="location" class="form-control" placeholder="Enter Location"> <br>
		</div>
		</div>
		
		<div class="row">
		<label for="4" class="col-sm-1 control-label">
		Skills </label>  <div class="col-sm-5">
		<input type="text" required name="skills" id="4" class="form-control" placeholder="Eg. Java, C, C++, Python, Ruby, etc."><br>  
		</div>
		</div>

		<div class="row">	
		<label for="5" class="col-sm-1 control-label">
		Experience Required </label><div class="col-sm-2">
		<input id="5" type="text" name="experience" class="form-control" placeholder="In years"><br>  
		</div>
		</div>
		
		<div class="row">
		<label for="6" class="col-sm-1 control-label">
		Manager </label>  <div class="col-sm-3">
		<input type="text" required name="hiringManager" id="6" class="form-control" placeholder="Enter hiring manager's name"><br>  
		</div>
		</div>
		
		<div class="row">
		<label for="7" class="col-sm-1 control-label">
		Manager's Email </label>  <div class="col-sm-3">
		<input type="text" required name="hiringManagerEmail" id="7" class="form-control" placeholder="Enter manager's email address"><br>  
		</div>
		</div>
		

		<br> <input type="hidden" name="user"
			value=${fn:escapeXml(user.nickname)}>
		 <input	type="submit" class="btn btn-success" value="Submit"><i class="icon-white icon-ok-sign"></i>
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
</div>


</body>
</html>