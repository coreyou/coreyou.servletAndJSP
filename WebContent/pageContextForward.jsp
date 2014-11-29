<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>PageConext Forward()/Include()</title>
	</head>
	<body>
		<h1>1st JSP(caller)</h1>
		<%
			session.setAttribute("author", "coreyou");
			out.println("session ID: " + session.getId() + "<br />");
			out.println("session variable(author): " + session.getAttribute("author") + "<br />");
			/*
			 *	使用forward()
			 */
			pageContext.forward("pageContextForwarded.jsp");	// 這行以下的程式碼都不會執行到，因為控制權已經在forward過去的那方了
			out.println("After Forward");
			/*
			 *	使用include()
			 */
			//pageContext.include("pageContextForwarded.jsp");	// 使用include()，控制權會回來，所以這行以下的程式碼還是會執行
			//out.println("<hr />After Include<br />");			
			//out.println("session ID: " + session.getId() + "<br />");
			//out.println("session variable(author): " + session.getAttribute("author") + "<br />");
		%>
	</body>
</html>