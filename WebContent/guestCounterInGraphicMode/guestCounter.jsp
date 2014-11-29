<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*"%>
<!-- 請開啟guestCounterMain.jsp測試 -->
<%!
	String errMsg = "";
	// input: 紀錄累計訪客數的文字檔, output: 累計訪客數integer
	private int webCounter(String fullPath) {
		String hitRate = "1", tempNo = "";
		try {
			// 開啟計數檔
			FileReader fr = new FileReader(fullPath);
			BufferedReader br = new BufferedReader(fr);
			tempNo = br.readLine();
			while(tempNo != null) {
				hitRate = tempNo;
				tempNo = br.readLine();
			}
			br.close();
			fr.close();
		} catch (IOException ioe) {
			errMsg = "Error: " + ioe.toString();
		}
		return Integer.parseInt(hitRate);
	}
%>
<%
	String fName = "/guestCounterInGraphicMode/cnt/guestCounter.cnt";	// 最前面的"/"代表Web應用的根目錄。
	String fullPath = application.getRealPath(fName);
	String currentUsersCount = "1";	// 現在在線人數
	int intCurrentUsersCount;
	int counter = webCounter(fullPath);	// 開啟計數檔取得目前計數
	String hitRate = String.valueOf(counter);
	Object obj = session.getAttribute("onLine");	// 取得session上的flag
	// 如果該名使用者尚未登錄過網頁，或超出預設時間(30分鐘)，則增加累計人數、並處理現在在線人數
	if (obj == null) {
		counter++;
		hitRate = String.valueOf(counter);
		session.setAttribute("onLine", "true");	// 設定flag為登入過
		try {
			// 將結果寫入計數器
			FileWriter fw = new FileWriter(fullPath);
			fw.write(hitRate);
			fw.close();
		} catch (IOException ioe) {
			out.println("Error: " + ioe.toString());
		}
		// 處理現在在線人數
		Object objUser = application.getAttribute("currentUsersCount");
		if (objUser != null) {
			intCurrentUsersCount = Integer.parseInt((String)objUser);
			intCurrentUsersCount++;
			currentUsersCount = String.valueOf(intCurrentUsersCount);
		}
		application.setAttribute("currentUsersCount", currentUsersCount);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="Refresh" content="60,URL=guestCounter.jsp"><!-- 設定60秒自動更新一次 -->
		<meta http-equiv="CACHE-CONTROL" content="NO-CACHE"><!-- 防止網頁被快取起來，讓使用者每次都到伺服器抓網頁 -->
		<title>圖形模式訪客計數器</title>
	</head>
	<body>
		<p>
			線上人數: <b><%= application.getAttribute("currentUsersCount") %></b>
		</p>
		<p>
			累計訪客:
			<%
				char picName;
				for (int i = 0; i < hitRate.length(); i++) {
					picName = hitRate.charAt(i);
					out.println("<img src='images/" + picName + ".gif'>");
				}
			%>
		</p>
	</body>
</html>