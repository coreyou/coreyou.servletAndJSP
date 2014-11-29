<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Statement Interface</title>		
	</head>
	<body>
		<h2>設定/取得Statement介面的屬性</h2>
		<%
			// 1. 載入JDBC驅動程式
			Class.forName("com.mysql.jdbc.Driver");
			// 2. 透過DriverManager類別建立Connection物件
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
				"coreyou","751201267");
			// 3. 透過Connection物件建立Statement物件
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			
			// FetchDirection: ResultSet物件中，資料紀錄的存取方向(向前、向後、未知)
			out.println("<h2>FETCH_FORWARD(1000), FETCH_REVERSE(1001), FETCH_UNKNOWN(1002)</h2>");
			out.println("<p>目前FetchDirection為: " + stmt.getFetchDirection() + "</p>");
			stmt.setFetchDirection(1001);
			out.println("<p>設定FetchDirection為: " + stmt.getFetchDirection() + "</p><hr />");
			
			// MaxRow: 一次可以返回的最大紀錄比數
			out.println("<p>目前Max Rows為(0表示沒有限制): " + stmt.getMaxRows() + "</p>");
			stmt.setMaxRows(100);
			out.println("<p>設定Max Rows為(0表示沒有限制): " + stmt.getMaxRows() + "</p><hr />");
			
			// ResultSetType: ResultSet物件的游標類型(只能往前、可前可後無視其他人異動、可前可後可看到其他人異動)
			out.println("<h2>TYPE_FORWARD_ONLY(1003), TYPE_SCROLL_INSENSITIVE(1004), TYPE_SCROLL_SENSITIVE(1005)</h2>");
			out.println("<p>目前ResultSet Type為: " + stmt.getResultSetType() + "</p><hr />");
			
			// ResultSet Concurrency: ResultSet物件的同步性(唯獨、可更改)
			out.println("<h2>CONCUR_READ_ONLY(1007), CONCUR_UPDATABLE(1008)</h2>");
			out.println("<p>目前ResultSet Concurrency為: " + stmt.getResultSetConcurrency() + "</p><hr />");			
			
			// 7. 關閉Statement物件
			if (stmt != null) stmt.close();
			// 8. 關閉Connection物件
			if (con != null) con.close();
		%>
	</body>
</html>