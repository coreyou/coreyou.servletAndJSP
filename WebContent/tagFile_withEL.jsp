<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %><%-- 定義tag前置詞 -->
<%-- 
	TAG檔案(一個普通的文字檔)的功能不再需要定義web.xml、標記程式庫描述子(例如:coreyouTagLib.tld)、標記處理器(例如:MaximumSimpleTag.java)，
	它讓我們可以單純使用JSP來建構標記程式庫，不需要像標記處理器去了解JAVA語言、也不需要編譯和部屬的動作。
	
	這裡演示了TAG配合EL的例子。
	
	本檔案連結到的標記檔在/WEB-INF/tags下: table.tag。
 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>搭配EL的TAG檔案</title>
	</head>
	<body>		
		<h2>搭配EL的TAG檔案</h2>
			<table border="0">
				<tr>
					<td>
						<tags:table color="#80ff80" bgcolor="#c0ffc0" title="table1" border="1">
							<p>Life is but a dream.</p>
						</tags:table>
					</td>
					<td>
						<tags:table color="#ff8080" bgcolor="#ffc0c0" title="table2" border="3">
							<p>If you can tell one why, he can make any hows.</p>
						</tags:table>
					</td>
				</tr>
				<tr>
					<td>
						<tags:table color="#8080ff" bgcolor="#c0c0ff" title="table3" border="5">
							<p>No news is good news.</p>
							<tags:table color="#ff80ff" bgcolor="#ffc0ff" title="tableInTable" border="1">
								<p>這是表中表</p>
							</tags:table>
							But good news is really better.
						</tags:table>
					</td>
					<td></td>
				</tr>
				<tr>
					<td>3rd</td>
					<td>3rd</td>
				</tr>
			</table>
			<hr />
	</body>
</html>