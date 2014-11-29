<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%!
	int pageNoNow;	// 目前所在頁碼
	int totalPageNo;	// 最大頁碼
	int rowPosition = 0;	// 目前所在資料列列碼
	int pageSize = 10;	// 單頁設定資料列列數
	
	int rowNo = 0;
	private String showResult(ResultSet rs) {
		String finalStr = "";
		int colCount = 0;
		rowNo = 0;
		try {
			while(rs.next()) {
				if ((rowNo+1) <= pageSize) {
					if (rowNo == 0) {	// 印表格的header
						ResultSetMetaData rsmd = rs.getMetaData();
						colCount = rsmd.getColumnCount();	// 取得欄位總數
						finalStr = "<table><tr bgcolor='lightblue'><th scope='col'><b>No.</b></th>";
						for (int j = 1; j <= colCount; j++) {
							finalStr += "<th scope='col'><b>" + rsmd.getColumnName(j) + "</b></th>";
						}
						finalStr += "</tr>";
					}
					
					finalStr += "<tr><td>" + (rowNo+1) + "</td>";	// row no.
					for (int j = 1; j <= colCount; j++) {
						finalStr += "<td>" + rs.getString(j) + "</td>";
					}
					finalStr += "</tr>";
					rowNo++;	
				}				
			}
			finalStr += "</table>";
		} catch (SQLException se) {
			finalStr += "Error occurred: " + se.toString() + "<br />";
		}
		return finalStr;
	}
	
	/**
	 *	換頁連結按鈕: 最前頁 上一頁 下一頁 最末頁
	 */
	private String displayButton() {
		String finalString = "";
		if (pageNoNow > 1) {
			finalString = "<a href='pagingQuery.jsp?pageNo=1'> 最前頁 </a>&nbsp;&nbsp;" + 
				"<a href='pagingQuery.jsp?pageNo=" + (pageNoNow-1) + "'> 上一頁 </a>&nbsp;&nbsp;";
		}
		if (pageNoNow < totalPageNo) {
			finalString += "<a href='pagingQuery.jsp?pageNo=" + (pageNoNow+1) + "'> 下一頁 </a>&nbsp;&nbsp;" + 
				"<a href='pagingQuery.jsp?pageNo=" + totalPageNo + "'> 最末頁 </a>&nbsp;&nbsp;";
		}
		finalString += "<br />";
		return finalString;
	}
	
	/**
	 *	進階換頁連結按鈕: 1... 7 8 9 10 11 < 12 > 13 14 15 16 17 ...20
	 */
	private String displayButtonAdvanced() {
		String finalString = "";
		int nearPageCount = 5;
		boolean isFarFromFirst = (pageNoNow-1 > nearPageCount) ? true : false;	// 7-1=6, 6>(nearPageCount=5), 第七頁是第一個far from first page的頁面
		boolean isFarFromLast = (totalPageNo-pageNoNow > nearPageCount) ? true : false;
		
		// 處理比[現在頁碼]數值還小的頁碼
		if (isFarFromFirst) {
			finalString = "<a href='pagingQuery.jsp?pageNo=1'> 1... </a>&nbsp;&nbsp;";	// 第一頁...
			for (int i = pageNoNow-nearPageCount; i < pageNoNow; i++) {
				finalString += "<a href='pagingQuery.jsp?pageNo=" + i +"'> " + i + " </a>&nbsp;&nbsp;";
			}
		} else {		
			for (int i = 1; i < pageNoNow; i++) {
				finalString += "<a href='pagingQuery.jsp?pageNo=" + i + "'> " + i + " </a>&nbsp;&nbsp;";
			}			
		}
		
		// 上一頁(如果[現在頁碼]不是第一頁的話才可以使用)
		if (pageNoNow != 1) {	
			finalString += "<a href='pagingQuery.jsp?pageNo=" + (pageNoNow-1) + "'> < </a>&nbsp;&nbsp;";	
		}
		// 現在頁碼
		finalString += "<a href='pagingQuery.jsp?pageNo=" + pageNoNow + "'><b><font size='12'> " + pageNoNow + " </font></b></a>&nbsp;&nbsp;";	
		// 下一頁(如果[現在頁碼]不是最後一頁的話才可以使用)
		if (pageNoNow != totalPageNo) {	
			finalString += "<a href='pagingQuery.jsp?pageNo=" + (pageNoNow+1) + "'> > </a>&nbsp;&nbsp;";
		}
		
		// 處理比[現在頁碼]數值還大的頁碼
		if (isFarFromLast) {
			for (int i = pageNoNow+1; i <= pageNoNow+5; i++) {
				finalString += "<a href='pagingQuery.jsp?pageNo=" + i + "'> " + i + " </a>&nbsp;&nbsp;";
			}
			finalString += "<a href='pagingQuery.jsp?pageNo=" + totalPageNo + "'> ..." + totalPageNo + " </a>&nbsp;&nbsp;";	// ...最後一頁
		} else {
			for (int i = pageNoNow+1; i <= totalPageNo; i++) {
				finalString += "<a href='pagingQuery.jsp?pageNo=" + i + "'> " + i + " </a>&nbsp;&nbsp;";
			}
		}
		
		return finalString;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>分頁控制</title>
	</head>
	<body>
		<%
			String tableName = "loginlog";
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
				"coreyou","751201267");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			String sql = "select * from " + tableName + " order by loginId";
			ResultSet rs = stmt.executeQuery(sql);
			
			rs.last();
			int totalRow = rs.getRow();
			if (totalRow > 0) {
				// 計算筆數
				if (totalRow % pageSize == 0) {
					totalPageNo = totalRow/pageSize;
				} else {
					totalPageNo = (totalRow/pageSize)+1;
				}
				
				String paramPageString;
				// 處理指定頁數(http://localhost/coreyou.servletAndJSP/pagingQuery.jsp?pageNo=1)
				if (request.getParameter("pageNo") == null || request.getParameter("pageNo") == "") {
					paramPageString = "1";
				} else {
					paramPageString = request.getParameter("pageNo");
				}				
				pageNoNow = Integer.parseInt(paramPageString);				
				if (pageNoNow > totalPageNo) {	// 如果指定的頁數超出最後一頁
					pageNoNow = totalPageNo;
				} else if (pageNoNow < 1) {	// 如果指定的頁數超出第一頁
					pageNoNow = 1;
				}
				
				out.println("<p><b><small>Page :" + pageNoNow + " of " + totalPageNo + "</small></b></p>");
				rowPosition = pageSize * (pageNoNow - 1);	// 取得正確的資料列位置
				// 游標移到符合條件的第一筆紀錄之前
				if (rowPosition == 0) {
					rs.beforeFirst();
				} else {
					rs.absolute(rowPosition);
				}
				
				out.println(showResult(rs));
				out.println("<hr />");
			}
			if (rs != null) rs.close();
			if (con != null) con.close();
			
			out.println(displayButton());
			out.println(displayButtonAdvanced());
		%>
	</body>
</html>