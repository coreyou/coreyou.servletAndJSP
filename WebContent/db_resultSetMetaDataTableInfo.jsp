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
		<title>getMetaData() 取得table相關資訊</title>		
	</head>
	<body>
		<h2>getMetaData()</h2>
		<%
			// 1. 載入JDBC驅動程式
			Class.forName("com.mysql.jdbc.Driver");
			// 2. 透過DriverManager類別建立Connection物件
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
				"coreyou","751201267");
			// 3. 透過Connection物件建立Statement物件
			Statement stmt = con.createStatement();
			// 4. 5. 執行SQL敘述，產生ResultSet物件
			String sql = "select * from " + tableName + " order by userId";
			ResultSet rs = stmt.executeQuery(sql);
			
			// 6. 進行資料的處理
			ResultSetMetaData rsmd = rs.getMetaData();
			int colCount = rsmd.getColumnCount();	// 取得欄位總數
			out.println("<h3>Table name: " + rsmd.getTableName(1) + "</h3><hr />");
			// 第一列為欄位名稱
			out.println("<table>");
			out.println("<tr bgcolor='yellow'>");
			out.println("<th scope='col'>欄位名稱</th>");
			for (int intNo = 1; intNo <= colCount; intNo++) {
				out.println("<th scope='col'>" + rsmd.getColumnName(intNo) + "</th>");
			}
			out.println("</tr>");
			// 取得各欄位的資料型態與對應的常數值
			out.println("<tr>");
			out.println("<td>資料型態</td>");
			for (int intNo = 1; intNo <= colCount; intNo++) {
				out.println("<td>" + rsmd.getColumnTypeName(intNo) + "(");
				out.println(rsmd.getColumnType(intNo) + ")</td>");
			}
			out.println("</tr>");
			// 取出欄位長度
			out.println("<tr>");
			out.println("<td>欄位長度</td>");
			for (int intNo = 1; intNo <= colCount; intNo++) {
				out.println("<td>" + rsmd.getColumnDisplaySize(intNo) + "</td>");
			}
			out.println("</tr>");
			// 取出欄位對應的JAVA類別名稱
			out.println("<tr>");
			out.println("<td>欄位類別名稱</td>");
			for (int intNo = 1; intNo <= colCount; intNo++) {
				out.println("<td>" + rsmd.getColumnClassName(intNo) + "</td>");
			}
			out.println("</tr>");
			out.println("</table><hr />");
			
			// 7. 關閉ResultSet與Statement物件
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			// 8. 關閉Connection物件
			if (con != null) con.close();
		%>
	</body>
</html>