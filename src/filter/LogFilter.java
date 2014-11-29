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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
/**
 * 紀錄Log Filter，
 * 如果想要測試要在web.xml加上<filter>、<filter-mapping>，
 * 而且還要加log4j.properties這個設定檔。(可以參考coreyou.corp下面的log4j.properties)
 * 
 * org.apache.commons.logging這個lib常常找不到，感覺是tomcat不會自動去import WEB-INF下lib裡的commons-logging-1.2.jar，
 * 只好自己再手動import一次到Build Path。
 * 
 * @author coreyou
 *
 */
public class LogFilter implements Filter {

	private Log log = LogFactory.getLog(this.getClass());	// Log Object
	private String filterName;		// 目前Filter的名稱

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub
		filterName = config.getFilterName();
		log.info("啟動Filter: " + filterName);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		long startTime = System.currentTimeMillis();	// 執行前的時間
		String requestURI = req.getRequestURI();		// 存取的URI
		
		requestURI = req.getQueryString() == null ? requestURI : (requestURI + "?" + req.getQueryString());	// 所有的地址欄參數
		
		chain.doFilter(req, res);
		
		long endTime = System.currentTimeMillis();		// 執行後的時間
		log.info(req.getRemoteAddr() + " 存取了 " + requestURI + ", 總用時 " + (endTime - startTime) + " 毫秒。");
	}
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		log.info("關閉Filter: " + filterName);
	}
	
}
