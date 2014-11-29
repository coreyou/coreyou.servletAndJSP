<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" value="使用JSTL +EL存取表單欄位"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>${title}</title>
	</head>
	<body>
		<h2>${title}</h2>
		<p>Hello! <b>${param.user}</b>!</p>
		<table>
			<tr bgcolor="lightblue">
				<th scope="col"><b>表單欄位</b></th>
				<th scope="col"><b>內容</b></th>
			</tr>
			<!-- 使用forEach擷取欄位名稱和內容，paramValues是前一頁所post出來form資料的Map物件，可以取出request的對應key和value -->
			<!-- 
				可以操作的隱含物件有
				pageContext, pageScope, requestScope, sessionScope, applicationScope, 
				param, paramValues, header, headerValues, initParam, cookie，
				除了pageContext是pageContext物件，其餘的都是Map物件 
			-->
			<c:forEach var="aParam" items="${paramValues}">
				<tr>
					<td>${aParam.key}</td>
					<td>
						<c:forEach var="aValue" items="${aParam.value}">
							${aValue},
						</c:forEach>
					</td>
				</tr>
			</c:forEach>
		</table>
		<hr />
		<h2>使用JSTL + EL取得表頭資訊</h2>
		<p>瀏覽器類型: <b>${header["user-agent"]}</b></p><!-- 已知key為user-agent可以直接取值 -->
		<table>
			<tr bgcolor="lightblue">
				<th scope="col"><b>表頭變數</b></th>
				<th scope="col"><b>內容</b></th>
			</tr>
			<c:forEach var="aHeader" items="${headerValues}"><!-- 假設完全不清楚有多少標頭，可以利用forEach去跑隱含物件headerValues -->
				<tr>
					<td>${aHeader.key}</td>
					<td>
						<c:forEach var="aValue" items="${aHeader.value}">
							${aValue}
						</c:forEach>
					</td>
				</tr>
			</c:forEach>
		</table>
		<hr />
		<h2>使用JSTL + EL取得cookie資訊</h2>
		<% response.addCookie(new Cookie("userName", "handsome man")); %>
		<table>
			<tr bgcolor="lightblue">
				<th scope="col"><b>表頭變數</b></th>
				<th scope="col"><b>內容</b></th>
			</tr>
			<%-- <c:forEach var="aCookie" items="${cookie}"> --%><!-- 假設完全不清楚有多少標頭，可以利用forEach去跑隱含物件cookie -->
				<tr>
					<td>${cookie.userName.name}</td>
					<td>
						${cookie.userName.value}
					</td>
				</tr>
			<%-- </c:forEach> --%>
		</table>
		<hr />
	</body>
</html>