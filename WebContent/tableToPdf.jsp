<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*, java.sql.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>
<%-- 與db_schemaShowTable.jsp連動，開啟db_schemaBrowse.jsp測試 --%>
<%!
	// !!!目前處理中文字有問題
	private Phrase phrase (String word, String font) {
		String fontMing = "C:\\Windows\\Fonts\\mingliu.ttc,1";	// 細明體
		String fontKaiu = "C:\\Windows\\Fonts\\kaiu.ttf";	// 標楷體
		String fontPath;
		
		Phrase ph = null;
		if (font.equals("ming")) {
			fontPath = fontMing;
		} else {
			fontPath = fontKaiu;
		}
		
		try {
			// 水平書寫、不內嵌此字型
			BaseFont bf = BaseFont.createFont(fontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return ph;
	}

	private void transferToPdf(ResultSet rs, String tableName) {
		String finalString = "";
		String filePath = "/tableToPdf.pdf";	// C:\tableToPdf.pdf
		try {
			// 紙張尺寸、左、右、上、下邊界
			Document document = new Document(PageSize.A4, 24, 24, 36, 36);
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(filePath));
			document.open();
			PdfPTable table = null;
			PdfPCell cell = null;
			int colCount = 0;
			int rowCount = 0;
			// document.add(new Paragraph("Hello World"));
			while(rs.next()) {			
				if (rowCount == 0) {
					ResultSetMetaData rsmd = rs.getMetaData();
					colCount = rsmd.getColumnCount();	// 欄位總數
					table = new PdfPTable(colCount);	// 產生colCount欄的表格
					table.setWidthPercentage(96f);	// 設定此table佔據頁面寬度的百分比
					// 顯示欄位名稱
					for (int colNo = 1; colNo <= colCount; colNo++) {
						// 以標楷體於儲存格顯示欄位名稱
						//cell = new PdfPCell(phrase(rsmd.getColumnName(colNo), "kaiu"));
						cell = new PdfPCell(new Paragraph(rsmd.getColumnName(colNo)));
						// 設定灰底背景，0 <= x < 1，值越大顏色越淡
						cell.setGrayFill(0.9f);
						table.addCell(cell);
					}
				}
				// 顯示欄位內容
				for (int colNo = 1; colNo <= colCount; colNo++) {
					// 以細明體顯示欄位內容
					//cell = new PdfPCell(phrase(rs.getString(colNo), "ming"));
					cell = new PdfPCell(new Paragraph(rs.getString(colNo)));
					table.addCell(cell);
				}
				rowCount++;
			}
			// 儲存與關閉PDF檔案
			document.add(table);
			document.close();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} catch (DocumentException dee) {
			dee.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
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
		transferToPdf(rs, tableName);
		if (rs != null) rs.close();
		if (con != null) con.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>資料表轉成PDF檔案</title>
	</head>
	<body>
		<embed src="/tableToPdf.pdf" width="100%" height="100%">
		<%
			}
			else {
				out.println("<p>未指定欲顯示的資料表...</p>");
			}
		%>
	</body>
</html>