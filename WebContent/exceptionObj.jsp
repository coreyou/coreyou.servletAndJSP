<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
    <!-- isErrorPage="true"才會使_jspService()宣告和初始化exception物件 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Exception Object</title>
	</head>
	<body>
		<%
			// 執行exceptionObjTest.jsp印出錯誤訊息
			String strMsg = exception.toString();
			out.println("錯誤訊息: " + strMsg + "<hr />");
		%>
	</body>
</html>