<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%!
	 	// 在JSP生命週期中，jspInit()會在_jspService()之前執行，而且每個JSP只會執行一次，我們在這裡設定counter Attribute的初始值
		public void jspInit() {
			ServletContext application = this.getServletContext();
			application.setAttribute("counter", "0");
		}
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>訪客計數器加強版</title>
	</head>
	<body>
		<%
			String strNo = (String)application.getAttribute("counter");
			int counter = Integer.parseInt(strNo);
			Object obj = session.getAttribute("on_Line");
			// 如果session上面沒有on_Line這個Attribute，才去做counter++，這樣就不會每重整網頁都造成counter++
			if (obj == null) {
				counter++;
				strNo = String.valueOf(counter);
				application.setAttribute("counter", strNo);
				session.setAttribute("on_Line", "true");
			}
		%>
		<h3>您是第<%= counter %>位貴客!</h3>
	</body>
</html>