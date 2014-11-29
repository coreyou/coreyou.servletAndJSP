<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" errorPage="cookieAccessLogin.jsp"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- 與cookieAccessLogin.jsp連動 --%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
		<title>設定與存取Cookie_AfterLogin</title>
		<%
			request.setCharacterEncoding("utf-8");
		
			int visitTimes = 0;			
			Cookie[] cookies = request.getCookies();	// 所有的cookie
			Cookie cookie1 = null;
			String strTemp = "";
			String strName = "";
			String strTimes = "";
			String strDate = "";
			int counter = cookies.length;
			// 使用迴圈來取得所有cookie
//			if (request.getCookies() != null) {
//				for (Cookie cc : request.getCookies()) {
//					String cookieName = URLDecoder.decode(cc.getName(), "utf-8");	// 讀取中文的時候必須設定編碼
//					String cookieValue = URLDecoder.decode(cc.getValue(), "utf-8");
//				}
//			}
			for (int i = 0; cookies != null && i < counter; i++) {
				strTemp = cookies[i].getName();	// 取cookie的name
				if ("UserName".equals(strTemp)) {
					strName = cookies[i].getValue();	// 取cookie的value
					cookie1 = cookies[i];
				} else if ("VisitTimes".equals(strTemp)) {
					strTimes = cookies[i].getValue();
					visitTimes = Integer.parseInt(strTimes);
				} else if ("LastTime".equals(strTemp)) {
					strDate = cookies[i].getValue();
				}
			}
			
			// 如果沒有找到使用者名稱，則轉到登入介面
			if (strName == null || strName.trim().equals("")) {
				throw new Exception("您還沒有登入。請先登入");
			}
			
			// 存取次數+1
			Cookie visitTimesCookie = new Cookie("VisitTimes", Integer.toString(++visitTimes));
			response.addCookie(visitTimesCookie);	// 覆蓋原來的同名cookie
			
		%>
	</head>
	<body>
		<h3>
			Hello, <%= strName %> <br />
			您上一次光臨本站是 -> <%= strDate %>
		</h3>
		<hr />
		<div align="center" style="margin:10px; " >
			<fieldset>
				<legend>登入資訊</legend>
					<form action="cookieAccessLogin.jsp" method="POST">
						<table>
							<tr>
								<th scope="row">您的帳號: </th>
								<td><%= strName %></td>
							</tr>
							<tr>
								<th scope="row">登入次數: </th>
								<td><%= strTimes %></td>
							</tr>
							<tr>
								<th></th>
								<td>
									<input type="button" value="刷 新" onClick="location='<%= request.getRequestURI() %>?ts=' + new Date().getTime(); " class="button" >
								</td>
							</tr>
						</table>
					</form>
					<hr />
				<legend>userName cookie資訊</legend>
					<%			
						out.println("cookie的最大存活時間(秒)(-1表示若沒關閉瀏覽器則永續存在): " + cookie1.getMaxAge() + "<br />");
						cookie1.setMaxAge(60*60*24*3);	// 3天
						out.println("設定cookie的最大存活時間為三天以後: " + cookie1.getMaxAge() + "<br /><hr />");
						
						out.println("cookie的網域名稱: " + cookie1.getDomain() + "<br />");
						cookie1.setDomain("tw.yahoo.com");
						out.println("設定在tw.yahoo.com中也可以使用此cookie: " + cookie1.getDomain() + "<br /><hr />");
						
						out.println("cookie的網頁路徑: " + cookie1.getPath() + "<br />");	// 比如tw.yahoo.com/auction中的/auction就是網頁路徑
						cookie1.setPath("/process");
						out.println("設定在/process路徑下也可以使用此cookie: " + cookie1.getPath() + "<br /><hr />");
						
						out.println("cookie是否藉由SSL(Secure Sockets Layer)的方式傳輸: " + cookie1.getSecure() + "<br />");
						cookie1.setSecure(true);
						out.println("設定cookie藉由SSL傳輸: " + cookie1.getSecure() + "<br /><hr />");
					%>
			</fieldset>
		</div>
	</body>
</html>