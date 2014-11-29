<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Request Get Server Information</title>
	</head>
	<body>
		<table>
			<tr>
				<th>環境變數</th>
				<th>內含值</th>
			</tr>
			<tr>
				<td>Auth Type</td>
				<td><%= request.getAuthType() %></td>
			</tr>
			<tr>
				<td>Content Length</td>
				<td><%= request.getContentLength() %></td>
			</tr>
			<tr>
				<td>Content Type</td>
				<td><%= request.getContentType() %></td>
			</tr>
			<tr>
				<td>Method</td>
				<td><%= request.getMethod() %></td>
			</tr>
			<tr>
				<td>Path Info</td>
				<td><%= request.getPathInfo() %></td>
			</tr>
			<tr>
				<td>Path Translated</td>
				<td><%= request.getPathTranslated() %></td>
			</tr>
			<tr>
				<td>Protocol</td>
				<td><%= request.getProtocol() %></td>
			</tr>
			<tr>
				<td>Query String</td>
				<td><%= request.getQueryString() %></td>
			</tr>
			<tr>
				<td>Remote Address</td>
				<td><%= request.getRemoteAddr() %></td>
			</tr>
			<tr>
				<td>Remote Host</td>
				<td><%= request.getRemoteHost() %></td>
			</tr>
			<tr>
				<td>Remote User</td>
				<td><%= request.getRemoteUser() %></td>
			</tr>
			<tr>
				<td>Remote URI</td>
				<td><%= request.getRequestURI() %></td>
			</tr>
			<tr>
				<td>Server Name</td>
				<td><%= request.getServerName() %></td>
			</tr>
			<tr>
				<td>Server Port</td>
				<td><%= request.getServerPort() %></td>
			</tr>
			<tr>
				<td>Servlet Path</td>
				<td><%= request.getServletPath() %></td>
			</tr>
		</table>
	</body>
</html>