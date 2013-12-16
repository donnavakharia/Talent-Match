<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.View"%>
<%@ page import="com.adnan.ConnexusImage"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="org.json.JSONException"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.XML"%>
<%@ page import="com.adnan.JobSeeker"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.DataOutputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>


<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%@ page
	import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>

<%@ page import="com.adnan.OfyService"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset="utf-8">
<title>Talent-Match: GeoSearch</title>
<meta name="description"
	content="File Upload widget with multiple file selection, drag&amp;drop support, progress bars, validation and preview images, audio and video for jQuery. Supports cross-domain, chunked and resumable file uploads and client-side image resizing. Works with any server-side platform (PHP, Python, Ruby on Rails, Java, Node.js, Go etc.) that supports standard HTML form file uploads.">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap styles -->
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
<!-- Generic page styles -->
<link rel="stylesheet" href="css/style.css">
<!-- blueimp Gallery styles -->
<link rel="stylesheet"
	href="http://blueimp.github.io/Gallery/css/blueimp-gallery.min.css">
<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
<link rel="stylesheet" href="css/jquery.fileupload.css">
<link rel="stylesheet" href="css/jquery.fileupload-ui.css">
<!-- CSS adjustments for browsers with JavaScript disabled -->
<noscript>
	<link rel="stylesheet" href="css/jquery.fileupload-noscript.css">
</noscript>
<noscript>
	<link rel="stylesheet" href="css/jquery.fileupload-ui-noscript.css">
</noscript>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<link type="text/css" rel="stylesheet" href="css/style1.css" />
<script type="text/javascript" src="js/jquery-1.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

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

					<li><a href="https://github.com/donnavakharia/Talent-Match">Source
							Code</a></li>

					<li><a href="https://cs.utexas.edu/~donna">&copy; Donna
							Vakharia</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="container">
			<h1> Geo-Search</h1>

<%
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
			
<ul class="nav nav-pills">
			<li><a href="/ViewProfile.jsp">Profile</a></li>
			<li><a href="/JobSearch.jsp">Indeed Jobs</a></li>
			<li><a href="/CBJobSearch.jsp">Careerbuilder Jobs</a></li>
			<li class="active"><a href="/GeoSearch.jsp">GeoSearch</a></li>
		</ul>
		<hr>
		
		
		<div class="container_16">
			<article class="grid_16">
				<div class="item rounded dark">
					<div id="map_canvas" class="map"></div>
				</div>			
			</article>
		</div>
		
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
				
				
				url="http://api.careerbuilder.com/v1/jobsearch?DeveloperKey=WDHT1YG61B6HPD3NGC2Y"
				+"&perPage=25&Keywords="+s.jobtype+"%2C"+interests;
				
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
	
	
	<script>
	
	var longi;
	var lati;
	var companytitle;
	var jobdesc;
	var url;
	var newj = <%=jsonPrettyPrintString%>
	var xmlHttp = null;
	//var theUrl="https://api.github.com/search/users?q=language:Ruby+location:Boston%20&sort=followers";
    
	//document.write(theUrl);
	//var newj= JSON.parse(theUrl);
	//var contact= JSON.parse(contact[0]);
	//document.write("<br> QueryURL: " + theUrl + "<br>" );
	for (var i=0;i<newj.ResponseJobSearch.TotalCount;i++)
{ 
	/*document.write("<br> UserName: " + newj.items[i].login + 
			" 		URL: " +newj.items[i].url
			+ " avatar_url" + newj.items[i].avatar_url
			+ " html_url" + newj.items[i].html_url			
	);*/
	var sn = i+1;
	//document.write("<tr bgcolor=\"#FFFFFF\"><td>"+sn+"</td><td><a href="+newj.ResponseJobSearch.Results.JobSearchResult[i].JobDetailsURL+">" + 
	//		newj.ResponseJobSearch.Results.JobSearchResult[i].JobTitle+"</a></td><td><a href="+
	//		newj.ResponseJobSearch.Results.JobSearchResult[i].CompanyDetailsURL+">"+
	//		newj.ResponseJobSearch.Results.JobSearchResult[i].Company+ "<br><img src=\""+
	//		newj.ResponseJobSearch.Results.JobSearchResult[i].CompanyImageURL+ "\" alt=\"Broken Image\">"+"</a></td><td>" + 
	//		newj.ResponseJobSearch.Results.JobSearchResult[i].Location+ "</td><td>"+ 
	//		newj.ResponseJobSearch.Results.JobSearchResult[i].DescriptionTeaser + "</td><td>" +
	//		newj.ResponseJobSearch.Results.JobSearchResult[i].LocationLatitude +	"</td><td>"
	//		+ newj.ResponseJobSearch.Results.JobSearchResult[i].LocationLongitude +"</td></tr>"
	//		);
	
	longi=longi+","+newj.ResponseJobSearch.Results.JobSearchResult[i].LocationLongitude;
	lati=lati+","+newj.ResponseJobSearch.Results.JobSearchResult[i].LocationLatitude;
	url=url+","+newj.ResponseJobSearch.Results.JobSearchResult[i].CompanyImageURL;
	companytitle=companytitle+","+newj.ResponseJobSearch.Results.JobSearchResult[i].Company+": "+newj.ResponseJobSearch.Results.JobSearchResult[i].JobTitle;
	jobdesc=jobdesc+","+newj.ResponseJobSearch.Results.JobSearchResult[i].JobDetailsURL;
}
	
	</script>
		<div id="geo-thumbnail-template" style="display: none;" class="thumbnail">
        <img data-src="" alt="...">

        <div class="caption">
            <p class="thumbnail-desc">...</p>
        </div>
    </div>
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script> 
				
		<script type="text/javascript" src="js/demo.js"></script>
		<script type="text/javascript" src="js/markerclustererplus-2.0.6/markerclusterer.min.js"></script>
		<script type="text/javascript" src="ui/jquery.ui.map.js"></script>
		<script type="text/javascript">
            $(function() { 
				demo.add(function alert_math1() {
					$('#map_canvas').gmap({'zoom': 2, 'disableDefaultUI':true}).bind('init', function(evt, map) { 
						var bounds = map.getBounds();
						var southWest = bounds.getSouthWest();
						var northEast = bounds.getNorthEast();
						var lngSpan = -97.75;
						var latSpan = 30.25;
									
						
						var longiArray = longi.split(",");
						
						var latiArray = lati.split(",");
						
						var urlArray = url.split(",");
						var ctArray = companytitle.split(",");
						var jdArray = jobdesc.split(",");
				
						
						
					   //for ( var i = 0; i < document.geo.count.value; i++ ) {
							$.each(urlArray, function (index, data) {	
								//alert(data+" longi:" + longiArray[index]+" lati: " + latiArray[index]);
								
								var pos = latiArray[index] + "," + longiArray[index];
								
								$('#map_canvas').gmap('addMarker', { 'position': pos } ).mouseover(function() {
									var $info = $("#geo-thumbnail-template").clone().css('display', 'block');
						            // Need to monkey with the URL to get a smaller thumbnail
						            $info.find("img").attr("alt", "no image").attr("src", data.replace('=s300', '=s100'));
						            $info.find(".caption p").text(ctArray[index]);
						             
									
									
									var picture = new Image();
								     picture.src = data;
								     picture.height = 100;
								     picture.width = 100;
								     
									$('#map_canvas').gmap('openInfoWindow', { content : $info.html() }, this);
								});
								
								$('#map_canvas').gmap({ 'position': pos } ).click(function() {
									//var bob=jdArray[index]
									//window.open(bob,'_blank');
									window.location=jdArray[index];
								});
								
							});
							//}
							$('#map_canvas').gmap('set', 'MarkerClusterer', new MarkerClusterer(map, $(this).gmap('get', 'markers')));
						});
					}).load();
				});
        </script>
    
		
		<p id="demo"></p>
		
</div>		
</body>
</html>