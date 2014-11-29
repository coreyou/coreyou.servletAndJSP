<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="sun.misc.BASE64Decoder" trimDirectiveWhitespaces="true"%>
<%@ page import="java.net.URLDecoder" %>    
<%-- 與cookieBase64.jsp連動 --%>
<%
	out.clear();	// 清除輸出
	for (Cookie cookie : request.getCookies()) {
		if (cookie.getName().equals("file")) {
			byte[] binary = BASE64Decoder.class.newInstance().decodeBuffer(URLDecoder.decode(cookie.getValue(), "utf-8").replace(" ", ""));	// 編碼BASE64編碼的二進位內容
			response.setHeader("Content-Type", "image/gif");	// 設定內容型別為gif圖片
			response.setHeader("Content-Disposition", "inline;filename=errorstate.gif");
			response.setHeader("Connection", "close");
			response.setContentLength(binary.length);	// 設定輸出內容長度
			response.getOutputStream().write(binary);	// 輸出到用戶端
			response.getOutputStream().flush();			// 清空快取記憶體
			response.getOutputStream().close();			// 關閉輸出流
			return;
		}
	}
%>