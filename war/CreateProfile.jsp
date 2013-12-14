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
			<li><a href="/JobSearch.jsp">Recommended Jobs</a></li>
			<li class="active"><a href="/CreateProfile.jsp">Create Profile</a></li>
			<li><a href="/ViewAllStreams.jsp">View</a></li>
			<li><a href="/Search.jsp">Search</a></li>
			<li><a href="/TrendingResults.jsp">Trending</a></li>
			<li><a href="/FacebookLogin.jsp">Social</a></li>
		</ul>

	<!--  APT: this can be static so we put in html not jsp. Note that the added stream may take a few seconds to show up, 
so the ViewAllStreams.jsp that createStreamServlet redirects to may not contain the stream that's just been added -->
<body>
<div class="container">
	<h2>Create Profile</h2>
	<br>
	<form name="createProfileInput" action="createProfileServlet"
		method="get">
		<fieldset>
		<div class="row">
		<label for="1" class="col-sm-1 control-label">First Name</label>
		<div class="col-sm-2">
		<input type="text" id="1" name="firstname" required class="form-control" placeholder="Enter your first name"><br>  
		</div>

		<label for="2" class="col-sm-1 control-label">Last Name</label>
		<div class="col-sm-2">
		<input type="text" name="lastname" id="2" class="form-control" placeholder="Enter your last name"><br>  
		</div>
		</div>
		
		<div class="row">
		<label for="3" class="col-sm-1 control-label">
		Interests</label> <div class="col-sm-5">
		<input type="text" id="3" required name="interests" class="form-control" placeholder="E.g. Java, Big Data, Python, Web Development, C++, SQL"><i>Use comma "," as separator</i><br>  <br>
		
		</div>
		</div>
		<fieldset disabled>
		<div class="row">
		<label for="4" class="col-sm-1 control-label">
		Email </label>  <div class="col-sm-3">
		<input type="text" required name="email" id="4" class="form-control" value="${fn:escapeXml(user)}"><br>  
		</div>
		</div>
		</fieldset>
		<div class="row">
		<label for="5" class="col-sm-1 control-label">
		City</label><div class="col-sm-2">
		<input id="5" type="text" name="city" class="form-control" placeholder="Enter City"><br>  
		</div>
		
		<label for="6" class="col-sm-1 control-label">
		State: </label><div class="col-sm-2">
		<select name="state" id="6" class="form-control" placeholder="Select US State">
		<option value='' disabled selected style='display:none;'>Please Choose</option>
	<option value=""></option>
	<option value="AL">Alabama</option>
	<option value="AK">Alaska</option>
	<option value="AZ">Arizona</option>
	<option value="AR">Arkansas</option>
	<option value="CA">California</option>
	<option value="CO">Colorado</option>
	<option value="CT">Connecticut</option>
	<option value="DE">Delaware</option>
	<option value="DC">District Of Columbia</option>
	<option value="FL">Florida</option>
	<option value="GA">Georgia</option>
	<option value="HI">Hawaii</option>
	<option value="ID">Idaho</option>
	<option value="IL">Illinois</option>
	<option value="IN">Indiana</option>
	<option value="IA">Iowa</option>
	<option value="KS">Kansas</option>
	<option value="KY">Kentucky</option>
	<option value="LA">Louisiana</option>
	<option value="ME">Maine</option>
	<option value="MD">Maryland</option>
	<option value="MA">Massachusetts</option>
	<option value="MI">Michigan</option>
	<option value="MN">Minnesota</option>
	<option value="MS">Mississippi</option>
	<option value="MO">Missouri</option>
	<option value="MT">Montana</option>
	<option value="NE">Nebraska</option>
	<option value="NV">Nevada</option>
	<option value="NH">New Hampshire</option>
	<option value="NJ">New Jersey</option>
	<option value="NM">New Mexico</option>
	<option value="NY">New York</option>
	<option value="NC">North Carolina</option>
	<option value="ND">North Dakota</option>
	<option value="OH">Ohio</option>
	<option value="OK">Oklahoma</option>
	<option value="OR">Oregon</option>
	<option value="PA">Pennsylvania</option>
	<option value="RI">Rhode Island</option>
	<option value="SC">South Carolina</option>
	<option value="SD">South Dakota</option>
	<option value="TN">Tennessee</option>
	<option value="TX">Texas</option>
	<option value="UT">Utah</option>
	<option value="VT">Vermont</option>
	<option value="VA">Virginia</option>
	<option value="WA">Washington</option>
	<option value="WV">West Virginia</option>
	<option value="WI">Wisconsin</option>
	<option value="WY">Wyoming</option>
</select>
</div>
		</div>

<div class="row">
<label for="7" class="col-sm-1 control-label" placeholder="Select Country">
Country: </label> <div class="col-sm-3">
<select name="country" id="7" class="form-control">
<option value='' disabled selected style='display:none;'>Please Choose</option>
<option value=""></option>
<option value="us">United States</option>
<option value="ar">Argentina</option>
<option value="au">Australia</option>
<option value="at">Austria</option>
<option value="bh">Bahrain</option>
<option value="be">Belgium</option>
<option value="br">Brazil</option>
<option value="ca">Canada</option>
<option value="cl">Chile</option>
<option value="cn">China</option>
<option value="co">Colombia</option>
<option value="cz">Czech Republic</option>
<option value="dk">Denmark</option>
<option value="fi">Finland</option>
<option value="fr">France</option>
<option value="de">Germany</option>
<option value="gr">Greece</option>
<option value="hk">Hong Kong</option>
<option value="hu">Hungary</option>
<option value="in">India</option>
<option value="id">Indonesia</option>
<option value="ie">Ireland</option>
<option value="il">Israel</option>
<option value="it">Italy</option>
<option value="jp">Japan</option>
<option value="kr">Korea</option>
<option value="kw">Kuwait</option>
<option value="lu">Luxembourg</option>
<option value="my">Malaysia</option>
<option value="mx">Mexico</option>
<option value="nl">Netherlands</option>
<option value="nz">New Zealand</option>
<option value="np">Norway</option>
<option value="om">Oman</option>
<option value="pk">Pakistan</option>
<option value="pe">Peru</option>
<option value="ph">Philippines</option>
<option value="pl">Poland</option>
<option value="pt">Portugal</option>
<option value="qa">Qatar</option>
<option value="ro">Romania</option>
<option value="ru">Russia</option>
<option value="sa">Saudi Arabia</option>
<option value="sg">Singapore</option>
<option value="za">South Africa</option>
<option value="es">Spain</option>
<option value="se">Sweden</option>
<option value="ch">Switzerland</option>
<option value="tw">Taiwan</option>
<option value="tr">Turkey</option>
<option value="ae">United Arab Emirates</option>
<option value="gb">United Kingdom</option>
<option value="ve">Venezuela</option>
</select>
</div>
		</div>
		<br>
		<div class="row">
		<label for="8" class="col-sm-1 control-label">
		Zip-Code</label>
		<div class="col-sm-2">
		<input type="text" id="8" name="zipcode" class="form-control" placeholder="Enter ZipCode"><br>  
		</div>
		</div>
		
		<div class="row">
		<label for="9" class="col-sm-1 control-label">
		Preferred Type</label><div class="col-sm-2">
		<select name="jobtype" id="9" class="form-control">
<option value="fulltime">Full-time</option>
<option value="parttime">Part-time</option>
<option value="contract">Contract</option>
<option value="internship">Internship</option>
<option value="temporary">Temporary</option>
</select>
</div>
</div>
</fieldset>
		<br> <input type="hidden" name="user"
			value=${fn:escapeXml(user.nickname)}>
		 <input	type="submit" class="btn btn-success" value="Create Profile"><i class="icon-white icon-ok-sign"></i>
	</form>

	<!--form name="createStreamInput" action="createStreamServlet"
		method="get">
		<input type="text" name="streamName"><br> Name your
		stream <br>
		<br> <input type="text" name="tags"><br> Tag your
		stream <br>
		<br> <input type="text" name="subscribers"><br> Add
		Subscribers <br>
		<br> <input type="text" name="message"><br> Optional
		Message for Invite <br>
		<br> <input type="text" name="url"><br> URL to cover
		image (Can be empty)<br>
		<br> <input type="hidden" name="user"
			value=${fn:escapeXml(user.nickname)}>
		<br> <input	type="submit" value="Create Stream">
	</form-->
</div>
</body>
</html>