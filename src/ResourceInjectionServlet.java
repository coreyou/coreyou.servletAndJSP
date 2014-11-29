

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ResourceInjectionServlet
 * 
 * web.xml裡面設定的資源自動注入，而不用Servlet主動去讀取資源。
 * 
 */
@WebServlet("/ResourceInjectionServlet")
public class ResourceInjectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResourceInjectionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    // 植入的 字串
 	private @Resource(name="strHello") String strHello;
 	// 植入的 整數
 	private @Resource(name="intI") int intI;
 	
 	// 植入更常見的寫法
 	@Resource(name="strAryPersons")
 	private String strAryPersons;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">");
		out.println("<html>");
		out.println("<head><title>資源植入</title></head>");
		out.println("	<body>");
		out.println("		<ul>");
		
		out.println("			<li><b>植入的字串</b>：</li>");
		out.println("				<ul><li>" + strHello + "</li></ul>");
		out.println("			<li><b>植入的整數</b>：</li>");
		out.println("				<ul><li>" + intI + "</li></ul>");
		out.println("			<li><b>植入的字串陣列</b>：</li>");
		out.println("				<ul>");
		for(String person : strAryPersons.split(",")){
			out.println("				<li>" + person + "</li>");
		}
		out.println("				</ul>");
		out.println("		</ul>");
		
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
