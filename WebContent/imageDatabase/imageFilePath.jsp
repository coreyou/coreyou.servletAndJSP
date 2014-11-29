<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>圖片檔案夾</title>
		<script type="text/javascript">
		<!--
			function dataCheck() {
				if (formImg.imgName.value == "") {
					window.alert("圖檔名稱不得為空白!!");
					focusTo(0);
					return false;
				}
				formImg.submit();
			}
			
			function focusTo(x) {
				document.forms[0].elements[x].focus();
			}
			
			function checkKey() {
				if (window.event.keyCode == 13) {
					dataCheck();
					window.event.returnValue = false;
				}
			}
		-->
		</script>
	</head>
	<body>
		<%
			String fName;
			if (request.getParameter("imgName") == null || request.getParameter("imgName") == "") {
				fName = "";
			} else {
				fName = request.getParameter("imgName");
			}
		%>
		<h2>圖片檔案夾</h2>
		<form name="formImg" action="imageFilePath.jsp" method="post">
			<p>
				圖檔名稱: <input type="text" name="imgName" size="40" value="<%= fName %>" onKeyPress="checkKey()">
				<input type="button" value="秀 圖" onclick="dataCheck()">
			</p>
		</form>
		<hr />
		<%
			String fullPath = "";
			String relativePath = "";
			if (fName != "") {
				fName = "/images/" + fName;	// /images/xxx.jpg
				// 取得相對路徑
				relativePath = request.getContextPath() + fName;	// /coreyou.servletAndJSP/images/xxx.jpg
				// 取得檔案的實際路徑
				fullPath = application.getRealPath(fName);	// C:\Users\coreyou\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\coreyou.servletAndJSP\images\xxx.jpg
				try {
					File file = new File(fullPath);
					boolean isExist = file.exists();	// 判斷檔案是否存在
					if (isExist) {
						out.println("<img name='imgShown' src='" + relativePath + "'>");
						out.println("<hr />");
					} else {
						out.println("<p>無此檔案，請重新輸入!</p>");
					}
				} catch (Exception e) {
					out.println("Error: " + e.toString());
				}
			}
		%>
	</body>
</html>