<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    <%!	
    	// 印出user這個資料表的內容
		void printUserTable(Connection con) {
			try {
				Statement stat = con.createStatement();
				ResultSet rs = stat.executeQuery("select * from userTest");
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
		<title>getMetaData() 取得欄位名稱與內容</title>		
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
			String sql = "select * from userTest order by userId";
			ResultSet rs = stmt.executeQuery(sql);
			
			// 6. 進行資料的處理
			ResultSetMetaData rsmd = rs.getMetaData();
			int colCount = rsmd.getColumnCount();	// 取得欄位總數
			/*
			 * 印出整個TABLE
			 */
			out.println("<table>");
			int j = 0;
			while (rs.next()) {
				// TABLE第一列是標題列
				if (j == 0) {
					out.println("<tr bgcolor='yellow'>");
					out.println("<th scope='col'>項次</th>");
					for (int intNo = 1; intNo <= colCount; intNo++) {
						out.println("<th scope='col'>" + rsmd.getColumnName(intNo) + "</th>");
					}
					out.println("</tr>");
				}
				// 內容列
				out.println("<tr>");
				out.println("<td>" + (j+1) + "</td>");
				for (int intNo = 1; intNo <= colCount; intNo++) {
					String strValue = rs.getString(intNo);
					if (!rs.wasNull()) {
						out.println("<td>" + strValue + "</td>");
					} else {
						out.println("<td>Empty</td>");
					}
				}
				out.println("</tr>");
				j++;
			}
			out.println("</table><hr />");
			
			// 7. 關閉Statement物件
			if (stmt != null) stmt.close();
			// 8. 關閉Connection物件
			if (con != null) con.close();
		%>
	</body>
</html>