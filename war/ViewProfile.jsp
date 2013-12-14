<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.JobSeeker"%>
<%@ page import="com.adnan.ConnexusImage"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
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

<script>
	function getValues() {
		var cbs = document.getElementsByName('chkBox');
		var result = '';

		for ( var i = 0; i < cbs.length; i++) {
			if (cbs[i].checked)
				result += (result.length > 0 ? "," : "") + cbs[i].value;
		}
		//alert(result);
		window.location.href = "/JobSearch.jsp";
		return result;
	}

	function getValuesUnsubscribe() {
		var cbs = document.getElementsByName('chkBox_un');
		var result = '';

		for ( var i = 0; i < cbs.length; i++) {
			if (cbs[i].checked)
				result += (result.length > 0 ? "," : "") + cbs[i].value;
		}
		//alert(result);
		window.location.href = "/Unsubscribe.jsp?streamName=".concat(result);
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

	<ul class="nav nav-tabs">
		<li class="active"><a href="/ViewProfile.jsp">My Profile</a></li>
		<li><a href="/JobSearch.jsp">Recommended Jobs</a></li>
		<li><a href="/ViewAllStreams.jsp">View</a></li>
		<li><a href="/Search.jsp">Search</a></li>
		<li><a href="/TrendingResults.jsp">Trending</a></li>
		<li><a href="/FacebookLogin.jsp">Social</a></li>
	</ul>
	<div class="container">
		<h2>My Jobs</h2>
		<table bgcolor="#FFFFFF" class="table table-striped tablesorter">
			<tr>

			</tr>
			<%
				List<JobSeeker> th = OfyService.ofy().load().type(JobSeeker.class)
						.list();

				Collections.sort(th);
				//String name="test@example.com";
				for (JobSeeker s : th) {
					if (s.postOwner != null && s.postOwner.equals(name)) {
						// APT: calls to System.out.println go to the console, calls to out.println go to the html returned to browser
						// the line below is useful when debugging (jsp or servlet)
						//System.out.println("s = " + s);
						//List<ConnexusImage> images = OfyService.ofy().load().type(ConnexusImage.class).list();
						//Collections.sort(images);
			%>
			<tr bgcolor="#FFFFFF">
				<td>First Name:</td>
				<td><%=s.firstname%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>Last Name:</td>
				<td><%=s.lastname%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>Interests:</td>
				<td><%=s.interests%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>Email:</td>
				<td><%=s.email%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>City:</td>
				<td><%=s.city%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>State:</td>
				<td><%=s.state%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>Country:</td>
				<td><%=s.country%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>Zip Code:</td>
				<td><%=s.zipcode%></td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>Looking for:</td>
				<td><%=s.jobtype%></td>
			</tr>
			<%
				}
				}
			%>
			<br>
		</table>
		<br> <input id="delete" type="button" value="Search"
			onclick='getValues()'>
	</div>
</body>
</html>