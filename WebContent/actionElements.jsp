<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%--
    	與Action.java、actionElementBean.jsp連動
     --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Action Elements</title>
</head>
<body>
	<form action="actionElementBean.jsp" method="post">
		<div>Name: <input type="text" name="name" /></div>
		<div>Age: <input type="text" name="age" /></div>
		<input type="submit" value="send" />
	</form>
</body>
</html>