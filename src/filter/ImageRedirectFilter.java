package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * 防盜連Filter，防止外部網站盜連內部資源，這裡舉例圖片，
 * 如果想要測試要在web.xml加上<filter>和<filter-mapping>
 * 
 * @author coreyou
 *
 */
public class ImageRedirectFilter implements Filter {

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub

	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String referer = req.getHeader("referer");	// 連結來源位址
		
		if (referer == null || !referer.contains(request.getServerName())) {	// 若來自其他網站
			request.getRequestDispatcher("/images/errorstate.gif").forward(req, res);		// 顯示錯誤圖片
		} else {
			chain.doFilter(req, res);	// 圖片正常顯示
		}
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

}
