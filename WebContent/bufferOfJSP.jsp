<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>JSP Buffer</title>
	</head>
	<body>
		<%
			int intSize = response.getBufferSize();
			out.println("目前緩衝區的大小: " + intSize + " bytes");
			intSize = 16 * 1024;	// 16k Bytes
			out.println("設定緩衝區的大小為: " + intSize + " bytes");
			response.setBufferSize(intSize);
			intSize = response.getBufferSize();
			out.println("改變後的緩衝區大小: " + intSize + " bytes");
			out.println("呼叫flushBuffer()清空緩衝區...");
			response.flushBuffer();
			boolean bolCommit = response.isCommitted();
			out.println("是否清空緩衝區: " + bolCommit);
		%>
	</body>
</html>