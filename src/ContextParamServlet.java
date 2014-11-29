

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ContextParamServlet
 */
@WebServlet("/ContextParamServlet")
public class ContextParamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContextParamServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">");
		out.println("<html>");
		out.println("<head><title>讀取文件參數</title></head>");
		out.println("	<body>");
		out.println("		<fieldset style='width:90%'><legend>所有的文件參數</legend>");
		
		ServletContext servletContext = this.getServletConfig().getServletContext();	// 獲得上下文
		String uploadFolder = servletContext.getInitParameter("upload folder");			// 取得上下文參數內容
		String allowedFileType = servletContext.getInitParameter("allowed file type");

		out.println("			<label>上傳檔案夾: " + uploadFolder + "</label><br />");
		out.println("			<label>實際磁碟路徑: " + servletContext.getRealPath(uploadFolder) + "</label><br />");
		out.println("			<label>允許上傳的類型: " + allowedFileType + "</label><br />");
		out.println("		</fieldset>");
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
