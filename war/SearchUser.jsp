<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<%@ page import="com.adnan.AddPosting"%>
<%@ page import="com.adnan.OfyService"%>

<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.DataOutputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset="utf-8">
<title>Talent-Match - Search Results</title>
<meta name="description"
	content="File Upload widget with multiple file selection, drag&amp;drop support, progress bars, validation and preview images, audio and video for jQuery. Supports cross-domain, chunked and resumable file uploads and client-side image resizing. Works with any server-side platform (PHP, Python, Ruby on Rails, Java, Node.js, Go etc.) that supports standard HTML form file uploads.">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

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
		<h1>Search Results</h1>
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
			<li><a href="/Add.jsp">Add Postings</a></li>
			<li class="active"><a href="/Manage.jsp">Search</a></li>
		</ul>
		<hr>
		
<div class="container">
<h2>User Details </h2>


	
	<%
		String u = user.getEmail();
		String url1="";
		String url2="";
		String jsonString1="";	
		String jsonString2="";	
		String email="";
		//Long streamId = new Long(request.getParameter("streamId"));
		String jobID = request.getParameter("jobID");
		String login = request.getParameter("username");
		//String[] streams = streamName.split(",");
		//for (int i = 0; i < streams.length; i++) {

		List<AddPosting> th = OfyService.ofy().load()
				.type(AddPosting.class).list();
		Collections.sort(th);
		for (AddPosting s : th) {
			if (s.jobID.equals(jobID)) {
				email=s.hiringManagerEmail;
				System.out.println(s.jobID);
				System.out.println(s.title);
				System.out.println(s.category);
				System.out.println(s.skills);
				System.out.println(s.experience);
				System.out.println(s.hiringManager);
				System.out.println(s.hiringManagerEmail);
				String newLoc = "";
				String loc[] = s.location.split(" ");
				for (int i = 0; i < loc.length; i++) {
					if (i == loc.length)
						newLoc += loc[i];
					else
						newLoc += loc[i] + "%20";
				}
				
				
				
				url1 = "https://api.github.com/users/" + login;
				//out.println("\n" + url1 + "<br>" + url2);

								
				/////////

				/////////////

				//OfyService.ofy().save().entity(s).now();
				//OfyService.ofy().delete().entity(s);
			}
		}
		//}
		//response.sendRedirect("/Manage.jsp");
	%>
	
	
	<script>
	var theUrl = "<%=url1%>";
	var job = "<%=jobID%>";
	var emailM = "<%=email%>";
	var u = "<%=u%>";
	var userUrl = theUrl + "?client_id=174ccdc41e7df33ca09b&client_secret=1c8cd4be4ba471dde2d7561416dd95be20cf9731";
	var xmlHttp1 = null;
	//var theUrl="https://api.github.com/search/users?q=language:Ruby+location:Boston%20&sort=followers";
    xmlHttp1 = new XMLHttpRequest();
    xmlHttp1.open( "GET", userUrl, false );
    xmlHttp1.send( null );
	//document.write(xmlHttp1.responseText);
	var newj1= JSON.parse(xmlHttp1.responseText);
	//var contact= JSON.parse(contact[0]);
	
	/*document.write("<br> QueryURL: " + userUrl + "  "
			+newj1.name + "  "+ newj1.company+ "  " + newj1.blog + "  "
				+ newj1.location + "  "+ newj1.email + "  "+ newj1.bio + "  "
				+ newj1.public_repos + "  "+ newj1.followers + "  "+ newj1.created_at 	+ "<br>" 	
	
				
	);*/
	var repoURL = "https://github.com/"+newj1.login+"/?tab=repositories";
	var followersURL = "https://github.com/"+newj1.login+"/followers";
	document.write("<img src=\""+newj1.avatar_url+ "\" width=\"150\" height=\"150\" alt=\"Broken Image\"><br><br>");
	document.write("<table bgcolor=\"#FFFFFF\" class=\"table table-striped tablesorter\"> <tr bgcolor=\"#3366CC\"> 	<th></th> 	<th>Details</th>" +
	"</tr><tr bgcolor=\"#FFFFFF\"><td><b>Name</b></td><td>"+"<a href="+newj1.html_url+" target=\"_blank\">"+
			newj1.name +"</a></td><td></tr><tr bgcolor=\"#FFFFFF\"><td><b>Company</b></td><td>"+newj1.company+
			"</td><td></tr><tr bgcolor=\"#FFFFFF\"><td><b>Location</b></td><td>"+
			newj1.location+ "</td></tr><tr bgcolor=\"#FFFFFF\"><td><b># of Repositories</b></td><td><a href=" 
			+repoURL + " target=\"_blank\">" + newj1.public_repos + 
			"</a></td></tr><tr bgcolor=\"#FFFFFF\"><td><b># of Followers<b></td><td><a href="+ followersURL
			+ " target=\"_blank\">" + newj1.followers + "</a></td></tr><tr bgcolor=\"#FFFFFF\"><td><b>Contact Email</b></td><td>"+
			newj1.email+ "</td></tr><tr bgcolor=\"#FFFFFF\"><td><b>Member Since</b></td><td>"+ 
			newj1.created_at.substring(0,10) +"</td></tr>"
			);
	

	</script>


	</table>

<%
//var parameters = "?jobID=" + <%=jobID + "&email=" + <%=email +"&userlink=" + linkuser; 
				
		//alert(parameters);
		%>
		
<script>

//alert(emailM);

	function email() {
		var result = newj1.html_url;
		
		var linkuser = "&username="+newj1.login;
		var parameters = "/EmailManager?jobID=" + job + "&email=" + emailM + linkuser +"&from=" + u; 
		//alert(parameters);
		
		window.location.href = parameters;
		
		
	}
</script>
	<div class="pull-left">
		<input id="em" type="button" value="Email Profile to the Hiring manager" class="btn btn-success"
		onclick='email()'>
		</div>

<br><br><br>
<br>
	
</body>
</html>