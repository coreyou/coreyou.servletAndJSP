

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RequestServlet
 */
@WebServlet("/RequestServlet")
public class RequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RequestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private String getAccept(String accept){
		StringBuffer buffer = new StringBuffer();
		if(accept.contains("image/gif"))	buffer.append("GIF 檔案, ");
		if(accept.contains("image/x-xbitmap"))	buffer.append("BMP 檔案, ");
		if(accept.contains("image/jpeg"))	buffer.append("JPG 檔案, ");
		if(accept.contains("application/vnd.ms-excel"))	buffer.append("Excel 檔案, ");
		if(accept.contains("application/vnd.ms-powerpoint"))	buffer.append("PPT 檔案, ");
		if(accept.contains("application/msword"))	buffer.append("Word 檔案, ");
		return buffer.toString().replaceAll(", $", "");
	}
    
    private String getLocale(Locale locale) {	// 傳回用戶端的語言環境名稱
    	if (locale.equals(Locale.SIMPLIFIED_CHINESE)) return "簡體中文";
    	if (locale.equals(Locale.TRADITIONAL_CHINESE)) return "繁體中文";
    	if (locale.equals(Locale.ENGLISH)) return "英文";
    	if (locale.equals(Locale.JAPANESE)) return "日文";
    	return "未知語言環境";
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");	// 設定request編碼方式
		response.setCharacterEncoding("UTF-8");	// 設定response編碼方式
		
		response.setContentType("text/html");	// 設定文件類行為HTML類型
		String authType = request.getAuthType();
		String localAddr = request.getLocalAddr();	// 伺服器IP
		String localName = request.getLocalName();	// 伺服器名稱
		int localPort = request.getLocalPort();		// Tomcat port
		
		Locale locale = request.getLocale();			// 使用者的語言環境
		String contextPath = request.getContextPath();	// context路徑
		String method = request.getMethod();			// GET還是POST
		String pathInfo = request.getPathInfo();
		String pathTranslated = request.getPathTranslated();
		String protocol = request.getProtocol();			// 這裡是HTTP協定
		String queryString = request.getQueryString();		// 查詢字串，也就是?後面的字串
		String remoteAddr = request.getRemoteAddr();		// 用戶端IP
		int port = request.getRemotePort();					// 用戶端通訊埠
		String remoteUser = request.getRemoteUser();		// 遠端使用者
		String requestedSessionId = request.getRequestedSessionId();	// 用戶端session的ID
		String requestURI = request.getRequestURI();		// 使用者請求的URI
		StringBuffer requestURL = request.getRequestURL();	// 使用者請求的URL
		String scheme = request.getScheme();				// 協定頭，這裡是HTTP
		String serverName = request.getServerName();		// 伺服器名稱
		int serverPort = request.getServerPort();			// 伺服器通訊埠
		String servletPath = request.getServletPath();		// servlet的路徑
		Principal userPrincipal = request.getUserPrincipal();
		
		String accept = request.getHeader("accept");		// 瀏覽器支援的格式
		String referer = request.getHeader("referer");		// 從哪個頁面按下連結到了本頁
		String userAgent = request.getHeader("user-agent");	// User Agent資訊，包括作業系統類型及版本號、瀏覽器類型及版本號等
		
		String serverInfo = this.getServletContext().getServerInfo();
		
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">");
		out.println("<html>");
		out.println("<head><title>Request Servlet</title></head>");
		out.println("	<body>");
		out.println("<b>您的IP為: </b>" + remoteAddr + "，<b>使用: </b>" + userAgent + "，<b>使用: </b>" + getLocale(locale));
		out.println("<b>伺服器IP為</b> " + localAddr + "<b>；伺服器使用</b> " + serverPort + " <b>通訊埠，您的瀏覽器使用了</b> " + port + " <b>通訊埠存取本網頁。</b><br/>");
		out.println("<b>伺服器軟件為</b>：" + serverInfo + "。<b>伺服器名稱為</b> " + localName + "。<br/>");
		out.println("<b>您的瀏覽器接受</b> " + getAccept(accept) + "。<br/>");
		out.println("<b>您從</b> " + referer + " <b>存取到該頁面。</b><br/>");
		out.println("<b>使用的協定為</b> " + protocol + "。<b>URL協定頭</b> " + scheme + "，<b>伺服器名稱</b> " + serverName + "，<b>您存取的URI為</b> " + requestURI + "。<br/>" );
		out.println("<b>該 Servlet 路徑為</b> " + servletPath + "，<b>該 Servlet 類名為</b> " + this.getClass().getName() + "。<br/>");
		out.println("<b>本應用程式在硬碟的根目錄為</b> " + this.getServletContext().getRealPath("") + "，<b>網絡相對路徑為</b> " + contextPath + "。 <br/>");
		
		out.println("<br/>");
				
		out.println("<br/><br/><a href=" + requestURI + "> 點擊更新本頁面 </a>");
		out.println("	</body>");
		out.println("</html>");
		out.flush();
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
