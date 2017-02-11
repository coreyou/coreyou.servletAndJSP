package pictureVerification;


import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import com.sun.image.codec.jpeg.*;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PictureVerifyServlet
 * 
 * 請開啟pictureVerify.html測試
 */
@WebServlet("/pictureVerification/PictureVerifyServlet")
public class PictureVerifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PictureVerifyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("image/jpeg");	// 必須先設定輸出類型
		
		CheckCode cc = new CheckCode(200, 50, 6);
		BufferedImage bi = cc.getBuffImg();
		
		// 產生亂數，放到session中
		// String randomString = getRandomString(6);
		// request.getSession(true).setAttribute("randomString", randomString);
		String randomString = cc.getCheckCodeStr();
		request.getSession(true).setAttribute("randomString", randomString);
		
		// 轉成JPEG格式，對圖片進行編碼，輸出到用戶端
		ServletOutputStream out = response.getOutputStream();
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
		encoder.encode(bi);
		out.flush();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");	// 設定request編碼方式
		response.setCharacterEncoding("UTF-8");	// 設定response編碼方式
		
		response.setContentType("text/html");	// 設定文件類行為HTML類型
		
		String rightString = (String) request.getSession(true).getAttribute("randomString");
		String insertString = request.getParameter("insertCode");
		if (rightString.equalsIgnoreCase(insertString)) {
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">");
			out.println("<html>");
			out.println("<head><title>驗證結果</title></head>");
			out.println("	<body>");
			out.println("		<p>驗證碼正確!!</p>");
			out.println("	</body>");
			out.println("</html>");
			out.flush();
			out.close();
		} else {
			PrintWriter out = response.getWriter();
			out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">");
			out.println("<html>");
			out.println("<head><title>驗證結果</title></head>");
			out.println("	<body>");
			out.println("		<p>驗證失敗!!</p>");
			out.println("	</body>");
			out.println("</html>");
			out.flush();
			out.close();
		}
	}

}
