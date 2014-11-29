<%
	int currentUsersCountInt = 0;
	String currentUsersCount = "0";
	Object objUsers = application.getAttribute("currentUsersCount");
	if (objUsers != null) {
		currentUsersCountInt = Integer.parseInt((String)objUsers);
		currentUsersCountInt--;	// 線上人數減一
		if (currentUsersCountInt <= 0) {
			currentUsersCountInt = 0;
		}
		currentUsersCount = String.valueOf(currentUsersCountInt);
	}
	application.setAttribute("currentUsersCount", currentUsersCount);
	session.invalidate();	// 強迫session失效
%>