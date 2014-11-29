<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>存取MySQL的圖形</title>
	</head>
	<body>
		<%
			String imageId;
			if (request.getParameter("imageId") == null || request.getParameter("imageId") == "") {
				imageId = "";
			} else {
				imageId = request.getParameter("imageId").trim();
			}
		%>
		<h2>存取MySQL的圖形</h2>
		<form name="formImg" method="post">
			<p>
				imageId: <input type="text" name="imageId" size="10" value="<%= imageId %>">
				<input type="submit" value="秀 圖">
			</p>
		</form>
		<hr />
			<img src="imageMysqlSelect.jsp?imageId=<%= imageId %>">
		<hr />
	</body>
</html>