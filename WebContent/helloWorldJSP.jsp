<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <%!
    	// 宣告: 定義方法和全域變數
    	String getContent() {
    		return "Hello World!";
    	}
    %>
    
    <%
    	// 程式碼: java語法
    	String localVariable = getContent();
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hello World JSP</title>
</head>
<body>
	<h1>Hello World!</h1>
	<%
		// String para = new String(request.getParameter("name").getBytes("ISO-8859-1"), "Big5");
		String para = new String(request.getParameter("name"));
		out.println(para + ", 你好!");	// 取出表單內容
		out.println(request.getQueryString() + ", 你好!");	// 取出method="get"所附在網址列後面的欄位字串
		out.println(localVariable);
	%>
	<br />
	<%=
		// 運算式: 在這裡的物件會呼叫.toString()然後System.out到畫面上去，不需要使用分號，因為System.out本身就有分號，多分號反而有問題。
		localVariable
	%>
</body>
</html>