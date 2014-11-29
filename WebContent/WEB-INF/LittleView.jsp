<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%-- 
    	MVC中的View。    	
    	本例連動LittleController.java、LittleModel.java。
     --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Little View</title>
</head>
<body>
	<h1>User: ${ param.user }</h1>
	<p>Message: ${ message }</p>
</body>
</html>