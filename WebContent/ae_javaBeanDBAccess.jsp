<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.sql.*"%>
    <%-- 使用DBAccess.java這個BEAN，達成資料存取元件的reuse，在MVC中屬於Model的角色 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>使用JAVA BEAN存取資料</title>
</head>
<body>
	<h2>使用JAVA BEAN存取資料</h2>
	<%-- 定義JAVA BEAN --%>
	<jsp:useBean id="dbBean" class="bean.DBAccess" scope="page"></jsp:useBean>
	<%
		// 使用JAVA BEAN
		dbBean.setConnection("mysql", "coreyou", "751201267");
		Connection con = dbBean.getConnection();
		
		// insert
		String tableName = "user";
		String sql = "insert into " + tableName + " values ('6', 'Wang', 'wang@gmail.com')";
		int updateRows = dbBean.getUpdate(sql);
		if (updateRows > 0) {
			out.println("<p>sql= " + sql + "</p>");
			out.println("成功新增 <font color='red'>" + updateRows + "</font> 筆紀錄!<hr />");
		}
		
		// select
		sql = "select * from " + tableName;
		ResultSet rs = dbBean.getResultSet(sql);
		out.println("<table>");
		updateRows = 0;
		while (rs.next()) {
			if (updateRows == 0) {	// print header
				out.println("<tr bgcolor='yellow'>");
				out.println("<th scope='col'>userId</th>");
				out.println("<th scope='col'>userName</th>");
				out.println("<th scope='col'>email</th></tr>");
			}
			out.println("<tr>");
			out.println("<td>" + rs.getString("userId") + "</td>");
			out.println("<td>" + rs.getString(2) + "</td>");
			out.println("<td>" + rs.getString(3) + "</td>");
			out.println("</tr>");
			updateRows++;
		}
		out.println("</table><hr />");
		
		// delete
		sql = "delete from " + tableName + " where userId='6'";
		updateRows = dbBean.getUpdate(sql);
		if (updateRows > 0) {
			out.println("<p>sql= " + sql + "</p>");
			out.println("成功刪除 <font color='red'>" + updateRows + "</font> 筆紀錄!<hr />");
		}
		
		// 7. 關閉ResultSet與Statement物件
		if (rs != null) rs.close();
		// 8. 關閉Connection物件
		if (con != null) con.close();
	%>
</body>
</html>