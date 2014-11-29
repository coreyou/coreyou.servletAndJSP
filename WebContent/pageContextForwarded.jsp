<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>PageContext Forwarded</title>
	</head>
	<body>
		<h1>2nd JSP(receiver)</h1>
		<%
			out.println("session ID: " + session.getId() + "<br />");
			out.println("session variable(author): " + session.getAttribute("author"));
		%>
	</body>
</html>