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

	
	<%
		String url1="";
		String url2="";
		String jsonString1="";	
		String jsonString2="";	
		//Long streamId = new Long(request.getParameter("streamId"));
		String jobID = request.getParameter("jobID");
		//String[] streams = streamName.split(",");
		//for (int i = 0; i < streams.length; i++) {

		List<AddPosting> th = OfyService.ofy().load()
				.type(AddPosting.class).list();
		Collections.sort(th);
		for (AddPosting s : th) {
			if (s.jobID.equals(jobID)) {
				out.println("<h2>Top 5 results by location: "+s.location+"</h2>");
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

				url1 = "https://api.github.com/search/users?q=language:"
						+ s.skills.toLowerCase()
						+ "+location:"
						+ newLoc
						+ "&sort=stars&order=desc";
				url2 = "https://api.github.com/search/users?q=language:"
						+ s.skills.toLowerCase()
						+ "+location:USA"
						+ "&sort=stars&order=desc";

				//out.println("\n" + url1 + "<br>" + url2);

				URL obj1 = new URL(url1);
				URL obj2 = new URL(url2);
				HttpURLConnection con1 = (HttpURLConnection) obj1
						.openConnection();
				HttpURLConnection con2 = (HttpURLConnection) obj2
						.openConnection();
				// optional default is GET
				con1.setRequestMethod("GET");
				con2.setRequestMethod("GET");
				//add request header
				con1.setRequestProperty("User-Agent", "Mozilla/5.0");
				con2.setRequestProperty("User-Agent", "Mozilla/5.0");
				
				int responseCode1 = con1.getResponseCode();
				int responseCode2 = con2.getResponseCode();
				System.out.println("\nSending 'GET' request to URL : "
						+ url1);
				System.out.println("Response Code : " + responseCode1);

				BufferedReader in1 = new BufferedReader(
						new InputStreamReader(con1.getInputStream()));
				BufferedReader in2 = new BufferedReader(
						new InputStreamReader(con2.getInputStream()));
				String inputLine1;
				StringBuffer response1 = new StringBuffer();
				String inputLine2;
				StringBuffer response2 = new StringBuffer();

				while ((inputLine1 = in1.readLine()) != null) {
					response1.append(inputLine1);
				}
				in1.close();

				while ((inputLine2 = in2.readLine()) != null) {
					response2.append(inputLine2);
				}
				in2.close();
				
				//print result
				//out.println(response1.toString());
				jsonString1=response1.toString();
				jsonString2=response2.toString();
				/////////

				/////////////

				//OfyService.ofy().save().entity(s).now();
				//OfyService.ofy().delete().entity(s);
			}
		}
		//}
		//response.sendRedirect("/Manage.jsp");
	%>
	
	<table bgcolor="#FFFFFF" class="table table-striped tablesorter">
		<tr bgcolor="#3366CC">
			<th></th>
			<th>Name</th>
			<th>Company</th>
			<th>Location</th>
			<th># of Public Repos</th>
			<th># of Followers</th>
			<th>Contact Info</th>
			
			<th>Member since</th>
			
		</tr>
	<script>
	var theUrl = "<%=url1%>";
	var xmlHttp = null;
	//var theUrl="https://api.github.com/search/users?q=language:Ruby+location:Boston%20&sort=followers";
    xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", theUrl, false );
    xmlHttp.send( null );
	//document.write(xmlHttp.responseText);
	var newj= JSON.parse(xmlHttp.responseText);
	//var contact= JSON.parse(contact[0]);
	//document.write("<br> QueryURL: " + theUrl + "<br>" );
	for (var i=0;i<5;i++)
{ 
	/*document.write("<br> UserName: " + newj.items[i].login + 
			" 		URL: " +newj.items[i].url
			+ " avatar_url" + newj.items[i].avatar_url
			+ " html_url" + newj.items[i].html_url			
	);*/
	var userUrl = newj.items[i].url + "?client_id=174ccdc41e7df33ca09b&client_secret=1c8cd4be4ba471dde2d7561416dd95be20cf9731";
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
	var linkuser = "https://talent-match.appspot.com/SearchUser.jsp?jobID="+"<%=jobID%>"+"&username="+newj1.login;
	//alert(linkuser);
	document.write("<tr bgcolor=\"#FFFFFF\"><td>"+"<a href=" + linkuser +" target=\"_blank\">" +	
			"<img src=\""+newj1.avatar_url+ "\" width=\"100\" height=\"100\" alt=\"Broken Image\"></a></td><td>"+ "<a href="+linkuser+" target=\"_blank\">"+
			newj1.name +"</a></td><td>"+newj1.company+"</td><td>"+
			newj1.location+ "</td><td>"+ newj1.public_repos + "</td><td>" + newj1.followers + "</td><td>"+newj1.email+ "</td><td>"+ 
			newj1.created_at.substring(0,10) +"</td></tr>"
			);
	
}
	</script>


	</table>
	<script>
	function more1() {
		var	result = "<%=jobID%>";
		window.location.href = "/SearchGithubMore1.jsp?jobID=".concat(result);
		return result;
	}
</script>
<div class="pull-right">
		<input id="more1" type="button" value="More..." class="btn btn-success"
		onclick='more1()'>
		</div>
<br>
<h2>Top 5 results from USA</h2>
	
	<table bgcolor="#FFFFFF" class="table table-striped tablesorter">
		<tr bgcolor="#3366CC">
			<th></th>
			<th>Name</th>
			<th>Company</th>
			<th>Location</th>
			<th># of Public Repos</th>
			<th># of Followers</th>
			<th>Contact Info</th>
			
			<th>Member since</th>
			
		</tr>
	<script>
	var theUrl2 = "<%=url2%>";
	var xmlHttp2 = null;
	//var theUrl="https://api.github.com/search/users?q=language:Ruby+location:Boston%20&sort=followers";
    xmlHttp2 = new XMLHttpRequest();
    xmlHttp2.open( "GET", theUrl2, false );
    xmlHttp2.send( null );
	//document.write(xmlHttp.responseText);
	var newj2= JSON.parse(xmlHttp2.responseText);
	//var contact= JSON.parse(contact[0]);
	//document.write("<br> QueryURL: " + theUrl + "<br>" );
	for (var i=0;i<5;i++)
{ 
	/*document.write("<br> UserName: " + newj.items[i].login + 
			" 		URL: " +newj.items[i].url
			+ " avatar_url" + newj.items[i].avatar_url
			+ " html_url" + newj.items[i].html_url			
	);*/
	var userUrl2 = newj2.items[i].url + "?client_id=174ccdc41e7df33ca09b&client_secret=1c8cd4be4ba471dde2d7561416dd95be20cf9731";
	var xmlHttp3 = null;
	//var theUrl="https://api.github.com/search/users?q=language:Ruby+location:Boston%20&sort=followers";
    xmlHttp3 = new XMLHttpRequest();
    xmlHttp3.open( "GET", userUrl2, false );
    xmlHttp3.send( null );
	//document.write(xmlHttp1.responseText);
	var newj3= JSON.parse(xmlHttp3.responseText);
	//var contact= JSON.parse(contact[0]);
	
	/*document.write("<br> QueryURL: " + userUrl + "  "
			+newj1.name + "  "+ newj1.company+ "  " + newj1.blog + "  "
				+ newj1.location + "  "+ newj1.email + "  "+ newj1.bio + "  "
				+ newj1.public_repos + "  "+ newj1.followers + "  "+ newj1.created_at 	+ "<br>" 	
	
				
	);*/
	
	repoURL = "https://github.com/"+newj3.login+"/?tab=repositories";
	followersURL = "https://github.com/"+newj3.login+"/followers";
	linkuser = "https://talent-match.appspot.com/SearchUser.jsp?jobID="+"<%=jobID%>"+"&username="+newj3.login;
	
	document.write("<tr bgcolor=\"#FFFFFF\"><td>"+"<a href=" + linkuser +" target=\"_blank\">" +	
			"<img src=\""+newj3.avatar_url+ "\" width=\"100\" height=\"100\" alt=\"Broken Image\"></a></td><td>"+ "<a href="+linkuser+" target=\"_blank\">"+
			newj3.name +"</a></td><td>"+newj3.company+"</td><td>"+
			newj3.location+ "</td><td>"+ newj3.public_repos + "</td><td>" + newj3.followers + "</td><td>"+newj3.email+ "</td><td>"+ 
			newj3.created_at.substring(0,10) +"</td></tr>"
			);
	
}
	</script>

	</table>
		<script>
	function more2() {
		var result = "<%=jobID%>";
		//alert(result);
		window.location.href = "/SearchGithubMore2.jsp?jobID=".concat(result);
		return result;
	}
</script>
	<div class="pull-right">
		<input id="more2" type="button" value="More..." class="btn btn-success"
		onclick='more2()'>
		</div>
	</div>
	<br><br>
	
</body>
</html>