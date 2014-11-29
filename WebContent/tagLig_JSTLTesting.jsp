<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 	
	要使用JSTL(JSP Standard Tag Library)，必須先將以下兩個jar放到/WEB_INF/lib之下:
	1. javax.servlet.jsp.jstl-1.2.1.jar
	2. javax.servlet.jsp.jstl-api-1.2.1.jar
	
	從tagLib_JSTLTesting.html連動過來。
 --%>
<c:set var="title" value="標準標記 - 使用JSTL" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>${title}</title>
	</head>
	<body>
		<h2>${title}</h2>
		<p>
			您的性別是: 
			<c:choose>
				<c:when test="${param.sex == 'male'}" >男</c:when>
				<c:when test="${param.sex == 'female'}" >女</c:when>
				<c:otherwise >中性</c:otherwise>
			</c:choose>
		</p>
		<p>
			喜歡的運動:
			<c:forEach var="aValue" items="${paramValues['sport']}" >${aValue},</c:forEach>
		</p>
		<hr />
	</body>
</html>