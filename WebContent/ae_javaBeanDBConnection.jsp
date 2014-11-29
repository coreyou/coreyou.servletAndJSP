<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.sql.*"%>
    <%-- 使用DBConnection.java這個BEAN，達成資料庫元件的reuse，在MVC中屬於Model的角色 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>使用JAVA BEAN取得Connection</title>
</head>
<body>
	<h2>使用JAVA BEAN取得Connection</h2>
	<%-- 定義JAVA BEAN --%>
	<jsp:useBean id="dbBean" class="bean.DBConnection" scope="page"></jsp:useBean>
	<%
		// 使用JAVA BEAN
		dbBean.setConnection("mysql", "coreyou", "751201267");
		Connection con = dbBean.getConnection();
		
		Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		String tableName = "user";
		String sql = "select * from " + tableName;
		ResultSet rs = stmt.executeQuery(sql);
		
		out.println("<font color='blue'>");
		out.println("<p>FETCH_FORWARD(1000), FETCH_REVERSE(1001), FETCH_UNKNOWN(1002)</p>");
		out.println("</font>");
		out.println("<p>目前FetchDirection為: " + rs.getFetchDirection() + "</p>");
		rs.setFetchDirection(ResultSet.FETCH_REVERSE);
		out.println("<p>設定FetchDirection為: " + rs.getFetchDirection() + "</p><hr />");
		
		out.println("<font color='blue'>");
		out.println("<p>TYPE_FORWARD_ONLY(1003), TYPE_SCROLL_INSENSITIVE(1004), TYPE_SCROLL_SENSITIVE(1005)</p>");
		out.println("</font>");
		out.println("<p>目前ResultSet Type為: " + rs.getType() + "</p><hr />");
		
		out.println("<font color='blue'>");
		out.println("<p>CONCUR_READ_ONLY(1007), CONCUR_UPDATABLE(1008)</p>");
		out.println("</font>");
		out.println("<p>目前ResultSet Concurrency為: " + rs.getConcurrency() + "</p><hr />");
		
		rs.last();	// 移到最後一筆
		out.println(tableName + " 資料表的紀錄共有: " + rs.getRow() + "筆<hr />");	// rs.getRow()取得最後一筆的列號			
		
		// 關閉ResultSet與Statement物件
		if (rs != null) rs.close();
		if (stmt != null) stmt.close();
		// 關閉Connection物件
		if (con != null) con.close();
	%>
</body>
</html>