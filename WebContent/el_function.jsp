<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="coreyouTag" uri="http://tw.coreyouCorp.com/coreyouTagLib" %>
<c:set var="x" value="Corey Ou" />
<c:set var="y" value="Corey" />
<c:set var="z" value="corey" />
<%-- 函數定義在coreyouTagLib.tld和/el/elFunction.java中 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>EL自訂函數</title>
	</head>
	<body>
		<h2>EL自訂函數</h2>
		<table>
			<tr bgcolor="lightblue">
				<th scope="col">EL運算式</th>
				<th scope="col">結果</th>
			</tr>
			<tr>
				<td>\${x}</td>
				<td>${x}</td>
			</tr>
			<tr>
				<td>\${y}</td>
				<td>${y}</td>
			</tr>
			<tr>
				<td>\${z}</td>
				<td>${z}</td>
			</tr>
			<tr>
				<td>\${coreyouTag:uCase(x)}</td>
				<td>${coreyouTag:uCase(x)}</td>
			</tr>
			<tr>
				<td>\${coreyouTag:lCase(x)}</td>
				<td>${coreyouTag:lCase(x)}</td>
			</tr>
			<tr>
				<td>\${coreyouTag:reverse(x)}</td>
				<td>${coreyouTag:reverse(x)}</td>
			</tr>
			<tr>
				<td>\${coreyouTag:contain(x, y)}</td>
				<td>${coreyouTag:contain(x, y)}</td>
			</tr>
			<tr>
				<td>\${coreyouTag:contain(x, z)}</td>
				<td>${coreyouTag:contain(x, z)}</td>
			</tr>
		</table>
	</body>
</html>