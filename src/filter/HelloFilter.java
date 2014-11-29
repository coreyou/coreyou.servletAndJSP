package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import java.io.*;

/**
 * Filter(過濾器)
 * 
 * Filter的功能:
 * 1. 需求的前置處理(preprocessing): 
 *    前端使用者發出request存取某Web資源，過濾器會對這項需求進行前置處理或規則判斷，再決定是否丟給下一個過濾器或是傳回要求的Web資源。
 * 2. 回應的後置處理(post-processing):
 *    如果有三個過濾器A、B、C進行入門檢查，那麼在將回應丟回前端之前，會依照相反順序C、B、A進行出門的後置處理。
 *    
 * Filter的使用時機:
 * 1. 認證(authentication)				2. 作為標記(tokenizing)
 * 3. 紀律與稽核(logging and auditing)	4. 觸發其他的資源存取事件
 * 5. 影像轉換(image conversion)			6. XSL/T轉換XML的內容
 * 7. 資料壓縮(data compression)			8. MIME型態鏈
 * 9. 加密(encryption)					10. 快取(caching)
 * 
 * Filter的生命週期和Servlet類似:
 * 1. 載入filter class(通常在/WEB-INF/classes下)。
 * 2. 建立filter instance，在web.xml裡面所定義的每個filter都只會建立唯一的filter實例，
 *    所以當有request進來時，都會交由這個唯一實例搭配多執行緒來執行。
 * 3. init(FilterConfig)，類似Servlet的init(ServletConfig)，
 *    初始化的時候會將web.xml裡面關於此過濾器的所有參數都藉由FilterConfig物件接進來，
 *    生命週期中的1到3步驟每個Filter元件只會執行一次
 * 4. doFilter()，類似Servlet的service()，當request的URL pattern對應到此過濾器時，Web container就會呼叫doFilter()，
 *    由於只會建立一個實例，所以當多個request同時到達時，會需要以多執行緒處理，需考慮執行緒安全，
 *    在doFilter()中必須決定是否要觸發filter chain的下一個元件(可能是另一個過濾器或其他WEB資源，例如Servlet、JSP、靜態文件)，或阻絕此次的需求。
 * 5. destroy()，釋放已開啟資源，以及其他清理作業。
 * 
 * 開啟HelloFilterTest.java測試。
 * 
 * @author coreyou
 *
 */

public class HelloFilter implements Filter {

	private FilterConfig config;
	private String counter = "";
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		config = null;
		counter = null;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>Hello Filter!</title></head>");
		out.println("<body>");
		out.println("<h2>第一個過濾器(filter)</h2>");
		out.println("<p>初始參數(counter)為: " + counter + "</p>");
		out.println("<hr />");
		out.println("</body>");
		out.println("</html>");		
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub		
		this.config = config;
		counter = config.getInitParameter("counter");
	}

}
