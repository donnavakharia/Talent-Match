<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.AddPosting" %>
<%@ page import="com.adnan.ConnexusImage"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Collections"%>

<%@ page import="com.adnan.OfyService"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset="utf-8">
<title>Talent-Match - Manage</title>
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

<script>
	function getValues() {
		var cbs = document.getElementsByName('searchjob');
		var result = '';

		for ( var i = 0; i < cbs.length; i++) {
			if (cbs[i].checked)
				result += (result.length > 0 ? "," : "") + cbs[i].value;
		}
		//alert(result);
		window.location.href = "/SearchGithub.jsp?jobID=".concat(result);
		return result;
	}
	
	function deleteValues() {
		var cbs = document.getElementsByName('chkBox');
		var result = '';

		for ( var i = 0; i < cbs.length; i++) {
			if (cbs[i].checked)
				result += (result.length > 0 ? "," : "") + cbs[i].value;
		}
		//alert(result);
		window.location.href = "/Delete.jsp?jobid=".concat(result);
		return result;
	}
</script>
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
		<h1>My Jobs</h1>
	<right> <%
 	UserService userService = UserServiceFactory.getUserService();
 	User user = userService.getCurrentUser();
 	if (user != null) {
 		pageContext.setAttribute("user", user);
 	}
 	String name = user.getNickname();
 	String email = user.getEmail();
 %><p align=right>
		Hello, ${fn:escapeXml(user.nickname)}! <a
			href="<%=userService.createLogoutURL("/Welcome.jsp",
					request.getRequestURI())%>">Sign
			out</a>
	</p>
	</right>

		<ul class="nav nav-pills">
			<li class="active"><a href="/Manage.jsp">Manage</a></li>
			<li><a href="/Add.jsp">Add Postings</a></li>
			<li><a href="/Manage.jsp">Search</a></li>
		</ul>
		<hr>
<div class="container">
	
	<table bgcolor="#FFFFFF" class="table table-striped tablesorter">
		<tr>
			<th> </th>
			<th>JobID</th>
			<th>Title</th>
			<th>Category</th>
			<th>Location</th>
			<th>Skills</th>
			<th>Experience</th>
			<th>Manager</th>
			<th>Contact Email</th>
			<th>Delete</th>
		</tr>
		<%
			List<AddPosting> th = OfyService.ofy().load().type(AddPosting.class).list();
		
			Collections.sort(th);
			//String name="test@example.com";
			for (AddPosting s : th) {
				if (s.postOwner != null && s.postOwner.equals(name)) {
					// APT: calls to System.out.println go to the console, calls to out.println go to the html returned to browser
					// the line below is useful when debugging (jsp or servlet)
					//System.out.println("s = " + s);
					//List<ConnexusImage> images = OfyService.ofy().load().type(ConnexusImage.class).list();
					//Collections.sort(images);
					
		%>
		<tr bgcolor="#FFFFFF">
			<td><input type="radio" id="<%=s.jobID%>" name="searchjob"
				value='<%=s.jobID%>'><br></td>
			<td><%=s.jobID%></td>
			
			<td><%=s.title%></td>

			<td><%=s.category%></td>
				<td><%=s.location%></td>
				<td><%=s.skills%></td>
				<td><%=s.experience%></td>
				<td><%=s.hiringManager%></td>
				<td><%=s.hiringManagerEmail%></td>
				<td><input type="checkbox" id="<%=s.jobID%>" name="chkBox"
				value='<%=s.jobID%>'><br></td>
		<tr bgcolor="#FFFFFF">


			<%
				}
				}
			%>
			<br>
	</table>
	
	<i>*Select one of the radio buttons and click on Search to find matching profiles</i><br>
	<br>
	<input id="search" type="button" value="Search" class="btn btn-success"
		onclick='getValues()'>
		<div class="pull-right">
		<input id="delete" type="button" value="Delete Marked Jobs" class="btn btn-danger"
		onclick='deleteValues()'>
		</div>
	</div>
	</div>
</body>
</html>