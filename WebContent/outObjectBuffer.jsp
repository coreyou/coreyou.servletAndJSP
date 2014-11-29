<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Buffer of Out Object</title>
	</head>
	<body>
		<%
			out.println("row 1!<br />");
			out.clear();	// 上一行("row 1!<br />")就印不出來了
			out.println("row 2!<br />");
			out.println("row 3!<br />");
			out.flush();
			out.println("row 4!<br />");
			out.println("row 5!<br />");
			int intSize = out.getBufferSize();
			out.println("預設緩衝區大小: " + intSize + " bytes<br />");
			intSize = out.getRemaining();
			out.println("剩餘緩衝區大小: " + intSize + " bytes<br />");
			out.println("是否自動清空緩衝區: " + out.isAutoFlush() + "<hr />");
		%>
	</body>
</html>