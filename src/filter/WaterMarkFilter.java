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
 * 在圖片上面加上圖片當作浮水印
 * 
 * 和WaterMarkOutputStream.java、WaterMarkResponseWrapper.java、ImageUtil.java有關
 * 可以開啟http://localhost:8080/coreyou.servletAndJSP/images/wallpaper-1019839.png測試
 * 
 * @author coreyou
 *
 */
public class WaterMarkFilter implements Filter {

	// 浮水印圖片，設定在初始化參數中
	private String waterMarkFile;

	public void init(FilterConfig config) throws ServletException {
		// 在web.xml中url-pattern設定為*.png，表示所有用url呼叫png檔案都會加入圖案浮水印
		// 而圖案浮水印設定為/images/errorstate.gif
		String file = config.getInitParameter("watermarkFile");
		waterMarkFile = config.getServletContext().getRealPath(file);
	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		// 自定義的response
		WaterMarkResponseWrapper waterMarkRes = new WaterMarkResponseWrapper(
				response, waterMarkFile);

		chain.doFilter(request, waterMarkRes);

		// 輸出浮水印到客戶端瀏覽器
		waterMarkRes.finishResponse();
	}

	public void destroy() {
	}

}