<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.adnan.Stream"%>
<%@ page import="com.adnan.ConnexusImage"%>
<%@ page import="com.adnan.OfyService"%>
<%@ page import="java.util.List"%>
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
	<a href="/Manage.jsp">Manage</a> |
	<a href="/CreateStream.jsp">Create</a> |
	<a href="/ViewAllStreams.jsp">View</a> |
	<a href="/Search.jsp">Search</a> |
	<a href="/Trending.jsp">Trending</a> |
	<a href="/FacebookLogin.jsp">Social</a>
	
	<script type="text/javascript">
	
	
	function myReload(x) {
	window.location=x;
	var opener=x;
	window.opener.location.reload();
	window.location.reload();
}
	
	function myRefresh(x) {
		//x='/ShowStream.jsp?streamId=4820258976169984&streamName=new%20stream&nextImage=0';
        var winOpen = window.open(x);
        winOpen.reload();
        winOpen.focus();
        winOpen.close();
        setTimeout("self.close()",5000);
	}
	
     </script>

	<%
		List<Stream> th0 = OfyService.ofy().load().type(Stream.class).list();
		Collections.sort(th0);
		String url;
		for(Stream s: th0) {
			int vs=s.viewCount;
			int total = s.totalClicks;
			//out.println("<br>Before: sname="+s.name+"oldvs="+s.viewCount+"s.total"+s.totalClicks);
			url="/ShowStream.jsp?streamId="+s.id+"&streamName="+s.name+"&nextImage=0";
			
			%>
			<script>
			
			myRefresh('<%=url%>');
			
			</script>
	<% 
			//s.viewCount=vs-1;
			//s.totalClicks=total-1;
			//if(s.viewCount<0) s.viewCount=0;
			//if(s.totalClicks<0) s.totalClicks=0;
			//OfyService.ofy().save().entity(s).now();
			//out.println("<br>After: sname="+s.name+"oldvs="+s.viewCount+"s.total"+s.totalClicks);
		}	
		
		BlobstoreService blobstoreService = BlobstoreServiceFactory
				.getBlobstoreService();
		//Long streamId = new Long(request.getParameter("streamId"));
		//String streamName = request.getParameter("streamName");
		//int nextImage = new Integer(request.getParameter("nextImage"));
		//out.println("<h1>Stream: " + streamName + "</h1><br>");
		Long time = 0L;
		List<Stream> th = OfyService.ofy().load().type(Stream.class).list();
		Collections.sort(th);
		int maxview[] = new int[] { 0, 0, 0 };
		String[] trending = { " ", " ", " " };
		
		//	for (int i = 0; i < 3; i++) {
				int i=0;
				maxview[i]=0;
				trending[i]="";
				for (Stream s : th) {
					if(!s.name.equals(trending[i])) {
				out.println("<br>name:" + s.name + " viewCount: "
						+ s.viewCount + " totalClicks: " + s.totalClicks);

				if (s.viewCount > maxview[i]) {
					int prev = i-1;
									
						maxview[i] = s.viewCount;
						trending[i] = s.name;	
					}
				}
					
			}

		//}

			
//-------------
	maxview[1]=0;
	int num=0;
	String trend1="";
	List<Stream> th1 = OfyService.ofy().load().type(Stream.class).list();
	for(Stream s: th1) {
		num = s.viewCount;
		trend1 = s.name;
		if(num>=maxview[0]) {
			//maxview[1] = maxview[0];
			//maxview[0] = num;
			
		}
		else {
			if(num>maxview[1]) {
				maxview[1]=num;
				trending[1]=trend1;
			}
		}
	}
		
		
		
		
		
		maxview[2]=0;
		int num2=0;
		String trend2="";
		List<Stream> th2 = OfyService.ofy().load().type(Stream.class).list();
		for(Stream s: th2) {
			num2 = s.viewCount;
			trend2 = s.name;
			if(num2>=maxview[1]) {
				//maxview[1] = maxview[0];
				//maxview[0] = num;
				
			}
			else {
				if(num2>maxview[2]) {
					maxview[2]=num2;
					trending[2]=trend2;
				}
			}
		}
			
			out.println("<br><br>stream1:" + trending[0] + "views" + maxview[0]);
			out.println("<br><br>stream2:" + trending[1] + "views" + maxview[1]);
			out.println("<br><br>stream3:" + trending[2] + "views" + maxview[2]);
			
			response.sendRedirect("/TrendingResults.jsp/?s1="+trending[0]+"&v1="+maxview[0]+"&s2="+trending[1]+"&v2="+maxview[1]+"&s3="+trending[2]+"&v3="+maxview[2]);
	%>

</body>
</html>