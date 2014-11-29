<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%!
    	// 在JSP生命週期中，jspInit()會在_jspService()之前執行，而且每個JSP只會執行一次，我們在這裡設定counter Attribute的初始值
    	public void jspInit() {
    		ServletContext application = this.getServletContext();
    		application.setAttribute("counter", "0");
    	}
    
    	// 取出Attribute counter加一以後回存到Attribute，並回傳int型態的counter
    	int webCounter() {
    		ServletContext application = this.getServletContext();
    		String strNo = (String)application.getAttribute("counter");
    		int counter = Integer.parseInt(strNo);
    		counter++;
    		strNo = String.valueOf(counter);
    		application.setAttribute("counter", strNo);
    		return counter;
    	}    	
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>訪客計數器</title>
	</head>
	<body>
		<h1>第一版訪客計數器</h1>
		<p>您是第<%= webCounter() %>位貴客!</p>
	</body>
</html>