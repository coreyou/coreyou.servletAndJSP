<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
     <%--
    	與Action.java、actionElements.jsp連動
     --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Action Element Bean</title>
</head>
<body>
	<%-- 
		定義一個JAVA BEAN對應到actionElement.Action這個POJO
		1. id: 在頁面裡面用來區分不同的java bean的數值。
		2. class: 這個定義此java bean到底是用哪一個POJO。注意到這邊是Fully Qualified Name。
		3. scope: 這個是定義此java bean的範圍有效性。總共有4個level，依次是page < request < session < application。
		page代表只存在這個頁面；request代表存在一次傳遞(從A頁到B頁)；session則是此使用者的這段時間；application則是此web container（例如Tomcat）啟動到結束的這段時間。
	 --%>
	<jsp:useBean id="action" class="bean.Action" scope="page"></jsp:useBean>
	<%--
		讓他自動幫我們把form的內容assign到我們的java bean
		1. name: 表示要assign哪一個java bean。
		2. property: 表示要assign java bean的哪一個variable。這邊的值就是我們variable的名字，而實際上他會呼叫setXXX。輸入*表示所有的欄位。
		3. value: 這個是要assign什麼值給此variable。如果沒有提供value，則是他會自動去request裡面找有沒有對應XXX的值，有就把它當做value。
	 --%>
	 <jsp:setProperty name="action" property="*" />
	 <%-- 
	 	也可以替代成以下兩種之一:
	 	<% action.setName(""); %>
	 	<jsp:setProperty name="action" property="name" param="parameterValue" />	// 這個是去讀form裡面的欄位
	  --%>
	 
	 <p>You have entered </p>
	 
	 <%--
	 	取出java bean的數值
	 	1. name: 表示哪一個java bean
	 	2. property: 呼叫哪一個getXXX
	 	可以用Scriptlet取代，例如: <%= action.getAge() %>
	  --%>
	  <div>
		  <p>name: <jsp:getProperty property="name" name="action"/></p>
		  <p>age: <jsp:getProperty property="age" name="action"/><%-- <%= action.getAge() %> --%></p>
	  </div>
	  
	  <%--
	  	Forward action element
	  	<jsp:forward page="forward.jsp">
	  	    <jsp:param name="param1" value="param value" />
	  	</jsp:forward>
	  	以上三行就像是使用Servlet以Request.Dispactcher()來forward頁面，JSP則是使用以上三行達到，
	  	基本上傳過去的參數可以透過request.getParameter()取得。
	   --%>
</body>
</html>