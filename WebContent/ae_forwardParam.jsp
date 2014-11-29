<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%-- 與ae_forwardParamCalled.jsp連動 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Action Elements - 動態轉送(有參數): caller</title>
</head>
<body>
	<h2>Action Elements - 動態轉送(有參數): caller</h2>
	<%
		String strName = "Peter";
		out.println("<p>指定參數: " + strName + "</p><hr />");
	%>
	<jsp:forward page="ae_forwardParamCalled.jsp">
		<jsp:param value="<%= strName %>" name="strName"/>
	</jsp:forward>
	<%
		out.println("控制回到caller...");		// forward不會回來這行，要使用jsp:include才會回來
	%>
</body>
</html>