<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
   	<%--
   		前導標記Directive Tag分為三種: page、include、taglib。
   		
   		page directive(row 1~26): 
   		1. contentType 的 charset: 告知瀏覽器顯示畫面所要使用的編碼。
   		2. pageEncoding: 表示這一頁jsp的內容的編碼，用來判斷以何編碼來編譯。
   		
   		以上兩個差異在於，當jsp頁面被呼叫以後，會 1.先被編譯成為java檔案然後  2.編譯成class最後 3.由Tomcat輸出到瀏覽器。
   		pageEncoding 會在 1 裡面被用來判斷此jsp編碼然後編譯成java；contentType 的 charset 則是在3 tomcat告知瀏覽器此頁面的編碼。
   		page directive可以用action elemnets中的&lt;jsp:directive.page /&gt; 取代
   	--%>
<%@ page import="java.util.Date" %>
	<%--
		3. import: 和普通Servlet一樣，要使用別的package方法都需要import進來。
	 --%>
<%@ page trimDirectiveWhitespaces="true" %>
	<%--
		4. trimDirectiveWhitespaces: 
		去掉頁面使用Elements造成的空白。 對於html來說，有空白沒有差，但是如果今天返回是xml，有一些開頭是空白會出錯。
		因此我們可以使用「trimDirectiveWhitespaces」設定為「true」就可以避免這個問題
	 --%>
<%@ page isErrorPage="true" errorPage="HelloWorldJSP.jsp" %>
	<%--
		假設今天我們的jsp頁面出錯了（發生了exception），我們可以設定:
		5. isErrorPage: 確定此jsp頁面是否作為顯示exception的頁面。
		6. errorPage: 這個是指定如果頁面出錯了以後，要轉去那一頁。
	 --%>
<%@ include file="helloWorldJSP.jsp" %>
<jsp:include page="helloWorldJSP.jsp"></jsp:include>
	<%--
		在不同頁面用一樣的內容: 在jsp裡面有兩種可以把頁面加進來的方式，一個是這邊介紹的include directive，會在編譯時期加入頁面，所以加入的頁面和目前頁面不能有相同的變數，會出錯；
		另一個是jsp:include，會在執行時期加入頁面，和目前頁面是分開編譯的，這種方式是action element，而非directive element。
	 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Directive Elements</title>
</head>
<body>

</body>
</html>