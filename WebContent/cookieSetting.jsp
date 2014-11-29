<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.net.URLEncoder"%>
<%!
	boolean isNull(String str){
		return str==null || str.trim().length()==0;
	}
%>
<%
	request.setCharacterEncoding("UTF-8");
	
	if("POST".equals(request.getMethod())){
		
		String name = request.getParameter("name");
		String value = request.getParameter("value");
		String maxAge = request.getParameter("maxAge");
		String domain = request.getParameter("domain");
		String path = request.getParameter("path");
		String comment = request.getParameter("comment");
		String secure = request.getParameter("secure");
		
		if(!isNull(name)){
		
			Cookie cookie = new Cookie(URLEncoder.encode(name, "UTF-8"), URLEncoder.encode(value, "UTF-8"));
			
			if(!isNull(maxAge))	cookie.setMaxAge(Integer.parseInt(maxAge));
			if(!isNull(domain))	cookie.setDomain(domain);
			if(!isNull(path))	cookie.setPath(path);
			if(!isNull(comment))	cookie.setComment(comment);
			if(!isNull(secure))	cookie.setSecure("true".equalsIgnoreCase(secure));
			
			response.addCookie(cookie);	// 覆蓋舊的cookie
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Cookie Setting</title>
	</head>
	<body>
		<div align="center" style="margin:10px; ">
			<fieldset>
				<legend>目前有效的cookie</legend>
				<script type="text/javascript">document.write(document.cookie);</script>
			</fieldset>
			<fieldset>
				<legend>設置新的cookie</legend>
				<form action="cookieSetting.jsp" method="POST">
					<table>
						<tr>
							<td>name: </td>
							<td><input name="name" type="text" style="width:200px; "></td>
							<td></td>
						</tr>
						<tr>
							<td>value: </td>
							<td><input name="value" type="text" style="width:200px; "></td>
							<td></td>
						</tr>
						<tr>
							<td>maxAge: </td>
							<td><input name="maxAge" type="text" style="width:200px; "></td>
							<td>(maxAge=0時代表刪除cookie, &lt;0時代表只在本瀏覽器視窗與子視窗有效, &gt;0時代表有效秒數)</td>
						</tr>
						<tr>
							<td>domain: </td>
							<td><input name="domain" type="text" style="width:200px; "></td>
							<td>cookie不可以跨越功能變數名稱(www.google.com發布的cookie不會被送到www.yahoo.com.tw去)。<br />不同級的功能變數名稱需要設定domain才可以使用相同的cookie(例如www.yahoo.com要使用image.yahoo.com的)。<br />domain參數必須以"."開始</td>
						</tr>
						<tr>
							<td>path: </td>
							<td><input name="path" type="text" style="width:200px; "></td>
							<td></td>
						</tr>
						<tr>
							<td>comment: </td>
							<td><input name="comment" type="text" style="width:200px; "></td>
							<td></td>
						</tr>
						<tr>
							<td>secure: </td>
							<td><input name="secure" type="text" style="width:200px; "></td>
							<td>如果設為true，瀏覽器只會在HTTPS和SSL等安全協定中傳輸。</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<input type="submit" value="送 出" class="button">
								<input type="button" value="重 整" onclick="location='cookieSetting.jsp'" class="button">
							</td>
							<td></td>
						</tr>
					</table>
				</form>
			</fieldset>
			<fieldset>
				<legend>注意</legend>
				<p>
					Cookie並不提供修改和刪除的功能，
					<span style="color:red; ">修改</span>的方法為新增一個同名的cookie並加到response中覆蓋原來的cookie，
					<span style="color:red; ">刪除</span>的方法為新增一個同名的cookie並將maxAge設為0後加到response中覆蓋原來的cookie。
				</p>
			</fieldset>
		</div>
	</body>
</html>