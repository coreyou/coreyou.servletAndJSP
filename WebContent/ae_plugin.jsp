<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%-- 與ActionElementPlugin.java連動 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>載入Java Applet</title>
</head>
<body>
	<h2>載入Java Applet</h2>
	<p>&lt;jsp:plugin&gt;動作標記: 顯示作者姓名</p>
	<jsp:plugin code="ActionElementPlugin.class" codebase="./build/classes" type="applet" height="100" width="400">
		<jsp:params>
			<jsp:param name="ename" value="corey_ou" />
			<jsp:param name="author" value="coreyou" />
			<jsp:param name="color" value="red" />
		</jsp:params>
		<jsp:fallback>無法載入Applet!</jsp:fallback>
	</jsp:plugin>
	<br />
	<applet code="ActionElementPlugin.class" height="100" width="400" >
		<param name="ename" value="corey_ou">
		<param name="author" value="coreyou">
		<param name="color" value="red">
	</applet>
</body>
</html>