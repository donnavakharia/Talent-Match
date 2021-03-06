<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>
<%@ page import="org.json.JSONException"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.XML"%>
<%@ page import="com.adnan.JobSeeker"%>
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
<title>Talent-Match - CareerBuilder Jobs</title>
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
		<h1>Recommended jobs from CareerBuilder</h1>
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
			<li><a href="/ViewProfile.jsp">Profile</a></li>
			<li><a href="/JobSearch.jsp">Indeed Jobs</a></li>
			<li class="active"><a href="/CBJobSearch.jsp">Careerbuilder Jobs</a></li>
			<li><a href="/GeoSearch.jsp">GeoSearch</a></li>
		</ul>
		<hr>
<div class="container">

	
	<%
		String url="";
		String jsonString="";	
		String jsonPrettyPrintString="";
		int PRETTY_PRINT_INDENT_FACTOR = 4;
		//Long streamId = new Long(request.getParameter("streamId"));
		String u = user.getNickname().toString();
		//out.println("User: "+ u);
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
				
				
				url="http://api.careerbuilder.com/v1/jobsearch?DeveloperKey=WDHT1YG61B6HPD3NGC2Y&location="+loc+"&perPage=25&Keywords="+s.jobtype+"%2C"+interests;
				
				//url="http://api.indeed.com/ads/apisearch?publisher=6705693449394920&format=json&highlight=1&q=" + 
				//interests+"&l="+loc+"&jt="+s.jobtype+"&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2";

				/*url = "https://api.github.com/search/users?q=language:"
						+ s.skills.toLowerCase()
						+ "+location:"
						+ newLoc
						+ "&sort=stars&order=desc";
*/
				//url="http://api.indeed.com/ads/apisearch?publisher=6705693449394920&format=json&highlight=1&q=java&l=austin%2C+tx&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2";

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
				//out.println(jsonString);
				
				try {
		            JSONObject xmlJSONObj = XML.toJSONObject(jsonString);
		            jsonPrettyPrintString = xmlJSONObj.toString(PRETTY_PRINT_INDENT_FACTOR);
		            //out.println(jsonPrettyPrintString);
		        } catch (JSONException je) {
		            out.println(je.toString());
		        }
				
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

	var newj = <%=jsonPrettyPrintString%>
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
	document.write("<tr bgcolor=\"#FFFFFF\"><td>"+sn+"</td><td><a href="+newj.ResponseJobSearch.Results.JobSearchResult[i].JobDetailsURL+">" + 
			newj.ResponseJobSearch.Results.JobSearchResult[i].JobTitle+"</a></td><td><a href="+
			newj.ResponseJobSearch.Results.JobSearchResult[i].CompanyDetailsURL+">"+
			newj.ResponseJobSearch.Results.JobSearchResult[i].Company+ "<br><img src=\""+
			newj.ResponseJobSearch.Results.JobSearchResult[i].CompanyImageURL+ "\" alt=\"Broken Image\">"+"</a></td><td>" + 
			newj.ResponseJobSearch.Results.JobSearchResult[i].Location+ "</td><td>"+ 
			newj.ResponseJobSearch.Results.JobSearchResult[i].DescriptionTeaser + "</td><td>" +
			newj.ResponseJobSearch.Results.JobSearchResult[i].EmploymentType +	"</td><td>"
			+ newj.ResponseJobSearch.Results.JobSearchResult[i].PostedDate +"</td></tr>"
			);
	
}
	</script>
	


	</table>
	</div>
</body>
</html>