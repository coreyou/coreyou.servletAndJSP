<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%--
    	EL的基本結構為: ${ }
    	${ }不能放到<% %>之間，EL總共可以用來做兩件事情：
    	1. 方便用來取得collection裡面的內容。
    	2. 用來做運算和boolean判斷。
    	
    	EL的限制:
    	1. 沒有辦法在scriptlet裡面用EL。因此，如果需要在scriptlet取值做判斷，只能乖乖的用 java方式取得。
		2. 不能訪問普通方法。		
		3. 不能取得靜態屬性。
		所以EL只適合用來輸出內容? 但是，其實搭配JSTL，EL的威力就會展露無遺。
     --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Express Language Bean</title>
</head>
<body>
	<%--
		${}裡面的內容可以直接輸入你要取得的資料名稱，也可以直接使用java bean的ID來取得資料。
		如果我們直接輸入我們要找的key，EL會先去request裡面找有沒有對應的key，如果有顯示value。沒有的話就會去找session裡面有沒有對應的key。
		除了request、session以外，如果在key的前面加上資料的放置位置，可以從很多其他隱藏內容為物件取得資料。
	 --%>
	<p>You have entered</p>
	<div>
		<%-- 有兩個name，所以這裡取到的是一個[name值, name_2值]的String array --%>
		<p>name: ${ param.name }</p>
		<p>age: ${ param.age }</p>
		<%-- header: 取得標頭的內容 --%>
		<p>host: ${ header.host }</p>
		<%-- cookie: 取得cookie --%>
		<p>cookie: ${ cookie.cookie_name }</p>
		<p>cookie value: ${ cookie.cookie_name.value }</p>
		<p>cookie name: ${ cookie.cookie_name.name }</p>
		<%-- java bean的範圍有效性: page、request、session、application加上Scope可以當作前置詞 --%>
		<% 
			String str = new String("testing"); 
			pageContext.setAttribute("str", str);
		%>
		<p>pageScope(xxxScope): ${ pageScope.str }</p>
		<%-- 這個範圍非常廣，包含上面四個Scope的參數，但同時也包含了request，response等等。這裡是輸出使用者的ip --%>
		<p>pageContext.request.remoteAddr: ${ pageContext.request.remoteAddr }</p> 
		<%-- 運算與判斷 --%>
		<p>運算(2+5): ${ 2 + 5 }</p>
		<p>判斷("one" == param.name): ${ "one" == param.name}</p>
		<p>判斷(empty param.name): ${empty param.name}</p>
	</div>
</body>
</html>