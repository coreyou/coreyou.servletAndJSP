<%@page import="com.mysql.jdbc.SQLError"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*, java.sql.*, java.util.*, org.apache.poi.hssf.usermodel.*, org.apache.poi.hssf.util.*" %>
<%-- 與db_schemaShowTable.jsp連動，開啟db_schemaBrowse.jsp測試 --%>
<%!
	private void transferToExcel (ResultSet rs, String tableName) {
		String finalString = "";
		int colCount = 0;
		int colNo = 0;
		int rowNo = 0;
		try {
			// "/"代表Web應用的跟目錄。"./" 代表當前目錄。"../"代表上級目錄。
			String filePath = getServletContext().getRealPath("/") + "/doc/tableToExcel.xls";	// C:\Users\coreyou\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\coreyou.servletAndJSP\
			
			// 建立活頁簿
			HSSFWorkbook wb = new HSSFWorkbook();
			// 建立工作表
			HSSFSheet sheet = wb.createSheet(tableName);
			HSSFRow row;
			while (rs.next()) {
				if (rowNo == 0) {	// 表格header
					// 第一列的背景顏色設為實心黃色
					HSSFCellStyle style = wb.createCellStyle();
					style.setFillForegroundColor(HSSFColor.YELLOW.index);
					style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
					ResultSetMetaData rsmd = rs.getMetaData();
					colCount = rsmd.getColumnCount();	// 取得欄位總數
					// 顯示欄位名稱
					for (colNo = 1; colNo <= colCount; colNo++) {
						// 建立橫列
						if (colNo == 1) {
							row = sheet.createRow(rowNo);	// 只有在第一列的第一欄需要去創一個新的列(index為0)，除了第一欄以外都只要去取得第一欄的時候所建的
						} else {
							row = sheet.getRow(rowNo);
						}
						// 定位欄，和列交叉為一儲存格(index從0開始)
						HSSFCell cell = row.createCell(colNo-1);
						// 存入欄位名稱(索引值從1開始)
						cell.setCellValue(rsmd.getColumnName(colNo));
						cell.setCellStyle(style);	// 套用前面所設定的style
					}
				}
				
				// 取得資料列內容
				for (colNo = 1; colNo <= colCount; colNo++) {
					// 建立橫列、儲存格
					if (colNo == 1) {
						row = sheet.createRow(rowNo+1);
					} else {
						row = sheet.getRow(rowNo+1);
					}
					HSSFCell cell = row.createCell(colNo-1);
					// 存入欄位值
					cell.setCellValue(rs.getString(colNo));
				}
				rowNo++;
			}
			// 儲存並關閉Excel檔案
			FileOutputStream fos = new FileOutputStream(filePath);
			wb.write(fos);
			fos.close();
		} catch (SQLException se) {
			finalString += "SQL Error: " + se.toString() + "<br />";
		} catch (IOException ioe) {
			finalString += "IO Error: " + ioe.toString() + "<br />";
		}
	}
%>
<jsp:useBean id="dbAccess" class="bean.DBAccess"></jsp:useBean>
<%
	String tableName;
	if (request.getParameter("tableName") == null || request.getParameter("tableName") == "") {
		tableName = "null";
	} else {
		tableName = new String(request.getParameter("tableName").getBytes("ISO-8859-1"));
	}
	
	if (!tableName.equals("null")) {
		dbAccess.setConnection("mysql", "coreyou", "751201267");
		Connection con = dbAccess.getConnection();
		String sql = "select * from " + tableName;
		ResultSet rs = dbAccess.getResultSet(sql);
		transferToExcel(rs, tableName);
		if (rs != null) rs.close();
		if (con != null) con.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>資料表轉成Excel活頁簿</title>		
		<script type="text/javascript">
			window.location="/coreyou.servletAndJSP/doc/tableToExcel.xls"
		</script>
	</head>
	<body>
		<%
			}
			else {
				out.println("<p>未指定欲顯示的資料表...</p>");
			}
		%>
	</body>
</html>