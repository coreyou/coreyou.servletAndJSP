

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AbsoluteAndRelativePath
 */
@WebServlet("/AbsoluteAndRelativePath")
public class AbsoluteAndRelativePath extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AbsoluteAndRelativePath() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String requestUri = request.getRequestURI();
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>絕對路徑和相對路徑</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1> Hello World! </h1>");
		out.println("<p>Servlet中獲得當前應用的相對路徑和絕對路徑根目錄所對應的絕對路徑: " + request.getServletPath() + "</p>");
		out.println("<p>文件的絕對路徑: " + request.getSession().getServletContext().getRealPath(request.getRequestURI())  + "</p>");
		out.println("<p>當前web應用的絕對路徑: " + getServletContext().getRealPath("/") + "</p>");
		out.println("</body>");
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
