<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Driver Manager</title>
		</head>
	<body>
		<h2>使用Driver Manager類別</h2>
		<%
			out.println("<p>目前Login Timeout:" + DriverManager.getLoginTimeout() + "s</p><hr />");
			out.println("<p>設定Login Timeout: 30s</p><hr />");
			DriverManager.setLoginTimeout(30);
			DriverManager.setLoginTimeout(0);
			out.println("<p>目前載入的JDBC驅動程式:</p>");
			Enumeration enuDriver = DriverManager.getDrivers();
			String strName = null;
			while (enuDriver.hasMoreElements()) {
				strName = enuDriver.nextElement().getClass().getName();
				out.println("<p><b>" + strName + "</b></p>");
			}
			out.println("<hr />");
		%>
	</body>
</html>