package dispatchRequest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class OtherServlet
 * 
 * 被SomeServlet include的Servlet
 * 
 * @author coreyou
 */
@WebServlet(name="OtherServlet", urlPatterns={"/otherServlet.view"})
public class OtherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OtherServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String data = request.getParameter("data");
		String dataAttribute = (String) request.getAttribute("dataAttribute");
		PrintWriter out = response.getWriter();
        out.println("Other do one... data: " + data + ", dataAttribute: " + dataAttribute + "<br />");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Other Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>Dispatch Forward</h1>");
		// 使用request.getAttribute("new")抓出在SomeServlet.java中request.setAttribute("new", "test");所設定的"test"。
		out.println("<input type='text' name='name' value='" + request.getAttribute("new") + "' />");
		out.println("</form>");
		out.println("</body>");
		out.println("</html>");
		out.flush();		
		out.close();
	}

}
