<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    <%!	
    	String tableName = "userTest";
    	// 印出user這個資料表的內容
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
		<title>executeUpdate(), executeQuery()</title>		
	</head>
	<body>
		<h2>executeUpdate(), executeQuery()</h2>
		<%
			// 1. 載入JDBC驅動程式
			Class.forName("com.mysql.jdbc.Driver");
			// 2. 透過DriverManager類別建立Connection物件
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
				"coreyou","751201267");
			// 3. 透過Connection物件建立Statement物件
			Statement stmt = con.createStatement();
			
			System.out.println("新增三筆資料前:");
			printUserTable(con);
			
			out.println("<h2>加入三筆SQL敘述至批次清單</h2>");
			String sql = "insert into " + tableName + " values('4', 'John', 'john@gmail.com')";
			stmt.executeUpdate(sql);
			out.println("<p>" + sql + "</p>");
			sql = "insert into " + tableName + " values('5', 'Ken', 'ken@gmail.com')";
			stmt.executeUpdate(sql);
			out.println("<p>" + sql + "</p>");
			sql = "insert into " + tableName + " values('6', 'Sonic', 'sonic@gmail.com')";
			stmt.executeUpdate(sql);
			out.println("<p>" + sql + "</p><hr />");
			
			// 5. 取得執行後的ResultSet物件，或是被異動的資料筆數
			sql = "select * from " + tableName + " where (userId >= 4 && userId <= 6)";
			ResultSet rs = stmt.executeQuery(sql);
			
			// 6. 進行資料的處理
			out.println("<h2>顯示新增的三筆紀錄</h2>");
			out.println("<table>");
			int i = 0;
			while (rs.next()) {
				if (i == 0) {	// print header
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
				i++;
			}
			out.println("</table><hr />");
			
			System.out.println("新增三筆資料後:");
			printUserTable(con);
			
			out.println("<h2>刪除新增的紀錄</h2>");			
			sql = "delete from " + tableName + " where (userId >= 4 && userId <= 6)";
			int intNo = stmt.executeUpdate(sql);	// > 0 表示刪除成功
			if  (intNo > 0) {
				out.println("<p>刪除 " + intNo + " 筆記錄成功!</p><br />");
			}
			
			System.out.println("刪除三筆資料後:");
			printUserTable(con);
			
			// 7. 關閉Statement物件
			if (stmt != null) stmt.close();
			// 8. 關閉Connection物件
			if (con != null) con.close();
		%>
	</body>
</html>