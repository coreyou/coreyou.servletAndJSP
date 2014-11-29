<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
	response.reset();
	response.setContentType("image/jpeg");

	String JDBCDriver = "com.mysql.jdbc.Driver";
	Class.forName(JDBCDriver);
	Connection con = DriverManager.getConnection(
			"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
			"coreyou","751201267");
	Statement stmt = con.createStatement();
	String sql = "select imageByteCol from imageTest where imageId='" + request.getParameter("imageId") + "'";
	ResultSet rs = stmt.executeQuery(sql);
	byte[] imageByte = null;
	while(rs.next()) {
		imageByte = rs.getBytes(1);
	}
	
	if (rs != null) rs.close();
	if (stmt != null) stmt.close();
	if (con != null) con.close();
	
	ServletOutputStream sos = response.getOutputStream();
	sos.write(imageByte);
	sos.flush();
	if (sos != null) sos.close();
%>