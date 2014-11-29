<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>過濾器(Filter) - 認證功能</title>
	</head>
	<body>
		<jsp:include page="/WEB-INF/tags/header.tag"></jsp:include>
		<h2>過濾器(Filter)</h2>
		<table>
			<tr bgcolor="lightblue">
				<td><p><a href="/coreyou.servletAndJSP/helloFilterTest.view">Hello Filter</a></p></td>
				<td></td>
			</tr>
			<tr>
				<td>					
					<a href="/coreyou.servletAndJSP/authFilterTest.view">驗證過濾器(認證失敗)</a><!-- 開啟AuthFilterTest.java測試 -->
				</td>
				<td>
					<a href="/coreyou.servletAndJSP/authFilterTest.view?user=coreyou">驗證過濾器(認證成功)</a>
				</td>
			</tr>
		</table>
		<jsp:include page="/WEB-INF/tags/footer.tag"></jsp:include>
	</body>
</html>