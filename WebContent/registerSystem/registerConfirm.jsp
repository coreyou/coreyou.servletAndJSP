<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!-- 開啟registerForm.jsp測試 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Email認證完成，寫入啟動時間以完成註冊</title>
	</head>
	<body>
		<jsp:useBean id="accessDbBean" class="bean.DBAccess"></jsp:useBean>
		<%
			String userMail = request.getParameter("m");
			String userCode = request.getParameter("c");
			
			// 將部分資料先寫入資料庫
			accessDbBean.setConnection("mysql", "coreyou", "751201267");
			Connection con = accessDbBean.getConnection();
			// insert
			String tableName = "user";
			String sql = "update " + tableName +  
				" set activateTime=CURRENT_TIMESTAMP where email='" + userMail + "' and activateCode='" + userCode + "'";
			System.out.println("sql: " + sql);
			int updateRows = accessDbBean.getUpdate(sql);
			if (updateRows > 0) {
				out.println("<p>sql= " + sql + "</p>");
				out.println("成功更新 <font color='red'>" + updateRows + "</font> 筆紀錄!<hr />");
				out.println("註冊成功!!");
			}
		%>
	</body>
</html>