<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Express Language(EL)</title>
</head>
<body>
	<form action="expressLanguageBean.jsp" method="get">
		<div>Name: <input type="text" name="name" /></div>
		<div>Age: <input type="text" name="age" /></div>
		<div>Name_2: <input type="text" name="name" /></div>
		<input type="submit" value="send" />
		<%
			response.addCookie(new Cookie("cookie_name", "abc"));
		%>
	</form>
</body>
</html>