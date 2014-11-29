package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
/**
 * 在doFilter中加入一個try catch，就可以捕捉Servlet中拋出的可預期與不可預期之例外，並做對應的處理。
 * 如果想要測試要在web.xml加上<filter>和<filter-mapping>
 * 
 * @author coreyou
 *
 */
public class ExceptionHandlerFilter implements Filter {

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		try {
			chain.doFilter(request, response);
		} catch (Exception e) {	// 有例外則捕捉
			Throwable rootCause = e;	// 根例外
			while (rootCause.getCause() != null) {	// 直到尋找到根例外為止
				rootCause = rootCause.getCause();
			}
			String message = rootCause.getMessage();	// 例外原因
			message = message == null ? "例外:" + rootCause.getClass().getName() : message;
			
			// request中傳遞例外原因			
			request.setAttribute("message", message);
			// request中傳遞例外
			request.setAttribute("e", e);
			
			/*
			if (rootCause instanceof AccountException) {	// 如果是AccountException
				request.getRequestDispatcher("/accountException.jsp").forward(request, response);	// 則轉到/accountException.jsp顯示登錄輸入框
			} else if (rootCause instanceof BusinessException) {
				request.getRequestDispatcher("/businessException.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("/exception.jsp").forward(request, response);
			}
			*/
		}
		
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
