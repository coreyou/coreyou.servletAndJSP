

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LifeCycleServlet
 * 
 * ==| 2. Servlet Life Cycle Servlet的生命週期 |==
 * (1) Container 也就是Tomcat載入 Servlet。
 * (2) Servlet呼叫 init() - 只會呼叫一次，因為每個Servlet都只會被載入一次，第二次以後呼叫同一個Servlet會用之前已經載入的。(@PostConstruct的方法會在(2)之前執行)
 * (3) Servlet載入完成，處於等待狀態。
 * (4) 當有Request進來的時候，service() 會被呼叫。service()會判斷進來的是什麼request method，然後傳給對應的method。
 * (5) 如果今天是一個get，那麼service()會傳給doGet()。
 * (6) doGet()完成以後，回到等待狀態。
 * (7) 當Container重啟服務（或結束服務），呼叫destroy() - 只會呼叫一次。(@PreDestroy的方法會在(7)之後執行，@PreDestroy的destroy指的是Servlet徹底移除，而非destroy())
 * 
 * 此例會在Console依序印出：init()、service()、doGet()、destroy()。
 * 
 * 在第二次以後呼叫同一個Servlet，會以多執行緒的方式執行，所以如果在Servlet中有全域變數的話，要小心同步的問題，
 * 比如在第一次執行Servlet的時候更改了此全域變數的值，但接著做了一個很耗時間的事，在這段期間內執行了第二次Servlet，也改了全域變數值，
 * 但是第二次執行卻沒有做這件很耗時間的事情，這導致全域變數值先被第二次執行改變了，最終結果導致第一次執行的結果錯誤，是個not Thread Safe的問題。
 * 在這裡，測試的全域變數為 globalName，測試方法為第一次在表單中輸入A，在doPost()中，檢查如果輸入為A的話，就讓Thread sleep 10秒，
 * 模擬做一件很耗時間的事情，然後在瀏覽器中再開啟一個相同的LieCycleServlet，這次在表單中輸入B，可以看到結果表單中顯示B，這時也差不多過了十秒，
 * 回去看第一個LieCycleServlet，會發現結果表單中顯示的是B，得知第一次LieCycleServlet的全域變數被第二次影響了。
 * 
 * 把LifeCycleServlet.java裡面所有註解起來的System.out.println都打開，
 * 然後在瀏覽器輸入http://localhost:8080/coreyou.servletAndJSP/LieCycleServlet測試。
 * 
 * @author coreyou
 */
@WebServlet(
		urlPatterns = { 
				"/LieCycleServlet"
		}, 
		initParams = { 
			@WebInitParam(name = "name", value = "LieCycleServlet")
		}, 
		loadOnStartup = 1
)
public class LifeCycleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String globalName; // 全域變數
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LifeCycleServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("init()");
		super.init();
	}



	@Override
	public void service(ServletRequest req, ServletResponse res)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("service()");
		super.service(req, res);
	}



	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("doGet()");
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String requestUri = request.getRequestURI();
		
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();
		
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Testing Life Cycle of Servlet in doGet()</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1> Testing Life Cycle of Servlet in doGet() </h1>");
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
		System.out.println("doPost()");
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		globalName = name;
		// 如果輸入A，就模擬要做一件很耗時間的事
		if ("A".equalsIgnoreCase(globalName)) {
			try {
				Thread.sleep(10000); //sleep for 10s
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		response.setContentType("text/html");
		String requestUri = request.getRequestURI();
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Testing Life Cycle of Servlet in doPost()</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1> Testing Life Cycle of Servlet in doPost() </h1>");
		out.println("<form action='" + requestUri + "' method='post'>");
		out.println("<input type='text' name='name' value='" + globalName + "' />");
		out.println("<input type='submit' value='submit' />");		
		out.println("</form>");
		
		// 取得全域參數(context-param)，定義在web.xml中，全域參數在所有servlet都可以取得，
		// 一般的init-param，只能在該servlet取得。
		// 這裡的效果是當input沒有輸入HelloServlet的時候會顯示message參數的value
		out.println(getServletContext().getInitParameter("message"));
		
		out.println("</body>");
		out.println("</html>");
		out.flush();
		out.close();
	}



	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		System.out.println("destroy()");
		super.destroy();
	}
	
	

}
