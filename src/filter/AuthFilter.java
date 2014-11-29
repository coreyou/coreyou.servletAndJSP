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
 * 與AuthFilterTest.java、web.xml、filterDemo.jsp有關，
 * 開啟AuthFilterTest.java或filterDemo.jsp測試。
 * 
 * @author coreyou
 *
 */

public class AuthFilter implements Filter {

	private FilterConfig config;
	private String strUser;
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		config = null;
		strUser = null;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		String user = (request.getParameter("user") == null) ? null : request.getParameter("user");	// get form attribute
		
		if (user == null || user.length() < 3 || strUser.indexOf(user + ", ") == -1) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			String title = "Error!";
			out.println("<html>");
			out.println("<head><title>" + title + "</title></head>");
			out.println("<body>");
			out.println("<h2>" + title + "</h2>");
			out.println("<p>抱歉， " + user + "，您無權限進入!</p>");
			out.println("<hr />");
			out.println("</body>");
			out.println("</html>");
		} else {
			// 傳給過濾鏈的下一個物件
			chain.doFilter(request, response);			
		}
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub		
		this.config = config;
		strUser = config.getInitParameter("user");	// set in web.xml
	}

}
