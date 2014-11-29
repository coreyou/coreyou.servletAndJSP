<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="sun.misc.BASE64Encoder,java.io.InputStream,java.io.File"%>
<%@ page import="java.net.URLEncoder" %>
<%-- 與cookieBase64Decode.jsp連動 --%>
<%
	File file = new File(this.getServletContext().getRealPath("/images/errorstate.gif"));

	byte[] binary = new byte[(int)file.length()];	// 二進位數字組
	
	// 從圖片檔案讀取二進位資料
	InputStream ins = this.getServletContext().getResourceAsStream("/images/errorstate.gif");
	ins.read(binary);
	ins.close();
	
	String content = BASE64Encoder.class.newInstance().encode(binary);
	// Base64編碼
	Cookie cookie = new Cookie("file", URLEncoder.encode(content, "utf-8"));	// 包含二進位資料的cookie，這裡使用utf-8編碼，避免造成new Cookie時某些特殊字元會造成例外發生
	response.addCookie(cookie);	// 將cookie發送到用戶端
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Cookie Encoding</title>
	</head>
	<body>
		<p>從cookie中獲得的二進位圖片: <img src="cookieBase64Decode.jsp" /></p><br />
		<textarea rows="" cols="" id="cookieArea" style="width:100%; height:200px; "></textarea>
		<script type="text/javascript">cookieArea.value=document.cookie;</script>
	</body>
</html>