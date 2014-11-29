<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Detect Browser JSP</title>
	</head>
	<body>
		<%
			/* 
			 * 偵測現在所使用的瀏覽器，並做頁面導向，步驟如下:
			 * 1. Client 發送Request給Web Server。
			 * 2. Web Server 發送Redirect message給Client瀏覽器。
			 * 3. Client 確認以後，發送Request給Wbe Server，去請求新頁面(redirected page)。
			 * 4. Web Server回傳redirected page給Client。
			 *
			 * <jsp: forward>省略了以上2.3.兩個步驟，更省時間。(請參考actionElementBean.jsp row.42~49)
			 */
			final String header = "user-agenet";
			String strValue = request.getHeader(header);
			if (strValue.indexOf("MEIE") > -1) {
				response.sendRedirect("Ie.html");	// sendRedirect()之後的out.println將不起作用，因為已經導向到下一個網頁。
			} else if (strValue.indexOf("Mozilla") > -1) {
				response.sendRedirect("Firefox.html");
			} else {
				response.sendRedirect("Unknown.html");
			}
		%>
	</body>
</html>