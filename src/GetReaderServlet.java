

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetReaderInputStream
 * 
 * 使用request.getReader();
 * 最後印出name、password或是上傳資料所POST的內容: user=caterpillar&passwd=123456&login=%E9%80%81%E5%87%BA%E6%9F%A5%E8%A9%A2
 * 
 * 開啟getReader.html測試。
 * 
 * @author coreyou
 */
@WebServlet(name = "GetReaderInputStream", urlPatterns = "/getReader.view")
public class GetReaderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetReaderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	private void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		BufferedReader reader = request.getReader();	
		String input = null;
		String requestBody = "";
		while((input = reader.readLine()) != null) {
			requestBody = requestBody + input + "<br />";
		}
		PrintWriter out  = response.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet getReader Demo</title>");
		out.println("</head>");
		out.println("<body>");
		out.println(requestBody);
		out.println("</body>");
		out.println("</heml>");
	}

}
