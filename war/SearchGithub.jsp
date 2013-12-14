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
			<li><a href="/CreateStream.jsp">Add Postings</a></li>
			<li><a href="/ViewAllStreams.jsp">View</a></li>
			<li><a href="/Search.jsp">Search</a></li>
			<li><a href="/TrendingResults.jsp">Trending</a></li>
			<li><a href="/FacebookLogin.jsp">Social</a></li>
		</ul>
		
<div class="container">

	<br>
	<br>
	<%
		String url="";
		String jsonString="";	
		//Long streamId = new Long(request.getParameter("streamId"));
		String jobID = request.getParameter("jobID");
		//String[] streams = streamName.split(",");
		//for (int i = 0; i < streams.length; i++) {

		List<AddPosting> th = OfyService.ofy().load()
				.type(AddPosting.class).list();
		Collections.sort(th);
		for (AddPosting s : th) {
			if (s.jobID.equals(jobID)) {

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

				url = "https://api.github.com/search/users?q=language:"
						+ s.skills.toLowerCase()
						+ "+location:"
						+ newLoc
						+ "&sort=stars&order=desc";

				//out.println("\n" + url + "\n");

				URL obj = new URL(url);
				HttpURLConnection con = (HttpURLConnection) obj
						.openConnection();

				// optional default is GET
				con.setRequestMethod("GET");

				//add request header
				con.setRequestProperty("User-Agent", "Mozilla/5.0");

				int responseCode = con.getResponseCode();
				System.out.println("\nSending 'GET' request to URL : "
						+ url);
				System.out.println("Response Code : " + responseCode);

				BufferedReader in = new BufferedReader(
						new InputStreamReader(con.getInputStream()));
				String inputLine;
				StringBuffer response1 = new StringBuffer();

				while ((inputLine = in.readLine()) != null) {
					response1.append(inputLine);
				}
				in.close();

				//print result
				//out.println(response1.toString());
				jsonString=response1.toString();
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
			
			<th>Name</th>
			<th>Company</th>
			<th>Location</th>
			<th># of Public Repos</th>
			<th># of Followers</th>
			<th>Contact Info</th>
			<th>Score</th>
			<th>Member since</th>
			
		</tr>
	<script>
	var theUrl = "<%=url%>";
	var xmlHttp = null;
	//var theUrl="https://api.github.com/search/users?q=language:Ruby+location:Boston%20&sort=followers";
    xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", theUrl, false );
    xmlHttp.send( null );
	//document.write(xmlHttp.responseText);
	var newj= JSON.parse(xmlHttp.responseText);
	//var contact= JSON.parse(contact[0]);
	//document.write("<br> QueryURL: " + theUrl + "<br>" );
	for (var i=0;i<newj.total_count;i++)
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
	document.write("<tr bgcolor=\"#FFFFFF\"><td>"+newj1.name+"</td><td>"+newj1.company+"</td><td>"+
			newj1.location+ "</td><td>" + newj1.public_repos + "</td><td>"+ 
			newj1.followers + "</td><td>"+newj1.email+ "</td><td>"+ newj.items[i].score + "</td><td>"
			+ newj1.created_at.substring(0,10) +"</td></tr>"
			);
	
}
	</script>

	</table>
	</div>
</body>
</html>