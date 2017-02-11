package filter;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

/**
 * 使用XSLT樣式檔案將XML轉換成其他格式，
 * 瀏覽器請求XML格式，回傳HTML檔案，
 * 本例使用MSN的xsl檔案主換MSN聊天紀錄。
 * 
 * 和MessageLog.xsl、/msn/demo.xml有關
 * 
 * @author coreyou
 *
 */
public class XSLTFilter implements Filter {

	private ServletContext servletContext;

	public void init(FilterConfig config) throws ServletException {
		servletContext = config.getServletContext();
	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;

		// 格式樣本檔案：/book.xsl
		Source styleSource = new StreamSource(servletContext
				.getRealPath("/MessageLog.xsl"));

		// 請求的 xml 檔案
		Source xmlSource = new StreamSource(servletContext.getRealPath(request
				.getRequestURI().replace(request.getContextPath() + "", "")));
		try {

			// 轉換器工廠
			TransformerFactory transformerFactory = TransformerFactory
					.newInstance();

			// 轉換器
			Transformer transformer = transformerFactory
					.newTransformer(styleSource);

			// 將轉換的結果儲存到該對像中
			CharArrayWriter charArrayWriter = new CharArrayWriter();
			StreamResult result = new StreamResult(charArrayWriter);

			// 轉換
			transformer.transform(xmlSource, result);

			// 輸出轉換後的結果
			response.setContentType("text/html");
			response.setContentLength(charArrayWriter.toString().length());
			PrintWriter out = response.getWriter();
			out.write(charArrayWriter.toString());

		} catch (Exception ex) {
		}
	}

	public void destroy() {
	}
}