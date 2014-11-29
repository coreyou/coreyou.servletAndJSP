<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%-- 與db_schemaBrowse.jsp、tableToExcel.jsp連動，開啟db_schemaBrowse.jsp測試 --%>
<%!
	int resultRow = 0;
	String tableName;
	private String showResult(ResultSet rs) {
		String finalStr = "";
		int colCount = 0;
		resultRow = 0;
		try {
			while(rs.next()) {
				if (resultRow == 0) {	// 印表格的header
					ResultSetMetaData rsmd = rs.getMetaData();
					colCount = rsmd.getColumnCount();	// 取得欄位總數
					finalStr = "<table><tr bgcolor='lightblue'><th scope='col'><b>No.</b></th>";
					for (int j = 1; j <= colCount; j++) {
						finalStr += "<th scope='col'><b>" + rsmd.getColumnName(j) + "</b></th>";
					}
					finalStr += "</tr>";
				}
				finalStr += "<tr><td>" + (resultRow+1) + "</td>";	// row no.
				for (int j = 1; j <= colCount; j++) {
					finalStr += "<td>" + rs.getString(j) + "</td>";
				}
				finalStr += "</tr>";
				resultRow++;
			}
			finalStr += "</table>";
		} catch (SQLException se) {
			finalStr += "Error occurred: " + se.toString() + "<br />";
		}
		return finalStr;
	}
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>顯示資料表內容</title>
	</head>
	<body>
		<%
			
			if (request.getParameter("tableName") == null || request.getParameter("tableName") == "") {
				tableName = "Null";
			} else {
				tableName = new String(request.getParameter("tableName").getBytes("ISO-8859-1"));
			}
		%>
		<jsp:useBean id="dbAccess" class="bean.DBAccess"></jsp:useBean>
		<h2>顯示<%= tableName %>資料表內容</h2>
		<small>&lt;&lt;<a href="javascript:history.go(-1)">回到上一頁</a>&gt;&gt;</small>&nbsp;&nbsp;
		<small>&lt;&lt;<a href="tableToExcel.jsp?tableName=<%= tableName %>">存成Excel檔</a>&gt;&gt;</small>&nbsp;&nbsp;
		<small>&lt;&lt;<a href="tableToPdf.jsp?tableName=<%= tableName %>">存成PDF檔</a>&gt;&gt;</small>&nbsp;&nbsp;
		<hr />
		<%
			if (!tableName.equals("Null")) {
				dbAccess.setConnection("mysql", "coreyou", "751201267");
				Connection con = dbAccess.getConnection();
				String sql = "select * from " + tableName;
				ResultSet rs = dbAccess.getResultSet(sql);
				out.println(showResult(rs));
				out.println("<hr />");
				
				if (resultRow > 0) {
					out.println("<small>&lt;&lt;<a href='javascript:history.go(-1)'>回到上一頁</a>&gt;&gt;</small>");
				} else {
					out.println("<p>無任何符合條件之紀錄...</p>");
				}
				
				if (rs != null) rs.close();
				if (con != null) con.close();				
			} else {
				out.println("<p>未指定欲顯示的資料表...</p>");
			}	
		%>
	</body>
</html>