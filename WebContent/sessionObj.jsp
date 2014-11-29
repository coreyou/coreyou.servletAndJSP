<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Session Object</title>
	</head>
	<body>
		<%
			session.setAttribute("counter", "301");
			session.setAttribute("dbUrl", "jsp2.mdb");
			session.setAttribute("author", "coreyou");
			
			Enumeration enuAttr = session.getAttributeNames();
			String strName;
			int i = 1;
			while (enuAttr.hasMoreElements()) {
				strName = (String)enuAttr.nextElement();
				out.println("session屬性 " + i + " (" + strName + ") -> " + session.getAttribute(strName) + "<br />");
				i++;
			}
			
			out.println("session id: " + session.getId() + "<br />");
			out.println("session預設的有效時間: " + session.getMaxInactiveInterval() + "秒<br />");	// 如果超過此時間沒有像伺服器request，session就會失效
			session.setMaxInactiveInterval(60*5);	// 有效時間改為五分鐘
			out.println("session變更後的有效時間: " + session.getMaxInactiveInterval() + "秒<br />");
			out.println("是否為新建的session: " + session.isNew() + "<br />");
			long lngSec = session.getLastAccessedTime();	// 最後更新之秒數
			Date date = new Date(lngSec);
			out.println("session上次被存取的時間: " + date + "<hr />");
		%>
	</body>
</html>