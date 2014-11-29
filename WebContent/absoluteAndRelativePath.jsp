<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>絕對和相對路徑</title>
	</head>
	<body>
		<%
			/* 
			 * 1. 基本規則
			 * "/"代表Web應用的根目錄。"./" 代表當前目錄。"../"代表上層目錄。
			 */
			/* 
			 * 2. server端的地址
			 * servlet中的request.getRequestDispatcher(address);這個address是在伺服器端解析的，所以根目錄就會是http://192.168.0.1:8080/
			 * 所以可以去看coreyou.servletAndJSPJava Resources/src/dispatchRequest/SomeServlet.java，
			 * 裡面有一行 RequestDispatcher dispatcher = request.getRequestDispatcher("/otherServlet.view");
			 * 這個otherServlet.view前面的"/"就是當前的web應用根目錄coreyou.servletAndJSP，
			 * 所以上面那行的絕對地址就是http://localhost:8080/coreyou.servletAndJSP/otherServlet.view。
			 */
			/*
			 * 3. client端的地址
			 * 所有的html頁面中的相對地址都是相對於server根目錄(http://192.168.0.1:8080/)的，而非server web應用根目錄(http://192.168.0.1:8080/coreyou.servletAndJSP/)，
			 * 例如helloWorldJSP.html中<form action="helloWorldJSP.jsp" method="get">，
			 * 提交給server的action的絕對地址就是http://192.168.0.1:8080/helloWorldJSP.html。
			 */
			/*
			 * 4. JSP中獲得當前應用的相對路徑和絕對路徑
			 */
			out.println("<p>JSP中獲得當前應用的相對路徑和絕對路徑根目錄所對應的絕對路徑: " + request.getRequestURI() + "</p>");	// /coreyou.servletAndJSP/absoluteAndRelativePath.jsp
			out.println("<p>文件的絕對路徑: " + application.getRealPath(request.getRequestURI()) + "</p>");	// C:\Users\coreyou\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\coreyou.servletAndJSP\coreyou.servletAndJSP\absoluteAndRelativePath.jsp
			out.println("<p>當前web應用的絕對路徑: " + application.getRealPath("/") + "</p>");	// C:\Users\coreyou\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\coreyou.servletAndJSP\
			out.println("<p>" + application.getRealPath(request.getRequestURI()) + "</p>");	// C:\Users\coreyou\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\coreyou.servletAndJSP\coreyou.servletAndJSP\absoluteAndRelativePath.jsp
			/*
			 * 5. Servlet中獲得當前應用的相對路徑和絕對路徑
			 * 去參考AbsoluteAndRelativePath.java
			 */
		%>
	</body>
</html>