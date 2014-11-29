<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Config Object</title>
	</head>
	<body>
		<h2>config物件的使用</h2>
		<%
			String strName;
			int i = 1;
			// 抓出web.xml中的參數設定
			Enumeration enuPara = config.getInitParameterNames();
			while(enuPara.hasMoreElements()) {
				strName = (String)enuPara.nextElement();
				out.println("config起始參數 " + i + " (" + strName + "): " + config.getInitParameter(strName) + "<br />");
				i++;
			}
			out.println("<hr />Servlet的名稱: " + config.getServletName() + "<hr />");
		%>
	</body>
</html>