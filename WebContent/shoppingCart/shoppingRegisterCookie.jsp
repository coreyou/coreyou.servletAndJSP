<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String uid = request.getParameter("userId").trim();
	String email = request.getParameter("email").trim();
	
	Cookie cookie1 = new Cookie("uid", uid);
	Cookie cookie2 = new Cookie("email", email);
	int intSec = 60*60*24;	// 保留一天
	cookie1.setMaxAge(intSec);
	cookie2.setMaxAge(intSec);
	response.addCookie(cookie1);
	response.addCookie(cookie2);
	// 檢查是否已經註冊
	Object obj = session.getAttribute("RegOk");
	boolean isReg = true;
	if (obj == null) {
		isReg = false;
	} else {
		String strOk = (String)session.getAttribute("RegOk");
		if (!strOk.equalsIgnoreCase("true")) {
			isReg = false;
		}
	}
	
	if (!isReg) {
		// 初始化session變數
		session.setAttribute("purNo", "0");	// 訂單筆數設成0
		session.setAttribute("RegOk", "true");	// 已通過註冊程序
	}
	pageContext.forward("shoppingSearch.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
	
	</body>
</html>