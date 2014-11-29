

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UrlPatternPractice
 * 
 * requestURI = contextPath + servletPath + pathInfo，
 * contextPath是環境路徑（Context path），是容器用來決定該挑選哪個Web應用程式的依據（一個容器上可能部署多個Web應用程式）。
 * 一旦決定是哪個Web應用程式來處理請求，接下來就進行Servlet的挑選，Servlet必須設定URL模式（URL pattern）。
 * 
 * @author coreyou
 */
@WebServlet(name="UrlPatternPractice", urlPatterns="/UrlPatternPractice/*")
public class UrlPatternsPractice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UrlPatternsPractice() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		out.println("<html>");
        out.println("    <head>");
        out.println("        <title>Servlet ShowHeader</title>");
        out.println("    </head>");
        out.println("    <body>");
        out.println(        request.getRequestURI() + "<br>");	// requestURI = contextPath + servletPath + pathInfo
        out.println(        request.getContextPath() + "<br>");	
        out.println(        request.getServletPath() + "<br>");	// Servlet路徑直接對應至URL模式資訊
        out.println(        request.getPathInfo());	// 路徑資訊不包括請求參數，指的是不包括Context Path與Servlet Path部份的額外路徑資訊
        out.println("    </body>");
        out.println("</html>");
        out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
