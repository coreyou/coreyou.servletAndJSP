<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>
<%
	response.reset();
	response.setContentType("image/jpeg");

	String fileName = "/images/" + "wallpaper-1965667.jpg";
	String filePath = application.getRealPath(fileName);
	String JDBCDriver = "com.mysql.jdbc.Driver";
	Class.forName(JDBCDriver);
	Connection con = DriverManager.getConnection(
			"jdbc:mysql://localhost/coreyou_corp?useUnicode=true&characterEncoding=Big5",
			"coreyou","751201267");

	String sql = "insert into imageTest(imageId, imageByteCol) values(?, ?)";
	PreparedStatement pstmt = (PreparedStatement)con.prepareStatement(sql);
	InputStream inputImage = null;
	File file = new File(filePath);
	try {
		inputImage = new FileInputStream(file);
	} catch (FileNotFoundException e) {
		e.printStackTrace();
	}
	pstmt.setString(1, "7");
	pstmt.setBinaryStream(2, inputImage, (int)file.length());
		
	pstmt.executeUpdate();	// 一直有ERROR...
	con.commit();

	if (inputImage != null) inputImage.close();
	if (pstmt != null) pstmt.close();
	if (con != null) con.close();
	
%>