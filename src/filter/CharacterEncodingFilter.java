package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
/**
 * 字元編碼Filter，
 * 如果想要測試要在web.xml加上<filter>、<filter-mapping>、<init-param><param-name>characterEncoding和isEncodingEnabled
 * 
 * @author coreyou
 *
 */
public class CharacterEncodingFilter implements Filter {
	
	private String characterEncoding;	// 編碼方式，設定在web.xml中
	private boolean isEncodingEnabled;	// 是否啟用該Filter，設定在web.xml中

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub
		// 從web.xml抓設定，再設定到全域變數
		characterEncoding = config.getInitParameter("characterEncoding");
		isEncodingEnabled = "true".equalsIgnoreCase(config.getInitParameter("enabled").trim());
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		if (isEncodingEnabled || characterEncoding != null) {
			request.setCharacterEncoding(characterEncoding);
			response.setCharacterEncoding(characterEncoding);
		}
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		characterEncoding = null;
	}
	
}
