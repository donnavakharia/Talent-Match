<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.View" %>
<%@ page import="com.adnan.ConnexusImage"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.Collections"%>

<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%@ page
	import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>

<%@ page import="com.adnan.OfyService"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<h1>Connex.us</h1>
<script>
function getValuesShow() {
		var cbs = document.getElementsByName('more');
		var result = '';

		for ( var i = 0; i < cbs.length; i++) {
			if (cbs[i].checked)
				result += (result.length > 0 ? "," : "") + cbs[i].value;
		}
		alert(result);
		window.location.href = "/Unsubscribe.jsp?streamName=".concat(result);
		return result;
	}
	</script>
</head>
<body>
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
	<a href="/Manage.jsp">Manage</a> |
	<a href="/CreateStream.jsp">Create</a> |
	<a href="/ViewAllStreams.jsp">View</a> |
	<a href="/Search.jsp">Search</a> | 
	<a href="/TrendingResults.jsp">Trending</a> |
	<a href="/FacebookLogin.jsp">Social</a>

	<%
		BlobstoreService blobstoreService = BlobstoreServiceFactory
				.getBlobstoreService();
		Long streamId = new Long(request.getParameter("streamId"));
		String streamName = request.getParameter("streamName");
		int nextImage =new Integer(request.getParameter("nextImage"));
		
		View sview = new View(streamName,new Date());
		OfyService.ofy().save().entity(sview).now();
		
		
		out.println("<h1>Stream: " + streamName + "</h1><br>");
		Long time=0L;
		List<Stream> th = OfyService.ofy().load().type(Stream.class).list();
		Collections.sort(th);
		for (Stream s : th) {
			if (s.name.equals(streamName)) {

				time = System.currentTimeMillis();
				s.totalClicks++;
				s.timeClicked[s.totalClicks] = time;

				OfyService.ofy().save().entity(s).now();
				s.viewCount = 1;
				for (int i = 1; i < s.totalClicks; i++) {

					if (time - s.timeClicked[i] < 50000L) {
						s.viewCount++;
					}
				}

				//out.println("Total Clicks: " + s.totalClicks);
				//out.println("Time: " + s.timeClicked[s.totalClicks]);
				//out.println("View Count: " + s.viewCount+"<br>");
				OfyService.ofy().save().entity(s).now();
			}
		}

		List<ConnexusImage> images = OfyService.ofy().load()
				.type(ConnexusImage.class).list();
		Collections.sort(images);
		int imageCount=nextImage;
		int temp=0;
		int tempmax=nextImage+3;
		int i=0;
		int j=imageCount;
		int cnt=0;
		
		for (ConnexusImage img : images) {
			if (img.streamId.equals(streamId)) {
				List<Stream> st = OfyService.ofy().load()
						.type(Stream.class).list();
				//if(imageCount<st.size()) {
				if(imageCount!=0 && (imageCount%3==0) && imageCount<=st.size()) {
					int imageC = (imageCount-1)+ i;
					
					//if(j==0)
					{
					out.println("<input id=\"more\" type=\"button\" value=\"More Pictures\" onclick=\"window.location.href=\'\\ShowStream.jsp?streamId="+streamId+"&streamName="+streamName+"&nextImage="+imageCount+"\';\"");
					j=1;
					
					}
					
					i=i +1;
				}

				if(temp>=nextImage-1 && temp<=tempmax) {	
					out.println("<img src=\"" + img.bkUrl + "\"" + " width=\"350\" height=\"325\">"); // better to not use println for html output, use templating instead
					imageCount++;
				}
				
				temp++;				
			}
				
		}

		String query = "?streamID=" + request.getParameter("streamID")
				+ "&streamName=" + request.getParameter("streamName");
	%>

	<!-- APT: note how we are adding additional parameters when we create the uploadurl - this way blobstore service
     can pass them on to the upload servlet, so upload knows which stream the image blob corresponds to -->

	<h2>Add an image</h2>
	<form
		action="<%=blobstoreService.createUploadUrl("/upload?streamId="+ streamId + "&streamName=" + streamName+"&nextImage=0")%>"
		method="post" enctype="multipart/form-data">
		<input type="file" name="myFile"><br> <input
			type="submit" value="Upload">
	</form>



<br>
	<input id="subscribe" type="button" value="Subscribe"
		onclick="parent.location='/Subscribe.jsp?streamName=<%=streamName%>'">

	<div id="fb-root"></div>
	<script>
		window.fbAsyncInit = function() {
			FB.init({
				appId : '514441631980187', // App ID
				channelUrl : '//WWW.connexus-donna.appspot.com/channel.html', // Channel File
				status : true, // check login status
				cookie : true, // enable cookies to allow the server to access the session
				xfbml : true
			// parse XFBML
			});

			FB.Event.subscribe('auth.authResponseChange', function(response) {

				if (response.status === 'connected') {
					testAPI();
				} else if (response.status === 'not_authorized') {

					FB.login();

				} else {

					FB.login();

				}
			});
		};

		// Load the SDK asynchronously
		(function(d) {
			var js, id = 'facebook-jssdk', ref = d
					.getElementsByTagName('script')[0];
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement('script');
			js.id = id;
			js.async = true;
			js.src = "//connect.facebook.net/en_US/all.js";
			ref.parentNode.insertBefore(js, ref);
		}(document));

		function testAPI() {
			console.log('Welcome!  Fetching your information.... ');
			FB.api('/me', function(response) {
				console.log('Good to see you, ' + response.name + '.');
			});
		}

		function fbLogout() {
			FB.logout(function(response) {
				//Do what ever you want here when logged out like reloading the page
				window.location.reload();
			});
		}
	</script>
	<p id="demo"></p>
	<script>
		function fbstatus() {
			var y = "hello";
			FB.Event.subscribe('auth.authResponseChange', function(response) {
				alert('The status of the session is: ' + response.status);
			});
			FB.getLoginStatus(function(response) {
				if (response.status === 'connected') {
					//window.location.href="/FBLoginSuccess.html";
					var uid = response.authResponse.userID;
					var accessToken = response.authResponse.accessToken;
					y = "You are connected!!!!!!!!!!!!!!!!!!!!!!!!";
				} else if (response.status === 'not_authorized') {
					y = "else1";
				} else {
					y = "else2";
				}
			});
			document.getElementById("demo").innerHTML = y;
		}
		fbstatus();

		function fbpost() {
			FB
					.ui(
							{
								method : 'feed',
								name : 'Connexus Photo Stream',
								link : window.location.href,
								picture : 'https://si0.twimg.com/profile_images/2081243736/320.jpg',
								caption : 'Stream',
								description : 'Share the world!'
							}, function(response) {
								if (response && response.post_id) {
									alert('Post was published.');
								} else {
									alert('Post was not published.');
								}
							});

		}
	</script>
	<br>
	<img src="http://www.delawareemploymentlawblog.com/facebook%20logo.jpg" width="40" height="40">
	<br>Post a link to this stream on your status
	<input id="fbposting" type="button" value="Post to FB" onclick="fbpost()" />

</body>
</html>