<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Connection Interface</title>
	</head>
	<body>
		<h2>Connection介面應用</h2>
		<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
				"coreyou","751201267");
			out.println("<p>目前auto-commit模式: " + con.getAutoCommit() + "</p>");
			out.println("<p>設定auto-commit模式: false</p>");
			con.setAutoCommit(false);
			out.println("<p>改變後的auto-commit模式: " + con.getAutoCommit() + "</p><hr />");
			
			out.println("<p>目前Read Only模式: " + con.isReadOnly() + "</p>");
			out.println("<p>設定Read Only模式: true</p>");
			con.setReadOnly(true);
			out.println("<p>改變後的Read Only模式: " + con.isReadOnly() + "</p><hr />");
			
			out.println("<p>目前Connection是否被close: " + con.isClosed() + "</p>");
			out.println("<p>關閉Connection...</p>");
			con.close();
			out.println("<p>目前Connection是否被close: " + con.isClosed() + "</p><hr />");
		%>
	</body>
</html>