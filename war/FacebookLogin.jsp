<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Collections"%>

<%@ page import="com.adnan.OfyService"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<h1>Connex.us</h1>
</head>
<body>
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
	<a href="/Manage.jsp">Manage</a> |
	<a href="/CreateStream.jsp">Create</a> |
	<a href="/ViewAllStreams.jsp">View</a> |
	<a href="/Search.jsp">Search</a> | 
	<a href="/TrendingResults.jsp">Trending</a> |
	<a href="/FacebookLogin.jsp">Social</a>

	<h2>Social</h2>

	Login with Facebook to share streams with your friends and groups!
	<br>
	<br>
<body>


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
	</script>
	<p id="demo1"></p>
	<script>
		function myFunction() {
			var x = "";
			var time = new Date().getHours();
			if (time < 20) {
				x = "Good day";
			}
			document.getElementById("demo1").innerHTML = x;
		}
		//myFunction();

		
	</script>

	

	<!--span id="fbLogout" onclick="fbLogout()"><a class="fb_button fb_button_medium"><span class="fb_button_text">Logout</span></a></span-->




	<!--
  Below we include the Login Button social plugin. This button uses the JavaScript SDK to
  present a graphical Login button that triggers the FB.login() function when clicked.

  Learn more about options for the login button plugin:
  /docs/reference/plugins/login/ -->

	<fb:login-button show-faces="true" width="200" max-rows="1"></fb:login-button>

	<br>
	<br>
	<input id="logout" type="button" value="Logout" onclick="fbLogout()" />
	<br>



</body>
</html>
