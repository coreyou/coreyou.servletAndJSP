<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%!
	int i = 0;
	private String showResult(ResultSet rs) {
		String finalStr = "";
		int colCount = 0;
		i = 0;
		try {
			while(rs.next()) {
				if (i == 0) {	// 印表格的header
					ResultSetMetaData rsmd = rs.getMetaData();
					colCount = rsmd.getColumnCount();	// 取得欄位總數
					finalStr = "<table><tr bgcolor='lightblue'><th scope='col'><b>No.</b></th>";
					for (int j = 1; j <= colCount; j++) {
						finalStr += "<th scope='col'><b>" + rsmd.getColumnName(j) + "</b></th>";
					}
					finalStr += "</tr>";
				}
				finalStr += "<tr><td>" + (i+1) + "</td>";	// row no.
				for (int j = 1; j <= colCount; j++) {
					finalStr += "<td>" + rs.getString(j) + "</td>";
				}
				finalStr += "</tr>";
				i++;
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
		<title>陣列的應用(時間區間的資料查詢)</title>
		<script type="text/javascript">
			<!--
				// 以下為年月日檢核
				var month = new Array("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec");
				var date1, date2;
				function chkDate(strDate, strTitle, intPos) {
					var aryDate, yearLength, monthLength, dayLength, daysInMonth;
					var sDate;
					
					if (strDate.length == 0) {
						window.alert("「" + strTitle + "」不得為空白!");
						focusTo(intPos);
						return false;
					}
					
					aryDate = strDate.split("-");	// 切割陣列，例如2014-6-17會被切成{2014, 6, 17}					
					if (aryDate.length != 3) {	// 沒被切成三個陣列元素，表示年月日三者之中有缺漏
						window.alert("「" + strTitle + "」格式不符!(aryDate.length != 3)");
						focusTo(intPos);
						return false;
					}
					
					if (aryDate[0].length == 0 || aryDate[1].length == 0 || aryDate[2].length == 0) {
						window.alert("「" + strTitle + "」格式不符!(aryDate[0].length == 0 || aryDate[1].length == 0 || aryDate[2].length == 0)")
						focusTo(intPos);
						return false;
					}
					
					yearLength = aryDate[0].length;
					if (yearLength < 4 || aryDate[1] < 1 || aryDate[1] > 12) {
						window.alert("「" + strTitle + "」格式不符!(yearLength < 4 || aryDate[1] < 1 || aryDate[1] > 12)")
						focusTo(intPos);
						return false;
					}
					
					// 1.西元末兩位不為00，且為4的倍數，則該年為閏年。 2.西元末兩位為00，則可被400整除者，則該年為閏年，否則為平年。
					if (aryDate[1] == 2) {
						if (((aryDate[0] % 4 == 0) && (aryDate[0] % 100 != 0)) || (aryDate[0] % 400 == 0)) {
							daysInMonth = 29;
						} else {
							daysInMonth = 28;	
						}
					} else if (aryDate[1] == 4 || aryDate[1] == 6 || aryDate[1] == 9 || aryDate[1] == 11) {
						daysInMonth = 30;
					} else {
						daysInMonth = 31;
					}
					
					if (aryDate[2] < 1 || aryDate[2] > daysInMonth) {						
						window.alert("「" + strTitle + "」格式不符!(arydate[2] < 1 || aryDate[2] > daysInMonth)");
						focusTo(intPos);
						return false;
					}
					
					sDate = month[aryDate[1]-1] + " " + aryDate[2] + ", " + aryDate[0] + " 00:00:00";
					if (intPos == 0) {	// 起始欄位的值丟回給全域變數
						date1 = new Date(sDate);
					} else {	// 截止欄位的值丟回給全域變數
						date2 = new Date(sDate);
					}
					return true;
				}
				
				function dataCheck() {
					var bolPass, datFrom, datTo;
					var bolPass = false;
					
					if (chkDate(frmDate.dateFrom.value, "起始日期", 0)) {		// 檢查完起始日期，才能檢查截止日期
						bolPass = chkDate(frmDate.dateTo.value, "截止日期", 1);
					}

					if (bolPass) {
						datFrom = frmDate.dateFrom.value;
						datTo = frmDate.dateTo.value;
						if (date1 > date2) {
							window.alert("「起始日期」需早於「截止日期」");
							focusTo(0);
							return false;
						} else {
							frmDate.submit();
						}
					}
				}
				
				function focusTo(x) {
					document.forms[0].elements[x].focus();
				}
			 -->
		</script>
	</head>
	<body>
		<jsp:useBean id="dbBean" class="bean.DBAccess"></jsp:useBean>
		<%
			String strFrom, strTo;
		
			if (request.getParameter("dateFrom") == null || request.getParameter("dateFrom") == "") {
				strFrom = "";
			} else {
				strFrom = request.getParameter("dateFrom").trim();
			}
			
			if (request.getParameter("dateTo") == null || request.getParameter("dateTo") == "") {
				strTo = "";
			} else {
				strTo = request.getParameter("dateTo").trim();
			}
		%>
		<h2>使用者登入紀錄查詢</h2>
		<form method="post" name="frmDate"><!-- 省略action屬性，表示後端的JSP文件即為自己本身 -->
			<p>
				起始日期: <input type="text" size="10" maxlength="10" name="dateFrom" value="<%= strFrom %>">
				&nbsp;&nbsp;
				截止日期: <input type="text" size="10" maxlength="10" name="dateTo" value="<%= strTo %>">(格式:2014-8-26)
				&nbsp;&nbsp;
				<input type="button" value="查 詢" onclick="dataCheck()">
			</p>
		</form>
		<hr />
		<%
			if (strFrom != "" && strTo != "") {
				String wc = "'";	// MySQL的常數字元'
				String bgnDate = request.getParameter("dateFrom") + " 00:00";
				String endDate = request.getParameter("dateTo") + " 23:59";
				String sql =  "select * from loginlog where loginTime between " + wc + bgnDate + wc + " and " + wc + endDate + wc;
				
				dbBean.setConnection("mysql", "coreyou", "751201267");
				Connection con = dbBean.getConnection();
				ResultSet rs = dbBean.getResultSet(sql);
				out.println(showResult(rs));
				
				if (i <= 0) {
					out.println("<p>無任何符合條件之紀錄...</p>");					
				}
				out.println("<hr />");
				
				if (rs != null) rs.close();
				if (con != null) con.close();
			}
		%>
	</body>
</html>