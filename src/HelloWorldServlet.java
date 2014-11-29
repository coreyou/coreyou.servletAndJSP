

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloWorldServlet
 * 
 * ==| 1. Servlet Hello World |==
 * 
 * 一個Servlet基本上必須繼承javax.servlet.http.HttpServlet，如果你要處理的是GET請求，則重新定義doGet()方法。
 * 
 * 容器是怎麼知道要由哪個Servlet來處理請求？在這個例子中，是透過標注（Annotation）@WebServlet來告知容器，
 * name屬性：指定了Servlet的名稱，這裡設定為HelloServlet；
 * urlPatterns屬性：指定了客戶端請求的URL，這裡設定為/hello.view；
 * 所以如果輸入了http://localhost:8080/coreyou.servletAndJSP/helloworld.view，就會去找到HelloServlet名稱的Servlet來處理。
 * 
 * loadOnStartup屬性：
 * 預設值為-1，代表當你的應用程式啟動後，事實上並沒有載入所有的Servlet。
 * 容器會在你請求時，才將對應的Servlet類別載入、實例化、進行初始動作，然後再處理 你的請求。
 * 這意謂著第一次請求該Servlet的客戶端，必須等待Servlet類別載入、實例化、進行初始動作所必須花費的時間，才真正得到請求的處理。
 * 如果你希望應用程式啟動時，就先將Servlet類別載入、實例化並作好初始化動作，則將loadOnStartup設定大於0的值，
 * 表示在啟動應用程式後就要初始化Servlet（而不是實例化幾個Servlet）。
 * 數字代表了Servlet的初始順序，容器必須保證有較小數字的Servlet先初始化，如果有多個Servlet在設定loadOnStartup時使用了相同的數字，
 * 則容器實作廠商可以自行決定要如何載入哪個Servlet。
 * 
 * 如果使用WebContent/WEB-INF/web.xml來定義的話，會以web.xml為主，取代使用Annotation定義的值。
 * 
 * 最後將Tomcat v7.0 Server start以後，在瀏覽器輸入http://localhost:8080/coreyou.servletAndJSP/helloworld.view測試。
 * 
 * @author coreyou
 */
@WebServlet(
	urlPatterns = { 
		"/HelloWorldServlet", 
		"/hello.view"
	}, 
	initParams = { 
		@WebInitParam(name = "name", value = "HelloServlet")
	},
	loadOnStartup = 1
)
public class HelloWorldServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloWorldServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * javax.servlet.http.HttpServletRequest是GET請求的Java代表物件，有關於GET請求的資訊都是由它來取得，
	 * 當請求來到伺服器時，Web容器會建立HttpServletRequest實例來包裝請求中的相關訊息，
	 * 而javax.servlet.http.HttpServletResponse則是回應的Java代表物件。
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.log("執行doGet()...");
		
		String method = request.getMethod();	// 存取Servlet的方式，get或post
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String requestUri = request.getRequestURI();
		
		response.setContentType("text/html");
		// 透過resp.getWriter()取得PrintWriter，如果你要想對客戶端有任何純文字的回應，就使用它來進行輸出。
		PrintWriter out = response.getWriter();
		
		// 只是輸出一連串的HTML標籤至客戶端，實際上並不會在Servlet中作HTML輸出，
		// 但這邊只是第一個Servlet，這麼作只是為了簡化範例。
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Hello Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1> Hello World! </h1>");
		out.println("<p>以" + method + "方式存取頁面</p>");
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
		this.log("執行doPost()...");
		
		String method = request.getMethod();	// 存取Servlet的方式，get或post
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		// 指定請求參數名稱來取得對應元件的值，這裡指定name，getParameter()會對應到name的值並回傳字串
		String name = request.getParameter("name");	
		// getInitParameter("name");也可以替換為getServletConfig().getInitParameter("name");
		// 用來取得web.xml中定義的參數
		String secretName = getInitParameter("name");
		
		// 取得所有init參數的方法
//		Enumeration initParams = this.getInitParameterNames();
//		while(initParams.hasMoreElements()) {
//			String paramName = (String) initParams.nextElement();
//			String paramValue = getInitParameter(paramName);
//		}
		
		/* 
		 * 功能: 在input輸入"HelloServlet"就換頁到secret.html
		 * 換頁轉址有兩種作法: 1.透過RequestDispatcher().forward()  2.透過SendRedirect() 
		 */
		if (name.equalsIgnoreCase(secretName)) {
			/*
			 * 1.
			 * RequestDispatcher()，裡面輸入的參數就是要轉址的位置。如果是以"/"作為開頭，表示取得網站的root path，然後在加上path。
			 * 這裡的路徑會是http://localhost:8080/coreyou.servletAndJSP/WEB-INF/Secret.html，
			 * 但是因為它在WEB-INF下面，因此預設Tomcat是不會允許用http取得裡面的資料，不過只要我們透過forward()就可以取得資源，
			 * 所以最後轉址過後，瀏覽器的網址列不會改變，會維持顯示本頁，也就是http://localhost:8080/coreyou.servletAndJSP/HelloServlet， 
			 * 呼叫forward()之後，就放了一個return;。原因是，當呼叫了forward()以後，程式還是會繼續執行下去。
			 * 但已經說了要把內容輸出交給另外一個資源(/WEB-INF/secret.html)，如果你還在你這邊輸出內容，就會出錯。
			 * 因此，我需要呼叫forward()以後，跳出這個 method，避免輸出到內容造成出錯。
			 */
			request.getRequestDispatcher("/WEB-INF/secret.html").forward(request, response);
			return;
			/*
			 * 2.
			 * SendRedirect()，伺服器發送一個http status 301或者 302給browser告知內容的位置，由browser在去對那個網址發出request。
			 * (301: 永久性重新導向。 302: 臨時性重新導向)
			 * 因此，browser的連接會變換，轉變為http://localhost:8080/coreyou.servletAndJSP/WEB-INF/Secret.html，
			 * 同時 browser總共會有兩個request（一個取得301或302，然後再發出一個request到返回的地址）。
			 * 使用forward()的方法還有一個好處，那就是有些外部沒法直接取得的內容（例如在WEB-INF下面的資源是沒有辦法透過http request取得），不過用forward就可以取得資料。
			 */
//			response.sendRedirect("secret.html");	// 等於下面兩行的功能
			
//			response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);	// http status設為302
//			response.setHeader("Location", "http://localhost:8080/WEB-INF/secret.html");
			
//			response.setHeader("Refresh", "1000; URL=http://localhost:8080/WEB-INF/secret.html");	// 每一秒重新整理此頁面一次
			
		}
		response.setContentType("text/html");
		String requestUri = request.getRequestURI();
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Hello Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1> Hello World! </h1>");
		out.println("<p>以" + method + "方式存取頁面</p>");
		out.println("<form action='" + requestUri + "' method='post'>");
		out.println("<input type='text' name='name' />");
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

}
