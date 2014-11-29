<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" isErrorPage="true"%>
<%@ page import="java.net.URLDecoder" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%-- 與cookieAccess.jsp連動 --%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
		<title>設定與存取Cookie_Login</title>
		<%
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			
			if("POST".equals(request.getMethod())) {				
				Cookie cookie1 = new Cookie("UserName", request.getParameter("userName"));	// new Cookie(String name, String value)，name和value都只能是字串
				Cookie cookie4 = new Cookie(URLEncoder.encode("姓名", "utf-8"), URLEncoder.encode("金城武", "utf-8"));	// key和value都用utf-8編碼，來達成存取中文
				Cookie cookie2 = new Cookie("VisitTimes", "0");
				Date datDate = new Date();
				String strDate = String.valueOf(datDate.getTime());
				Cookie cookie3 = new Cookie("LastTime", strDate);
				
				response.addCookie(cookie1);	// 將cookie變數加入Cookie中
				response.addCookie(cookie2);
				response.addCookie(cookie3);
				
				response.sendRedirect(request.getContextPath() + "/cookieAccess.jsp");				
				return;
			}
			
		%>
	</head>
	<body>
		<div align="center" style="margin:10px; ">		
			<fieldset>
				<legend>登入</legend>
				<form action="cookieAccessLogin.jsp" method="POST">
					<table>
						<tr>
							<th></th>
							<td>
								<span><img alt="error state" src="images/errorstate.gif"></span>
								<span style="color:red; "><%= exception.getMessage() %></span>
							</td>
						</tr>
						<tr>
							<th>帳號: </th>
							<td>
								<input type="text" name="userName" style="width:200px; ">
							</td>
						</tr>
						<tr>
							<th>密碼: </th>
							<td>
								<input type="password" name="password" style="width:200px; ">
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<input type="submit" value="登 錄" class="button" >
							</td>
						</tr>
					</table>
				</form>
			</fieldset>
		</div>
	</body>
</html>