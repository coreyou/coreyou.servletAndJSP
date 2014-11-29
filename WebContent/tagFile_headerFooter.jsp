<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%-- 定義tag前置詞 -->
<%-- 
	TAG檔案(一個普通的文字檔)的功能不再需要定義web.xml、標記程式庫描述子(例如:coreyouTagLib.tld)、標記處理器(例如:MaximumSimpleTag.java)，
	它讓我們可以單純使用JSP來建構標記程式庫，不需要像標記處理器去了解JAVA語言、也不需要編譯和部屬的動作。
	
	本檔案連結到的標記檔在/WEB-INF/tags下: header.tag、footer.tag。
 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>使用Tag檔案來建構標記程式庫(Tag Library)</title>
	</head>
	<body>
		<tags:header></tags:header><!-- tag名稱與tag檔案名稱相同 -->
		<h2 align="center">使用Tag檔案來建構標記程式庫(Tag Library)</h2>
		<div align="center">
			<table>
				<tr>
					<td>1st</td>
					<td>1st</td>
				</tr>
				<tr>
					<td>2nd</td>
					<td>2nd</td>
				</tr>
				<tr>
					<td>3rd</td>
					<td>3rd</td>
				</tr>
			</table>
		</div>
		<tags:footer></tags:footer>
	</body>
</html>