<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>文字檔搜尋引擎</title>
		<script type="text/javascript">
			<!--
				function dataCheck() {
					frmSearch.submit();
				}
			
				function focusTo(x) {
					document.forms[0].elements[x].focus();
				}
			 -->
		</script>
	</head>
	<body>
		<%
			String strSearch;
			if (request.getParameter("txtSearch") == null || request.getParameter("txtSearch") == "") {
				strSearch = "";
			} else {
				strSearch = new String(request.getParameter("txtSearch").getBytes("ISO-8859-1"));
			}
		%>
		<h2>文字檔搜尋引擎</h2>
		<form method="post" name="frmSearch">
			<p>
				查詢字串: <input type="text" size="16" name="txtSearch" value="<%= strSearch %>">
				&nbsp;&nbsp;
				<input type="button" value="查 詢" onclick="dataCheck()">				
			</p>
		</form>
		<hr />
		<%
			// 以下輸出查詢結果
			if (strSearch != "") {
				String rootDir = "/";	// Web應用程式的根目錄
				String fileTypes = ".jsp,.htm,.html,.txt,.shtml,.stm,";
				boolean fileFound = false;
				boolean contentFound = false;
				String fileName = "", filePath = "";
				
				String fullPath = application.getRealPath(rootDir);	// 例如C:\Users\coreyou\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\coreyou.servletAndJSP\
				File files = new File(fullPath);
				File fileList[] = files.listFiles();	// get all files and folders
				
				for (int i = 0; i < fileList.length; i++) {
					contentFound = false;
					if (fileList[i].isFile()) {
						fileName = fileList[i].getName().trim();	// 例如actionElementBean.jsp
						filePath = rootDir + fileName;	// 例如/actionElementBean.jsp						
						fullPath = application.getRealPath(filePath);	// 例如C:\Users\coreyou\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\coreyou.servletAndJSP\actionElementBean.jsp

						String fileType = fileName.substring(fileName.lastIndexOf("."));	// 例如.jsp
						if (fileTypes.indexOf(fileType) != -1) {	// 若符合fileTypes中設定的檔案類型
							try {
								// Open file one by one
								FileReader fr = new FileReader(fullPath);
								BufferedReader br = new BufferedReader(fr);
								String fileContent = br.readLine();
								while (fileContent != null) {
									if (fileContent.indexOf(strSearch) != -1) {	// 檔案中找到搜尋的字串
										contentFound = true;
										fileFound = true;
										out.println("<li><a href='/coreyou.servletAndJSP/" + filePath + "'>" + fileName + "</a><br />");
									}
									if (contentFound) {
										break;
									}
									fileContent = br.readLine();
								}
								br.close();
								fr.close();
							} catch (IOException ioe) {
								ioe.printStackTrace();
							}
						}
					}
				}
				if (!fileFound) {
					out.println("<p>無任何符合條件的文件</p>");
				}
			}
		%>
	</body>
</html>