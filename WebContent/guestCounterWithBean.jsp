<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 與/bean/guestCounter.java連動 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>訪客計數器BEAN版</title>
	</head>
	<body>
		<%-- 定義一個session範圍的計數器，記錄個人的存取資訊 --%>
		<jsp:useBean id="personalCount" class="bean.guestCounter" scope="session"></jsp:useBean>
		
		<%-- 定義一個application範圍的計數器，紀錄所有人的存取資訊(可以開啟不同的瀏覽器來模擬不同人) --%>
		<jsp:useBean id="allCount" class="bean.guestCounter" scope="application"></jsp:useBean>
		<div align="center">
			<form action="method.jsp" method="get">
				<fieldset>
					<legend>訪客計數器</legend>
					<table>
						<tr>
							<td>您的存取次數:</td>
							<td>
								<%-- 獲得個人的存取次數 --%>
								<jsp:getProperty name="personalCount" property="count"/> 次
							</td>
						</tr>
						<tr>
							<td>總共存取次數:</td>
							<td>
								<%-- 獲得所有人的存取次數 --%>
								<jsp:getProperty name="allCount" property="count"/> 次
							</td>
						</tr>
					</table>
				</fieldset>
			</form>
		</div>
	</body>
</html>