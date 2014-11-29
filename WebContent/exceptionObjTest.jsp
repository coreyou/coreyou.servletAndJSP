<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="exceptionObj.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Exception Object Test</title>
	</head>
	<body>
		<%
			int i;
			String[] strAry = new String[3];
			for (i = 1; i <= 3; i++) {	// 應該要設成i < 3;，i <= 3會超過String[3]，造成錯誤，傳給exceptionObj.jsp處理
				strAry[i] = "<font size=" + (i+3) + "> Hello, JSP</font><br />";
				out.println(strAry[i]);
			}
		%>
	</body>
</html>