

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
@WebServlet("/PictureVerifyServlet")
public class PictureVerifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	/**
	 * 亂數池，不包括0、O、1、I等難辨認的字元
	 */
	public static final char[] CHARS = { '2', '3', '4', '5', '6', '7', '8',
		'9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M',
		'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };
	
	public static Random random = new Random();
	
	/**
	 * 獲得六位亂數
	 * @return
	 */
	public static String getRandomString() {
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < 6; i++) {
			buffer.append(CHARS[random.nextInt(CHARS.length)]);	// random.nextInt會產生[0 ~ CHARS.length-1]的亂數，可以替代成下面那行
			// buffer.append(CHARS[(int) (Math.random()*CHARS.length)]);	// Math.random()會產生0 ~ 1的double值(<1)
		}
		return buffer.toString();
	}
	
	/**
	 * 獲得隨機的顏色
	 * @return
	 */
	public static Color getRandomColor() {
		return new Color(random.nextInt(255), random.nextInt(255), random
				.nextInt(255));
	}
	
	/**
	 * 傳回某顏色的對比色
	 * @param c
	 * @return
	 */
	public static Color getReverseColor(Color c) {
		return new Color(255 - c.getRed(), 255 - c.getGreen(), 255 - c
				.getBlue());
	}
	
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
		
		// 產生亂數，放到session中
		String randomString = getRandomString();
		request.getSession(true).setAttribute("randomString", randomString);
		
		// 設定圖片寬高、顏色
		int width = 100;
		int height = 30;
		Color color = getRandomColor();
		Color reverse = getReverseColor(color);
		BufferedImage bi = new BufferedImage(width, height,	BufferedImage.TYPE_INT_RGB);	// 建立一個RGB圖片
		Graphics2D g = bi.createGraphics();													// 獲得繪圖物件
		g.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 16));	// 設定字體
		g.setColor(color);					// 設定顏色
		g.fillRect(0, 0, width, height);	// 繪製背景
		g.setColor(reverse);				// 設定顏色
		g.drawString(randomString, 18, 20);	// 繪製隨機字元
		for (int i = 0, n = random.nextInt(100); i < n; i++) {	// 繪製最多100個噪音點
			g.drawRect(random.nextInt(width), random.nextInt(height), 1, 1);	// 隨機噪音點
		}
		
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
