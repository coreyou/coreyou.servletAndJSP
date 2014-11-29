<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Application Object</title>
	</head>
	<body>
		<%
			String dbUrl = application.getInitParameter("dbUrl");	// 抓web.xml中的<param-name>dbUrl</param-name>的value
			String strCounter = application.getInitParameter("counter");
			out.println("起始參數1(counter): " + strCounter + "<br />");
			out.println("起始參數2(dbUrl): " + dbUrl + "<br />");
			
			application.setAttribute("counter", strCounter);
			application.setAttribute("dbUrl", dbUrl);
			application.setAttribute("author", "coreyou");
			
			String strName;
			int i = 1;
			Enumeration enuAttr = application.getAttributeNames();
			while (enuAttr.hasMoreElements()) {
				strName = (String)enuAttr.nextElement();
				out.println("application屬性 " + i + " (" + strName + strName + ") -> " + application.getAttribute(strName) + "<br />");
				i++;
			}
			
			out.println("<hr />實際路徑: " + application.getRealPath("/") + "<br />");
			out.println("<hr />servlet容器相關資訊: " + application.getServerInfo() + "<br />");
		%>
	</body>
</html>