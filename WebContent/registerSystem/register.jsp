<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!-- 開啟registerForm.jsp測試 -->
<%
	String textUserId = request.getParameter("textUserId").trim();
	/* 
	 * 如果送出該 Form 網頁的 ContentType 為 utf-8，Tomcat 作成 request 物件時，
	 * 會將 utf-8 編碼的中文參數值先轉碼為ISO-8859-1，存入到 request 物件裡，
	 * 所以要取出request物件內的中文，就必須取出ISO-8859-1再轉回utf-8。
	 */
	request.setCharacterEncoding("utf-8");
	
	//String textNickName = new String(request.getParameter("textNickName").trim().getBytes("ISO-8859-1"), "utf-8");	// 取中文
	String textNickName = request.getParameter("textNickName").trim();
	String textPassword = request.getParameter("textPassword").trim();
	//String textUserName = new String(request.getParameter("textUserName").trim().getBytes("ISO-8859-1"), "utf-8");	// 取中文
	String textUserName = request.getParameter("textUserName").trim();
	String radioGender = request.getParameter("radioGender").trim();
	String textBirth = request.getParameter("selectYear").trim() + "-" + request.getParameter("selectMonth").trim() + "-" + request.getParameter("selectDay").trim();
	String textEmail = request.getParameter("textEmail").trim();
	String textPhone = request.getParameter("textPhone").trim();
	//String textAddr = new String(request.getParameter("textAddr").trim().getBytes("ISO-8859-1"), "utf-8");	// 取中文
	String textAddr = request.getParameter("textAddr").trim();
	String textIdLastFour = request.getParameter("textIdLastFour").trim();
	
	session.setAttribute("textUserId", textUserId);
	session.setAttribute("textNickName", textNickName);
	session.setAttribute("textPassword", textPassword);
	session.setAttribute("textUserName", textUserName);
	session.setAttribute("radioGender", radioGender);
	session.setAttribute("textBirth", textBirth);
	session.setAttribute("textEmail", textEmail);
	session.setAttribute("textPhone", textPhone);
	session.setAttribute("textAddr", textAddr);
	session.setAttribute("textIdLastFour", textIdLastFour);
%>
<jsp:useBean id="accessDbBean" class="bean.DBAccess"></jsp:useBean>
<%
	// 檢查ID是否已經存在
	boolean isIdExist = false;
	String tableName = "user";	
	accessDbBean.setConnection("mysql", "coreyou", "751201267");
	Connection con = accessDbBean.getConnection();
	String sql = "select * from " + tableName + " where userId='" + textUserId + "'";
	ResultSet rs = accessDbBean.getResultSet(sql);
	while(rs.next()) {
		isIdExist = true;
	}
	if (rs != null) rs.close();
	if (con != null) con.close();
	
	if (isIdExist) {
		out.println("<h3>本ID已被另一人註冊，請改用其他ID!</h3>");
		out.println("&lt;&lt;<a href='javascript:history.back()'>回前一畫面</a>");
	} else {
		// 準備發送確認信
		pageContext.forward("registerMail.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>

</body>
</html>