<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>cacheTest</title>
<style type="text/css">
body {
	font-size: 12px; 
}
div {
	float: left;
	margin-left: 20px; 
}
a {
	color: #0000FF;
}
</style>
</head>
<body>

<div id="loginDiv">
	<a href="cacheTest.jsp" onclick="setCookie('username', 'Helloween');">登錄</a>
	<a href="cacheTest.jsp" onclick="setCookie('username', 'Admin'); setCookie('role', 'admin');">登錄為管理員</a>
</div>

<div id="adminDiv" style="display: none;">
	<a href="cacheTest.jsp">會員管理</a>
	<a href="cacheTest.jsp">公告管理</a>
</div>

<div id="controlDiv" style="display: none;">
	<a href="cacheTest.jsp">個人設定</a> 
	<a href="cacheTest.jsp">修改密碼</a>
	<a href="cacheTest.jsp" onclick="setCookie('username','');setCookie('role','');">離開</a>
</div>

<script type="text/javascript">
function setCookie(name, value){
	document.cookie = name + '=' + value;
}

function getCookie(name) 
{ 
	var search = name + "=" 
	if(document.cookie.length > 0) 
	{ 
		offset = document.cookie.indexOf(search) 
		if(offset != -1) 
		{ 
			offset += search.length 
			end = document.cookie.indexOf(";", offset) 
			if(end == -1) end = document.cookie.length 
			return unescape(document.cookie.substring(offset, end)) 
		} 
		else return "" 
	}
}
if(getCookie('username')){
	// 已經登錄，隱藏登錄選單
	document.getElementById('loginDiv').innerText = '歡迎, ' + getCookie('username');
	// 顯示登錄後的最後動作
	document.getElementById('controlDiv').style.display = 'block';
}
if(getCookie('role') == 'admin'){
	// 顯示管理員的動作
	document.getElementById('adminDiv').style.display = 'block';
}
</script>

</body>
</html>