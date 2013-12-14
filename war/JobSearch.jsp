<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<%@ page import="com.adnan.JobSeeker"%>
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
		String u = user.getNickname().toString();
		out.println("User: "+ u);
		//String[] streams = streamName.split(",");
		//for (int i = 0; i < streams.length; i++) {

		List<JobSeeker> th = OfyService.ofy().load()
				.type(JobSeeker.class).list();
		Collections.sort(th);
		for (JobSeeker s : th) {
			if (s.postOwner.equals(u)) {

				System.out.println(s.interests);
				System.out.println(s.jobtype);
				System.out.println(s.zipcode);
				String interests="";
				String[] keywords=s.interests.split(",");
				
				for(int i=0; i<keywords.length; i++) {
					
					String keys[] = keywords[i].split(" ");
					keywords[i]="";
					for (int j = 0; j < keys.length; j++) {
						if (j == keys.length-1)
							keywords[i] += keys[j];
						else
							keywords[i] += keys[j] + "%20";
					}
					
					
					if (i == keywords.length-1)
						interests += keywords[i];
					else
						interests+=keywords[i]+ "%2C";
				}
				String loc="";
				if(s.zipcode.trim()==null)
					loc=s.city+"%2C"+s.state;
				else
					loc=s.zipcode;
				
				
				url="http://api.indeed.com/ads/apisearch?publisher=6705693449394920&format=json&highlight=1&q=" + 
				interests+"&l="+loc+"&jt="+s.jobtype+"&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2";

				/*url = "https://api.github.com/search/users?q=language:"
						+ s.skills.toLowerCase()
						+ "+location:"
						+ newLoc
						+ "&sort=stars&order=desc";
*/
				//url="http://api.indeed.com/ads/apisearch?publisher=6705693449394920&format=json&highlight=1&q=java&l=austin%2C+tx&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2";

				out.println("\n" + url + "\n");

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
				//out.println(jsonString);
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
			
			<th>#</th>
			<th>Job Title</th>
			<th>Company</th>
			<th>Location</th>
			<th>Description Snippet</th>
			<th>Last Updated</th>
			<th>Posted Date</th>
			
		</tr>
		
	<script>

	var newj = <%=jsonString%>
	var xmlHttp = null;
	//var theUrl="https://api.github.com/search/users?q=language:Ruby+location:Boston%20&sort=followers";
    
	//document.write(theUrl);
	//var newj= JSON.parse(theUrl);
	//var contact= JSON.parse(contact[0]);
	//document.write("<br> QueryURL: " + theUrl + "<br>" );
	for (var i=0;i<10;i++)
{ 
	/*document.write("<br> UserName: " + newj.items[i].login + 
			" 		URL: " +newj.items[i].url
			+ " avatar_url" + newj.items[i].avatar_url
			+ " html_url" + newj.items[i].html_url			
	);*/
	var sn = i+1;
	document.write("<tr bgcolor=\"#FFFFFF\"><td>"+sn+"</td><td><a href="+newj.results[i].url+">" + newj.results[i].jobtitle+"</a></td><td>"+
			newj.results[i].company+ "</td><td>" + newj.results[i].formattedLocation+ "</td><td>"+ 
			newj.results[i].snippet + "</td><td>"+ newj.results[i].formattedRelativeTime + "</td><td>"
			+ newj.results[i].date +"</td></tr>"
			);
	
}
	</script>
	


	</table>
	</div>
</body>
</html>