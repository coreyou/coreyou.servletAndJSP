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
 * 網站常使用GZIP壓縮演算法對網頁內容進行壓縮，以減少資料傳輸量、提升回應速度，
 * 瀏覽器接收到壓縮資料以後會自動解壓並正確顯示。
 * 
 * 使用GZipResponseWrapper.java、GZipOutputStream.java，請開啟GZipTest.java測試。
 * 
 * @author coreyou
 *
 */
public class GZipFilter implements Filter {

	public void destroy() {
	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		String acceptEncoding = request.getHeader("Accept-Encoding");
		System.out.println("Accept-Encoding: " + acceptEncoding);

		if (acceptEncoding != null
				&& acceptEncoding.toLowerCase().indexOf("gzip") != -1) {

			// 如果客戶瀏覽器支援 GZIP 格式, 則使用 GZIP 壓縮資料
			GZipResponseWrapper gzipResponse = new GZipResponseWrapper(response);
			chain.doFilter(request, gzipResponse);

			// 輸出壓縮資料
			gzipResponse.finishResponse();

		} else {
			// 否則, 不壓縮
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig arg0) throws ServletException {
		
	}
}