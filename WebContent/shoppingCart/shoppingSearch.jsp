<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<jsp:useBean id="accessDbBean" class="bean.DBAccess"></jsp:useBean>
<%!
	private String adjustStr(String adjStr) {
		String finalStr = "";
		adjStr = adjStr.trim();
		String strA;
		if (adjStr.length() > 0) {
			for (int i = 0; i < adjStr.length(); i++) {
				// 每次取一個字元
				if (i == (adjStr.length() - 1)) {	// 若為最後一個字元
					strA = adjStr.substring(i);
				} else {
					strA = adjStr.substring(i, i+1);
				}
				// 判斷"["、"|"、"'"三種
				if (strA.equals("[")) {
					finalStr += "[[]";
				} else if (strA.equals("|")) {
					finalStr += "[{-}]";
				} else if (strA.equals("'")) {
					finalStr += "''";
				} else {
					finalStr += strA;
				}
			}
		}
		return finalStr;
	}
%>
<%
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
	
	if (!isReg) { // 若尚未註冊
		pageContext.forward("shoppingRegister.jsp");	// 重新回到註冊畫面
	} else {
		out.println("<html>");
		out.println("<head><title>查看購物車</title></head>");
		out.println("<body>");
		String tableName = "book";
		// 如果全部都沒有值，就顯示表單欄位
		if (request.getParameter("bookNo") == null && request.getParameter("author") == null && 
				request.getParameter("pubDate") == null && request.getParameter("bookName") == null) {
			out.println("<h1>線上圖書館</h1><hr />");
			out.println("<form action='shoppingSearch.jsp' method='post'>");
		}
	}
%>