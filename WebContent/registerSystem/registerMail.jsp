<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.security.Security, java.security.MessageDigest, java.util.*, javax.mail.*, javax.mail.internet.*, javax.activation.DataHandler, javax.activation.FileDataSource"%>
<!-- 開啟registerForm.jsp測試 -->
<%!
	String regsn = ""; 
	String[] RegSNContent = {	// 密碼會從此陣列的內容取出
		"0","1","2","3","4","5","6","7","8","9",
	    "A","B","C","D","E","F","G","H","I","J",
	    "K","L","M","N","O","P","Q","R","S","T",
	    "U","V","W","X","Y","Z","a","b","c","d",
	    "e","f","g","h","i","j","k","l","m","n","o",
	    "p","q","r","s","t","u","v","w","x","y","z"};  
	int pwlength = 42;     //密碼長度設定
	String getRegSN(){	// 產生的亂數將會安插在認證信中的連結內
		for(int i=0;i<pwlength;i++) {
			regsn += RegSNContent[(int)(Math.random()*RegSNContent.length)];
		}
		return regsn;
	}
	
	// 密碼必須先經過MD5加密才能存到資料庫中
	String md5(String str) {
		String md5=null;
	    try {
	    	MessageDigest md = MessageDigest.getInstance("MD5");
	    	byte[] barr = md.digest(str.getBytes());  //將 byte 陣列加密
	    	StringBuffer sb = new StringBuffer();  //將 byte 陣列轉成 16 進制
	    	for (int i = 0; i < barr.length; i++) {
	    		sb.append(byte2Hex(barr[i]));
	    	}
	    	String hex = sb.toString();
	    	md5 = hex.toUpperCase(); //一律轉成大寫
	    } catch(Exception e) {
	    	e.printStackTrace();
	    }
	    return md5;
	}
	String byte2Hex(byte b) {
	    String[] h = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"};
	    int i=b;
	    if (i < 0) {
	    	i += 256;
	    }
	    return h[i/16] + h[i%16];
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>完成使用者註冊</title>
		<%			
			String textUserId = "";		// 帳號欄位
			String textNickName = "";	// 暱稱欄位
			String textPassword = "";	// 密碼
			String textConfirmPassword = "";
			String textUserName = "";	// 真實姓名
			String radioGender = "";	// 性別
			String textBirth = "";		// 生日
			String textEmail = "";		// 電子郵件
			String textPhone = "";		// 電話號碼
			String textAddr = "";		// 地址
			String textIdLastFour = "";	// 身分證後四碼
			String activateCode = getRegSN();
			
			//request.setCharacterEncoding("utf-8");
			
			// 如果在session中已經有資料，就直接從session中取出
			Object obj = session.getAttribute("textUserId");
			if (obj != null) {
				textUserId = (String)obj;
				/* 
				 * 如果送出該 Form 網頁的 ContentType 為 utf-8，Tomcat 作成 request 物件時，
				 * 會將 utf-8 編碼的中文參數值先轉碼為ISO-8859-1，存入到 request 物件裡，
				 * 所以要取出request物件內的中文，就必須取出ISO-8859-1再轉回utf-8。
				 */
				textUserId = new String(textUserId.getBytes("ISO-8859-1"), "utf-8");	
			}
			obj = session.getAttribute("textNickName");
			if (obj != null) {
				textNickName = (String)obj;
				textNickName = new String(textNickName.getBytes("ISO-8859-1"), "utf-8");	// 處理中文
			}
			obj = session.getAttribute("textPassword");
			if (obj != null) {
				textPassword = (String)obj;
				textPassword = md5(textPassword);
			}
			obj = session.getAttribute("textUserName");
			if (obj != null) {
				textUserName = (String)obj;
				textUserName = new String(textUserName.getBytes("ISO-8859-1"), "utf-8");	// 處理中文
			}
			obj = session.getAttribute("radioGender");
			if (obj != null) {
				radioGender = (String)obj;
			}
			obj = session.getAttribute("textBirth");
			if (obj != null) {
				textBirth = (String)obj;
			}
			obj = session.getAttribute("textEmail");
			if (obj != null) {
				textEmail = (String)obj;
				textEmail = new String(textEmail.getBytes("ISO-8859-1"), "utf-8");	// 處理中文
			}
			obj = session.getAttribute("textPhone");
			if (obj != null) {
				textPhone = (String)obj;
			}
			obj = session.getAttribute("textAddr");
			if (obj != null) {
				textAddr = (String)obj;
				textAddr = new String(textAddr.getBytes("ISO-8859-1"), "utf-8");	// 處理中文
			}
			obj = session.getAttribute("textIdLastFour");
			if (obj != null) {
				textIdLastFour = (String)obj;
			}
		%>
		</head>
	<body>
	<jsp:useBean id="accessDbBean" class="bean.DBAccess"></jsp:useBean>
	<%
		// 寄出認證信，這裡利用gmail來寄信，要將gmail的安全設定改為較不安全，才能夠成功的將信寄出
		final String SMTP_AUTH_USER = "coreyou.taiwan";
		final String SMTP_AUTH_PWD = "284xl3-4";
		// final String SMTP_HOST_NAME = "smtp.mail.yahoo.com";
		final String SMTP_HOST_NAME = "smtp.gmail.com";
		final String MAIL_HOST_NAME = "@gmail.com";
		// Get a Properties object
		try {
			Properties props = System.getProperties();
			props.setProperty("mail.smtp.host", SMTP_HOST_NAME);
			props.setProperty("mail.transport.protocol", "smtp");
			// props.setProperty("mail.smtp.user", SMTP_AUTH_USER);
			// props.setProperty("mail.smtp.password", SMTP_AUTH_PWD);
			props.put("mail.smtp.starttls.enable", "true");	// gmail
			props.put("mail.smtp.auth", "true");
						
			// Session s = Session.getDefaultInstance(props, null);
			Session mailSession = Session.getInstance(props, 
					new Authenticator(){
						@Override
						public PasswordAuthentication getPasswordAuthentication(){
			    			return new PasswordAuthentication(SMTP_AUTH_USER, SMTP_AUTH_PWD);
			   			}
					}
			);
			
			// -- Create a new message --
			Message message = new MimeMessage(mailSession);
			 
			// -- Set the FROM and TO fields --
			message.setFrom(new InternetAddress(SMTP_AUTH_USER + MAIL_HOST_NAME));	// 發送者為coreyou.taiwan@gmail.com
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(textEmail));	// 收信位址為先前form中填的email
			message.setSubject("Corp Coreyou Activate Your Account");	// 信件主旨
			// 處理信件中html內容: 文字部分(textPart)、圖片部分(picturePart)
			// 文字部分(textPart)
			MimeBodyPart textPart = new MimeBodyPart();
			StringBuffer html = new StringBuffer();
			html.append("<h2>註冊信</h2>");
			html.append("這封信是由Corp Coreyou的會員註冊系統所寄出，請點選下面的網址來進行註冊的下一個步驟：");
			html.append("<p><a href='http://localhost:8080/coreyou.servletAndJSP/registerSystem/registerConfirm.jsp?m=" + 
				textEmail + "&c=" + activateCode + "'>" + "localhost:8080/registerConfirm.jsp?m=" + textEmail + "&c=" + activateCode + "</a></p>");
			html.append("<p>如果您不曾提出Corp Coreyou的註冊申請，請您直接刪除本信，抱歉造成您的困擾！</p>");
			html.append("<p>如果您無法連結信中網址，請聯絡我們！</p><hr />");
			html.append("<img src='cid:image'/><br>");
			textPart.setContent(html.toString(), "text/html; charset=UTF-8");
			// 圖片部分(picturePart)
			MimeBodyPart picturePart = new MimeBodyPart();
			FileDataSource fds = new FileDataSource(application.getRealPath("/") + "registerSystem/corp.jpg");
			picturePart.setDataHandler(new DataHandler(fds));
			picturePart.setFileName(fds.getName());
			picturePart.setHeader("Content-ID", "<image>");

			Multipart emailBody = new MimeMultipart();
			emailBody.addBodyPart(textPart);
			emailBody.addBodyPart(picturePart);
			message.setContent(emailBody);

			Transport transport = mailSession.getTransport("smtp");
			transport.connect(SMTP_HOST_NAME, SMTP_AUTH_USER, SMTP_AUTH_PWD);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
		} catch (Exception e) {
			out.println(e.toString());
		}
		
		// 將部分資料先寫入資料庫
		accessDbBean.setConnection("mysql", "coreyou", "751201267");
		Connection con = accessDbBean.getConnection();
		// insert
		String tableName = "user";
		String sql = "insert into " + tableName +  
			" values ('" + textUserId + "', '" + textNickName + "', '" + textPassword + "', '" + 
			textUserName + "', '" + radioGender + "', '" + textBirth + "', '" + textEmail + "', '" + 
			textPhone + "', '" + textAddr + "', '" + textIdLastFour + "', null, null,'" + activateCode + "')";	// createTime和activateTime沒放值
		System.out.println("sql: " + sql);
		int updateRows = accessDbBean.getUpdate(sql);
		if (updateRows > 0) {
			out.println("<p>sql= " + sql + "</p>");
			out.println("成功新增 <font color='red'>" + updateRows + "</font> 筆紀錄!<hr />");
		}
		
	%>
	</body>
</html>