<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.text.*"%>
<!-- 開啟registerForm.jsp測試 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>註冊資料</title>
		<script type="text/javascript">
		<!--
			function dataCheck() {
				if (reg.textUserId.value == "") {
					window.alert("「帳號」欄位不得為空白!");
					focusTo(0);
					return false;
				}
				
				var email = reg.textEmail.value;
				if (email.indexOf("@", 0) < 0) {
					window.alert("Email當中須包含'@'字元!");
					focusTo(7);
					return false;
				}
				
				if (reg.textNickName.value == "") {
					window.alert("「暱稱」欄位不得為空白!");
					focusTo(1);
					return false;
				}
				
				if (reg.textUserName.value == "") {
					window.alert("「真實姓名」欄位不得為空白!");
					focusTo(4);
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
			String textUserId = "";		// 帳號欄位
			String textNickName = "";	// 暱稱欄位
			String textPassword = "";	// 密碼
			String textConfirmPassword = "";
			String textUserName = "";	// 真實姓名
			String radioGender = "";	// 性別
			String genderSelected = "";	// radio box select
			String textBirth = "";		// 生日
			String yearSelected = "";	// combo box select
			String monthSelected = "";	// combo box select
			String daySelected = "";	// combo box select
			int selectedYearInt = 0;
			int selectedMonthInt = 0;
			int selectedDayInt = 0;
			String textEmail = "";		// 電子郵件
			String textPhone = "";		// 電話號碼
			String textAddr = "";		// 地址
			String textIdLastFour = "";	// 身分證後四碼
			
			// 如果在session中已經有資料，就直接從session中取出
			Object obj = session.getAttribute("textUserId");
			if (obj != null) {
				textUserId = (String)obj;
				/* 
				 * 如果送出該 Form 網頁的 ContentType 為 utf-8，Tomcat 作成 request 物件時，
				 * 會將 utf-8 編碼的中文參數值先轉碼為ISO-8859-1，存入到 request 物件裡，
				 * 所以要取出request物件內的中文，就必須取出ISO-8859-1再轉回utf-8。
				 */
				textUserId = new String(textUserId.getBytes("ISO-8859-1"), "utf-8");	// 處理中文
			}
			obj = session.getAttribute("textNickName");
			if (obj != null) {
				textNickName = (String)obj;
				textNickName = new String(textNickName.getBytes("ISO-8859-1"), "utf-8");	// 處理中文
			}
			obj = session.getAttribute("textUserName");
			if (obj != null) {
				textUserName = (String)obj;
				textUserName = new String(textUserName.getBytes("ISO-8859-1"), "utf-8");	// 處理中文
			}
			obj = session.getAttribute("radioGender");
			if (obj != null) {
				radioGender = (String)obj;				
			}
			obj = session.getAttribute("textBirth");
			if (obj != null) {
				textBirth = (String)obj;
				String[] birth = textBirth.split("-");
				selectedYearInt = Integer.parseInt(birth[0]);
				selectedMonthInt = Integer.parseInt(birth[1]);
				selectedDayInt = Integer.parseInt(birth[2]);
			}
			obj = session.getAttribute("textEmail");
			if (obj != null) {
				textEmail = (String)obj;
				textEmail = new String(textEmail.getBytes("ISO-8859-1"), "utf-8");	// 處理中文
			}
			obj = session.getAttribute("textPhone");
			if (obj != null) {
				textPhone = (String)obj;
			}
			obj = session.getAttribute("textAddr");
			if (obj != null) {
				textAddr = (String)obj;
				textAddr = new String(textAddr.getBytes("ISO-8859-1"), "utf-8");	// 處理中文
			}
			obj = session.getAttribute("textIdLastFour");
			if (obj != null) {
				textIdLastFour = (String)obj;
			}
		%>
	</head>
	<body>
		<h2>會員註冊</h2>
		<p>填好以下表單並送出，稍後會收到認證email，內容含有一個網址，可以點擊該網址連回註冊頁面完成註冊。</p>
		<form action="register.jsp" method="post" name="reg">
			<ul>
				<li>帳號: <input name="textUserId" size="12" value="<%= textUserId %>">(12字以內的英文及數字，且第一個字須為英文字母，勿用身份證字號)</li>
				<li>暱稱: <input name="textNickName" size="18" value="<%= textNickName %>"></li>
				<li>密碼: <input type="password" name="textPassword" size="24" value="<%= textPassword %>"></li>
				<li>確認密碼: <input type="password" name="textConfirmPassword" size="24" value="<%= textConfirmPassword %>"></li>
				<li>真實姓名: <input name="textUserName" size="18" value="<%= textUserName %>">(英文最長18個字)</li>
				<li>
					性別:
					<%
						genderSelected = "";
						if (radioGender.equals("m")) {
							genderSelected = "checked='checked'";
						}
					%>
					<input type="radio" name="radioGender" size="20" value="m" <%= genderSelected %>>男
					<%
						genderSelected = "";
						if (radioGender.equals("f")) {
							genderSelected = "checked='checked'";
						}
					%>
					<input type="radio" name="radioGender" size="20" value="f" <%= genderSelected %>>女
				</li>
				<li>
					生日:
					<%
						Date date = new Date();
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
						String strDate = dateFormat.format(date);
						int thisYear = Integer.parseInt(strDate.substring(0, 4));
					%> 
					<select name="selectYear" >
						<option value=""></option>
						<%							
							yearSelected = "";
							for (int i = 1900; i <= thisYear; i++) {
								if (i == selectedYearInt) {
									yearSelected = "selected";
								} else {
									yearSelected = "";
								}
						%>
								<option value="<%= i %>" <%= yearSelected %>><%= i %></option>	
						<%
							}
						%>							
						
					</select>
					<select name="selectMonth">
						<option value=""></option>
						<%
							monthSelected = "";
							for (int i = 1; i <= 12; i++) {
								if (i == selectedMonthInt) {
									monthSelected = "selected";
								} else {
									monthSelected = "";
								}
						%>						
								<option value="<%= i %>" <%= monthSelected %>><%= i %></option>
						<%	
							}							
						%>
					</select>
					<select name="selectDay">
						<option value=""></option>
						<%
							daySelected = "";
							for (int i = 1; i <= 31; i++) {
								if (i == selectedDayInt) {
									daySelected = "selected";
								} else {
									daySelected = "";
								}
						%>
								<option value="<%= i %>" <%= daySelected %>><%= i %></option>	
						<%
							}							
						%>
					</select>
				</li>
				<li>e-mail: <input name="textEmail" size="45" value="<%= textEmail %>"></li>
				<li>電話號碼: <input name="textPhone" size="45" value="<%= textPhone %>"></li>
				<li>地址: <input name="textAddr" size="45" value="<%= textAddr %>"></li>
				<li>身份證末4碼: <input name="textIdLastFour" size="4" value="<%= textIdLastFour %>"></li>
			</ul>
			<p>
				<input type="button" value="登錄資料" onclick="dataCheck()">
				<input type="reset" value="清除欄位資料">
			</p>
		</form>
		<hr />
		<a href="registerCancel.jsp?m=<%= textEmail %>">取消註冊</a>
	</body>
</html>