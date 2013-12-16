<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.JobSeeker"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>

<%@ page import="com.adnan.OfyService"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset="utf-8">
<title>Talent-Match - Edit Profile</title>
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
			<h1>Create Profile</h1>
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
			<li class="active"><a href="/CreateProfile.jsp">Create Profile</a>
			<li><a href="/JobSearch.jsp">Indeed Jobs</a></li>
			<li><a href="/CBJobSearch.jsp">Careerbuilder Jobs</a></li>
			<li><a href="/GeoSearch.jsp">GeoSearch</a></li>
			
		</ul>
		<hr>






	<!--  APT: this can be static so we put in html not jsp. Note that the added stream may take a few seconds to show up, 
so the ViewAllStreams.jsp that createStreamServlet redirects to may not contain the stream that's just been added -->

	
	<%
				List<JobSeeker> th = OfyService.ofy().load().type(JobSeeker.class)
						.list();
	String name = user.getNickname();
 	String email = user.getEmail();
							
				for (JobSeeker s : th) {
					if (s.postOwner != null && s.postOwner.equals(name)) {
	
	
	%>
	
	<form name="updateProfileInput" action="UpdateProfileServlet"
		method="get">
		<fieldset>
		<div class="row">
		<label for="1" class="col-sm-1 control-label">First Name</label>
		<div class="col-sm-2">
		<input type="text" id="1" name="firstname" required class="form-control" value="<%=s.firstname%>" placeholder="Enter your first name"><br>  
		</div>

		<label for="2" class="col-sm-1 control-label">Last Name</label>
		<div class="col-sm-2">
		<input type="text" name="lastname" id="2" class="form-control" value="<%=s.lastname%>" placeholder="Enter your last name"><br>  
		</div>
		</div>
		
		<div class="row">
		<label for="3" class="col-sm-1 control-label">
		Interests</label> <div class="col-sm-5">
		<input type="text" id="3" required name="interests" class="form-control" value="<%=s.interests%>" placeholder="E.g. Java, Big Data, Python, Web Development, C++, SQL"><i>Use comma "," as separator</i><br>  <br>
		
		</div>
		</div>
		
		<div class="row">
		<label for="4" class="col-sm-1 control-label">
		Email </label>  <div class="col-sm-3">
		<input type="text" required name="email" id="4" class="form-control" value="<%=s.email%>"><br>  
		</div>
		</div>
			
		
		<div class="row">
		<label for="5" class="col-sm-1 control-label">
		City</label><div class="col-sm-2">
		<input id="5" type="text" name="city" class="form-control" value="<%=s.city%>"><br>  
		</div>
		
		<label for="6" class="col-sm-1 control-label">
		State: </label><div class="col-sm-2">
		<input id="6" type="text" name="state" class="form-control" value="<%=s.state%>"><br>  
		</div>
		</div>
		
		<div class="row">
		<label for="7" class="col-sm-1 control-label">
		Country: </label> <div class="col-sm-3">
		<input id="7" type="text" name="country" class="form-control" value="<%=s.country%>"><br>  
		</div>
		</div>
		<br>
		<div class="row">
		<label for="8" class="col-sm-1 control-label">
		Zip-Code</label>
		<div class="col-sm-2">
		<input type="text" id="8" name="zipcode" class="form-control" value="<%=s.zipcode%>" placeholder="Enter ZipCode"><br>  
		</div>
		</div>
		
		<div class="row">
		<label for="9" class="col-sm-1 control-label">
		Preferred Type</label><div class="col-sm-2">
		<select name="jobtype" id="9" class="form-control" value="<%=s.jobtype%>">
<option value="fulltime">Full-time</option>
<option value="parttime">Part-time</option>
<option value="contract">Contract</option>
<option value="internship">Internship</option>
<option value="temporary">Temporary</option>
</select>
</div>
</div>
</fieldset>
		<br> <input type="hidden" name="user"
			value=${fn:escapeXml(user.nickname)}>
		 <input	type="submit" class="btn btn-success" value="Update Profile"><i class="icon-white icon-ok-sign"></i>
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
	
	<%} }  %>
	
</div>
</div>
</body>
</html>