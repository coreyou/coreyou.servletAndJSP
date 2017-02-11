package filter;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.net.URLEncoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 快取記憶體filter，如果擷取的request為POST就不快取；
 * 如果是GET而且有快取記憶體、並且沒有過期，就直接回傳快取的結果， 避免讀取資料庫；
 * 如果沒有快取或是已經過期，就重新請求servlet；
 * 這裡使用檔案系統作為快起記憶體，一個URL對應一個快取檔案，快取檔案統一存放在Tomcat的工作目錄內
 * 
 * 和CacheResponseWrapper.java、cacheTest.jsp有關，開啟cacheTest.jsp測試
 * 
 * @author coreyou
 *
 */
public class CacheFilter implements Filter {

	private ServletContext servletContext;

	// 快取記憶體檔案夾，使用Tomcat工作目錄
	private File temporalDir;

	// 快取記憶體時間，設定在Filter初始化參數中
	private long cacheTime = Long.MAX_VALUE;
	private String encode;

	public void init(FilterConfig config) throws ServletException {
		temporalDir = (File) config.getServletContext().getAttribute(
				"javax.servlet.context.tempdir");
		servletContext = config.getServletContext();
		cacheTime = new Long(config.getInitParameter("cacheTime"));	// web.xml，也設定url-pattern是所有.jsp
		encode = config.getInitParameter("encode");
	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		request.setCharacterEncoding(encode);
		response.setCharacterEncoding(encode);

		// 如果為 POST, 則不經過快取記憶體
		if ("POST".equals(request.getMethod())) {
			chain.doFilter(request, response);
			return;
		}

		// 請求的 URI
		String uri = request.getRequestURI();
		if (uri == null)
			uri = "";
		uri = uri.replace(request.getContextPath() + "/", "");
		uri = uri.trim().length() == 0 ? "index.jsp" : uri;
		uri = request.getQueryString() == null ? uri : (uri + "?" + request
				.getQueryString());

		// 對應的快取記憶體檔案
		File cacheFile = new File(temporalDir, URLEncoder.encode(uri, "UTF-8"));
		System.out.println("CacheFilter: Cache File By CacheFilter.java: " + cacheFile);

		// 如果快取記憶體檔案不存在 或者已經超出快取記憶體時間 則請求 Servlet
		if (!cacheFile.exists()
				|| cacheFile.length() == 0
				|| cacheFile.lastModified() < System.currentTimeMillis()
						- cacheTime) {

			CacheResponseWrapper cacheResponse = new CacheResponseWrapper(
					response);

			chain.doFilter(request, cacheResponse);

			// 將內容寫入快取記憶體檔案
			char[] content = cacheResponse.getCacheWriter().toCharArray();

			temporalDir.mkdirs();
			cacheFile.createNewFile();

			Writer writer = new OutputStreamWriter(new FileOutputStream(
					cacheFile), "UTF-8");
			writer.write(content);
			writer.close();
		}

		// 請求的ContentType
		String mimeType = servletContext.getMimeType(request.getRequestURI());
		response.setContentType(mimeType);

		// 讀取快取記憶體檔案的內容，寫入客戶端瀏覽器
		Reader ins = new InputStreamReader(new FileInputStream(cacheFile),
				"UTF-8");
		StringBuffer buffer = new StringBuffer();
		char[] cbuf = new char[1024];
		int len;
		while ((len = ins.read(cbuf)) > -1) {
			buffer.append(cbuf, 0, len);
		}
		ins.close();
		// 輸出到客戶端
		response.getWriter().write(buffer.toString());
	}

	public void destroy() {
	}
}