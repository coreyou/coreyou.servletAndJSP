<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%-- 與db_schemaShowTable.jsp連動 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>瀏覽資料庫schema</title>
	</head>
	<body>
		<jsp:useBean id="dbAccess" class="bean.DBAccess"></jsp:useBean>
		<h2>瀏覽資料庫schema</h2>
		<%
			dbAccess.setConnection("mysql", "coreyou", "751201267");
			Connection con = dbAccess.getConnection();
			DatabaseMetaData dbmd = con.getMetaData();
			
			String outputString = "";
			ResultSet rs = dbmd.getTables(null, null, "%", null);
			String tableType = "";
			String tableName = "";
			int tableCount = 0;
			out.println("<ul>");
			while (rs.next()) {
				tableType = rs.getString("TABLE_TYPE").toUpperCase();
				if (!tableType.equals("SYSTEM TABLE")) {	// 略過系統資料表
					tableName = rs.getString("TABLE_NAME").toLowerCase();	// 取得資料表名稱
					if (!tableName.equals("upload")) {
						out.println("<li><a href='db_schemaShowTable.jsp?tableName=" + tableName + "'>" + tableName + "</a></li>");
						tableCount++;
					}
				}
			}
			out.println("</ul>");
			
			if (rs != null) rs.close();
			if (con != null) con.close();
			out.println("<hr />");
			if (tableCount > 0) {
				out.println("共 <b>" + tableCount + "</b> 個資料表!");
			} else {
				out.println("無任何資料表!");
			}			
		%>
	</body>
</html>