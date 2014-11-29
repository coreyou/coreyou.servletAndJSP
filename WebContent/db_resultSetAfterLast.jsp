<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    <%!	
    	String tableName = "userTest";
    	// 在console印出user這個資料表的內容
		void printUserTable(Connection con) {
			try {
				Statement stat = con.createStatement();
				ResultSet rs = stat.executeQuery("select * from " + tableName);
				System.out.println("======================================================");
				while (rs.next()) {
					System.out.println(rs.getString("userId") + "\t\t" +
				        rs.getString("userName") + "\t\t" + rs.getString("email"));
				}
				System.out.println("======================================================");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>afterLast(), beforeFirst()</title>		
	</head>
	<body>
		<h2>afterLast(), beforeFirst()</h2>
		<%
			// 1. 載入JDBC驅動程式
			Class.forName("com.mysql.jdbc.Driver");
			// 2. 透過DriverManager類別建立Connection物件
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
				"coreyou","751201267");
			// 3. 透過Connection物件建立Statement物件
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			// 4. 5. 執行SQL敘述，產生ResultSet物件
			String sql = "insert into " + tableName + " values('4', 'John', 'john@gmail.com')";
			stmt.addBatch(sql);
			sql = "insert into " + tableName + " values('5', 'Ken', 'ken@gmail.com')";
			stmt.addBatch(sql);
			sql = "insert into " + tableName + " values('6', 'Sonic', 'sonic@gmail.com')";
			stmt.addBatch(sql);
			stmt.executeBatch();
			
			sql = "select * from " + tableName + " order by userId";
			ResultSet rs = stmt.executeQuery(sql);
			
			// 6. 進行資料的處理	
			ResultSetMetaData rsmd = rs.getMetaData();
			int colCount = rsmd.getColumnCount();	// 取得欄位總數
			
			out.println("<h3>使用afterLast()從最後印回第一筆</h3>");
			out.println("<table>");
			rs.afterLast();	// 將ResultSet游標移到最後一筆之後
			int j = 0;
			while (rs.previous()) {	// 游標從最後一筆之後開始往前移
				if (j == 0) {
					out.println("<tr bgcolor='yellow'>");
					out.println("<th scope='col'>項次</th>");
					for (int i = 1; i <= colCount; i++) {
						out.println("<th scope='col'>" + rsmd.getColumnName(i) + "</th>");
					}
					out.println("</tr>");
				}
				out.println("<tr>");
				out.println("<td>" + (j+1) + "</td>");
				for (int i = 1; i <= colCount; i++) {
					out.println("<td>" + rs.getString(i) + "</td>");
				}
				out.println("</tr>");
				j++;
			}
			out.println("</table><hr />");
			
			out.println("<h3>使用beforeFirst()從開始印到最後一筆</h3>");
			out.println("<table>");
			rs.beforeFirst();	// 將ResultSet游標移到第一筆之前
			j = 0;
			while (rs.next()) {	// 游標從第一筆之前開始往後移
				if (j == 0) {
					out.println("<tr bgcolor='yellow'>");
					out.println("<th scope='col'>項次</th>");
					for (int i = 1; i <= colCount; i++) {
						out.println("<th scope='col'>" + rsmd.getColumnName(i) + "</th>");
					}
					out.println("</tr>");
				}
				out.println("<tr>");
				out.println("<td>" + (j+1) + "</td>");
				for (int i = 1; i <= colCount; i++) {
					out.println("<td>" + rs.getString(i) + "</td>");
				}
				out.println("</tr>");
				j++;
			}
			out.println("</table><hr />");
			
			stmt.clearBatch();
			sql = "delete from " + tableName + " where (userId >= 4 && userId <= 6)";
			stmt.executeUpdate(sql);
			
			// 7. 關閉ResultSet與Statement物件
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			// 8. 關閉Connection物件
			if (con != null) con.close();
		%>
	</body>
</html>