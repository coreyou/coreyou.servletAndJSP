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
		<title>使用absolute(), relative(), updateRow()來修改紀錄</title>		
	</head>
	<body>
		<h2>使用absolute(), relative(), updateRow()來修改紀錄</h2>
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
			String sql = "select * from " + tableName + " order by userId";
			ResultSet rs = stmt.executeQuery(sql);			
			
			// 6. 設定或取出相關資料
			// 新增三筆紀錄
			rs.moveToInsertRow();	// 指標移到新增紀錄上
			rs.updateString(1, "4");
			rs.updateString(2, "John");
			rs.updateString(3, "john@gmail.com");
			rs.insertRow();
			rs.moveToInsertRow();
			rs.updateString(1, "5");
			rs.updateString(2, "Ken");
			rs.updateString(3, "ken@gmail.com");
			rs.insertRow();
			rs.moveToInsertRow();
			rs.updateString(1, "6");
			rs.updateString(2, "Sonic");
			rs.updateString(3, "sonic@gmail.com");
			rs.insertRow();
			rs.close();
			
			sql = "select * from " + tableName + " where (userId >= 4 && userId <= 6) order by userId";
			rs = stmt.executeQuery(sql);	
			out.println("印出新增的三筆紀錄");
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
			
			// 更改三筆中的第一筆資料
			rs.absolute(1);	// 移到新增的第1筆紀錄，若為負值表示從最後一筆開始算，rs.relative(5)則是往下移動相對5筆
			rs.updateString("email", "'john@msn.com");	// 更改的資料中不能有單引號，會導致錯誤
			rs.updateRow();
			rs.cancelRowUpdates();	// 反悔時取消
			
			rs.absolute(-3);
			rs.updateString(2, "sam");
			rs.updateString("email", "sam@msn.com");
			rs.updateRow();
			
			out.println("印出更改後的TABLE內容");
			rs.beforeFirst();	// 指標移到第一筆紀錄之前
			out.println("<table>");
			i = 0;
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
			
			// 刪除剛剛新增的三筆資料
			rs.first();	// 移到第一筆紀錄
			rs.deleteRow();	// 刪除
			rs.first();
			rs.deleteRow();
			rs.first();
			rs.deleteRow();
			out.println("<p>成功刪除三筆資料!</p>");
			
			// 7. 關閉ResultSet與Statement物件
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			// 8. 關閉Connection物件
			if (con != null) con.close();
		%>
	</body>
</html>