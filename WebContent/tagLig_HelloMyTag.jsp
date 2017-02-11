<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="coreyouTag" uri="http://tw.coreyouCorp.com/coreyouTagLib" %>
<%-- 
	TAG功能與web.xml、coreyouTagLib.tld、HelloTag.java有關。
	tag的目的是為了達到畫面呈現的邏輯。
	開啟tagLib_demo.html測試。
 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>呼叫自訂標記 - HelloTag</title>
	</head>
	<body>
		<h2>呼叫自訂標記 - HelloTag</h2>
		<p>
			不帶參數:<br />
			結果: <coreyouTag:hello />
		</p>
		<hr />
		<p>
			傳進一個參數: ${param.name}<br />
			結果: <coreyouTag:hello name='<%= request.getParameter("name") %>' />
		</p>
		<hr />
	</body>
</html>