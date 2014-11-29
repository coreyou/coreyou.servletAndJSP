<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Express Language(EL) - 以EL取得Java Bean屬性</title>
</head>
<body>
	<h2>以EL取得Java Bean屬性</h2>
	<p>&lt;jsp:useBean&gt;動作標記 + EL的應用</p>
	<jsp:useBean id="userBean" class="bean.simpleAccessUser"></jsp:useBean>
	<jsp:setProperty property="name" name="userBean" value="Sean"/>
	<jsp:setProperty property="dept" name="userBean" value="董事長室"/>
	<h3>測試Java Bean</h3>
	<p>
		員工姓名: <b>${userBean.name}</b>
		所屬部門: <b>${userBean.dept}</b>				
	</p>
	<hr />
</body>
</html>