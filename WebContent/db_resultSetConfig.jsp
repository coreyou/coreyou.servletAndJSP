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
		<title>取得/設定ResultSet相關屬性</title>		
	</head>
	<body>
		<h2>取得/設定ResultSet相關屬性</h2>
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
			
			// 7. 關閉ResultSet與Statement物件
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			// 8. 關閉Connection物件
			if (con != null) con.close();
		%>
	</body>
</html>