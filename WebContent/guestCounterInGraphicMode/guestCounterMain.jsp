<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 請開啟本檔測試 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="CACHE-CONTROL" content="NO-CACHE"><!-- 防止網頁被快取起來，讓使用者每次都到伺服器抓網頁 -->
		<title>圖形模式訪客計數器主網頁</title>
		<script type="text/javascript">
			function windowOnUnLoad() {	// 使用者離開網頁時，要去logOut.jsp將在線人數減一
				window.location.href = "logOut.jsp";
			}
		</script>
	</head>
	<frameset rows="98%, *" border=0 frameborder=0 onunload="windowOnUnLoad()">
		<frame src="guestCounter.jsp" name="fTop">
		<frame name="fBottom" scrolling="no" noresize>
	</frameset>
	<body>	
	</body>
</html>