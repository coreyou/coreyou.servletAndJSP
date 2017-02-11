package filter;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

/**
 * 和CacheFilter.java、cacheTest.jsp有關，開啟cacheTest.jsp測試
 * 
 * @author coreyou
 *
 */
public class CacheResponseWrapper extends HttpServletResponseWrapper {

	// 快取記憶體字符類輸出
	private CharArrayWriter cacheWriter = new CharArrayWriter();

	public CacheResponseWrapper(HttpServletResponse response)
			throws IOException {
		super(response);
	}

	@Override
	public PrintWriter getWriter() throws IOException {
		return new PrintWriter(cacheWriter);
	}

	@Override
	public void flushBuffer() throws IOException {
		cacheWriter.flush();
	}

	public void finishResponse() throws IOException {
		cacheWriter.close();
	}

	public CharArrayWriter getCacheWriter() {
		return cacheWriter;
	}

	public void setCacheWriter(CharArrayWriter cacheWriter) {
		this.cacheWriter = cacheWriter;
	}
}