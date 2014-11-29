<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Request Get Header Information</title>
	</head>
	<body>
		<table>
			<tr>
				<th>環境變數</th>
				<th>內含值</th>
			</tr>
			<%
				Enumeration enuHeader = request.getHeaderNames();
				String strName, strValue;
				while(enuHeader.hasMoreElements()) {
					strName = (String)enuHeader.nextElement();
					strValue = request.getHeader(strName);
					out.println("<tr><td>" + strName + "</td>");
					out.println("<td>" + strValue + "</td></tr>");
				}
			%>
		</table>
	</body>
</html>