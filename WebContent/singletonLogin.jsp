<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:directive.page import="listener.PersonInfo" />
<%-- 和LoginSessionListener.java、PersonInfo.java有關，要測試的時候要記得把web.xml中CacheFilter那段都註解起來 --%>
<%
	String action = request.getParameter("action");
	String account = request.getParameter("account");
	String msg = (String) session.getAttribute("msg");
	PersonInfo personInfo = (PersonInfo) session.getAttribute("personInfo");

	if("login".equals(action) && account.trim().length() > 0) {
	
		// 登入，設定personInfo，將personInfo放入session
		personInfo = new PersonInfo();
		personInfo.setAccount(account.trim().toLowerCase());
		personInfo.setIp(request.getRemoteAddr());
		personInfo.setLoginDate(new java.util.Date());
		// 觸發LoginSessionListener attributeAdded()
		session.setAttribute("personInfo", personInfo);
		
		response.sendRedirect(response.encodeRedirectURL(request.getRequestURI()));
		return;
		
	} else if("logout".equals(action)) {
	
		// 登出，將personInfo從session中移除，觸發attributeRemoved()
		session.removeAttribute("personInfo");
		
		response.sendRedirect(response.encodeRedirectURL(request.getRequestURI()));
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>簡單登入頁面</title>
		<style type="text/css">
		body {
			font-size:12px; 
		}
		</style>
	</head>
	<body>
		
		<c:choose>
		
			<c:when test="${ personInfo != null }">
				<!-- 已經登入，顯示帳號訊息 -->
				歡迎您，${ personInfo.account }。<br/> 
				您的登入IP為${ personInfo.ip }，<br/>
				登入時間為<fmt:formatDate value="${ personInfo.loginDate }" pattern="yyyy-MM-dd HH:mm"/>。
				<a href="${ pageContext.request.requestURI }?action=logout">退出</a>
				
				<!-- 每5秒鐘刷新一次頁面 -->
				<script>setTimeout("location=location; ", 5000); </script>
			</c:when>
			
			<c:otherwise>
				<!-- 沒有登入，顯示登入頁面 -->
				${ msg } 
				<c:remove var="msg" scope="session" />
				<form action="${ pageContext.request.requestURI }?action=login" method="POST">
					帳號：
					<input name="account" />
					<input type="submit" value="登入">
				</form>
			</c:otherwise>
		
		</c:choose>

	</body>
</html>
