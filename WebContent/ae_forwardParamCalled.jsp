<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%-- 與ae_forwardParam.jsp連動 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Action Elements - 動態轉送(有參數): called page</title>
</head>
<body>
	<h2>Action Elements - 動態轉送(有參數): called page</h2>
	<%
		String strName = request.getParameter("strName");
		out.println("<p>request.getParameter(strName): " + strName + "</p>");
		out.println("<p>called page end</p><hr />");
	%>
</body>
</html>