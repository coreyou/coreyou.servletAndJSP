<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>註冊畫面</title>
		<script type="text/javascript">
		<!--
			function dataCheck() {
				if (reg.userId.value == "") {
					window.alert("「帳號」欄位不得為空白!");
					focusTo(0);
					return false;
				}
				
				var email = reg.email.value;
				if (email.indexOf("@", 0) < 0) {
					window.alert("Email當中須包含'@'字元!");
					focusTo(1);
					return false;
				}
				
				// 將資料傳給web server
				reg.submit();
			}
			
			function focusTo(x) {
				// 將游標定在表單的某個欄位
				document.forms[0].elements[x].focus();
			}
		-->
		</script>	
		<%
			// 去cookie取得user和email，如果有值的話，會將值代入form的欄位內
			String cookieName = "";
			String strUser = "";
			String strEmail = "";
			Cookie[] cookies = request.getCookies();	// user side的所有cookie是以陣列傳回，不同user的cookies也會是不同的
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					cookieName = cookies[i].getName();	// 取得Cookie名稱
					if ("uid".equals(cookieName)) {
						strUser = new String(cookies[i].getValue().getBytes("ISO-8859-1"));
						strUser = strUser.replace("\"", "");
					} else if ("email".equals(cookieName)) {
						strEmail = new String(cookies[i].getValue().getBytes("ISO-8859-1"));
						strEmail = strEmail.replace("\"", "");
					}
				}	
			}			
		%>	
	</head>
	<body>
		<h1>Coreyou Corp 線上書局</h1>
		<form action="shoppingRegisterCookie.jsp" method="post" name="reg">
			<p>
				姓名: <input name="userId" type="text" size="10" maxlength="10" cols="10" value="<%= strUser %>">
			</p>
			<p>
				email: <input name="email" type="text" size="40" maxlength="40" cols="40" value="<%= strEmail %>">
			</p>
			<hr />
			<input type="button" value="登 錄" onclick="dataCheck()">
			<input name="reset" type="reset" value="清 除">
		</form>
	</body>
</html>