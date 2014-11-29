package filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 此檔案只是為了測試是否會經過HelloFilter.java的過濾，
 * 隨便複製/dispatchRequest/SomeSerlet.java改名成此檔。
 * 
 * 測試結果會顯示HelloFilter.java所out.println的一些畫面，但由於沒有處理filter chain，
 * 所以會停留在HelloFilter的畫面。
 * 
 * 可以藉由filterDemo.jsp連結到此檔。
 * 
 * @author coreyou
 */
@WebServlet(name="HelloFilterTest", urlPatterns={"/helloFilterTest.view"})
public class HelloFilterTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloFilterTest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Hello Filter Test</title>");
		out.println("</head>");
		out.println("<body>");
		
		out.println("<h1>Dispatch Include</h1>");		
        out.println("Some do one...<br />");
        // other.view會循URL模式取得對應的Servlet
        RequestDispatcher dispatcher = request.getRequestDispatcher("otherServlet.view");
        /*
         * 使用setAttribute的屬性僅在此次請求週期內有效，稱之為請求範圍屬性。
         * 設定請求範圍屬性時，需注意屬性名稱由java.或javax.開頭的名稱通常保留給規格書中某些特定意義之屬性。例如：
         * javax.servlet.include.request_uri
         * javax.servlet.include.context_path
         * javax.servlet.include.servlet_path
         * javax.servlet.include.path_info
         * javax.servlet.include.query_string
         * 
         * 在使用include()時，在被include的Servlet中(本例指的是otherServlet.view)可以使用getSession()方法取得HttpSession物件，
         * 除了這個之外，在被include的Servlet中任何對請求標頭的設定都會被忽略。
         */        
        request.setAttribute("dataAttribute", "default");
        // 將另一個Servlet回應包括至目前的回應之中
        dispatcher.include(request, response);	                
        // 包括查詢字串，在other.view使用request.getParameter("data")來取得請求參數值
        request.getRequestDispatcher("otherServlet.view?data=123456").include(request, response);	
        out.println("Some do two...<br />");
    	        
		out.println("<h1>Dispatch Forward</h1>");
		String requestUri = request.getRequestURI();
		out.println("<form action='" + requestUri + "' method='post'>");
		out.println("<input type='text' name='name' />");
		out.println("<input type='submit' value='submit' />");
		out.println("</form>");
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
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		// 轉址、傳值
		String nameParameter = request.getParameter("name");	// 抓出<input type='text' name='name' />填入的值
		request.setAttribute("new", nameParameter);
		/*
		 * RequestDispatcher有個forward()方法，呼叫時同樣必須傳入請求與回應物件，
		 * 這表示你要將請求處理轉發給別的Servlet，回應亦轉發給另一個Servlet，
		 * 要呼叫forward()方法的話，目前的Servlet不能有任何回應確認（Commit），
		 * 如果在目前的Servlet的有透過回應物件設定了一些回應但未確認（回應緩衝區未滿或未呼叫任何出清方法）， 則所有回應設定會被忽略，
		 * 如果已經有回應確認且呼叫了forward()方法，則會丟出IllegalStateException。
		 * 
		 * 在被轉發請求的Servlet中，亦可透過以下的請求範圍屬性名稱取得對應資訊：
		 * javax.servlet.forward.request_uri
		 * javax.servlet.forward.context_path
		 * javax.servlet.forward.servlet_path
		 * javax.servlet.forward.path_info
		 * javax.servlet.forward.query_string
		 * 
		 * 以下會在OtherServlet.java的doPost()處理。
		 */
		request.getRequestDispatcher("otherServlet.view").forward(request, response);
	}

}
