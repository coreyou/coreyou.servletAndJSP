<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="coreyouTag" uri="http://tw.coreyouCorp.com/coreyouTagLib" %>
<%-- 
	TAG功能與web.xml、coreyouTagLib.tld、ChangeSizeTag.java有關。
	tag的目的是為了達到畫面呈現的邏輯。
	開啟本檔案測試。
 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>重複評估標記內容(改變字型大小) - ChangeSizeTag</title>
	</head>
	<body>
		<h2>重複評估標記內容(改變字型大小) - ChangeSizeTag</h2>
		<coreyouTag:changeSize num="5">
			<font size="${size}" color="blue" face="Times New Roman">Hello, world!</font><br />
		</coreyouTag:changeSize>		
	</body>
</html>