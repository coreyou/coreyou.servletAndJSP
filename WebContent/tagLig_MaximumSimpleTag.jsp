<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="coreyouTag" uri="http://tw.coreyouCorp.com/coreyouTagLib" %>
<%-- 
	TAG功能與web.xml、coreyouTagLib.tld、MaximumSimpleTag.java有關。
	開啟tagLib_demo.html測試。
 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:set var="x" value="${param.x}" />
<c:set var="y" value="${param.y}" />
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>呼叫自訂標記(取最大值) - MaximumSimpleTag</title>
	</head>
	<body>
		<h2>呼叫自訂標記(取最大值) - MaximumSimpleTag</h2>
		<p>傳入兩個整數: ${x}、${y}</p>
		<p>結果: 最大值是<coreyouTag:getSimpleMax x="${x}" y="${y}"/></p>
		<hr />
	</body>
</html>