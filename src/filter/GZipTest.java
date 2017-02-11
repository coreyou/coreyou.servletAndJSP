package filter;

import java.net.URL;
import java.net.URLConnection;
import java.text.NumberFormat;

/**
 * 和GZipFilter.java、GZipResponseWrapper.java、GZipOutputStream有關。
 * 
 * 測試一直不成功，tomcat一直出警告: 
 * [SetContextPropertiesRule]{Context} Setting property 'source' to 'org.eclipse.jst.jee.server:coreyou.servletAndJSP' did not find a matching property.
 * 
 * @author coreyou
 *
 */
public class GZipTest {

	public static void test(String url) throws Exception {

		/** 支援 GZIP 的連接 */
		URLConnection connGzip = new URL(url).openConnection();
		connGzip.setRequestProperty("Accept-Encoding", "gzip");
		int lengthGzip = connGzip.getContentLength();

		/** 不支援 GZIP 的連接 */
		URLConnection connCommon = new URL(url).openConnection();
		int lengthCommon = connCommon.getContentLength();

		double rate = new Double(lengthGzip) / lengthCommon;

		System.out.println("網址: " + url);
		System.out.println("壓縮後: " + lengthGzip + " byte, \t壓縮前: "
				+ lengthCommon + " byte, \t比率: "
				+ NumberFormat.getPercentInstance().format(rate));
		System.out.println();
	}

	public static void main(String[] args) throws Exception {
		test("http://localhost:8080/coreyou.servletAndJSP/absoluteAndRelativePath.jsp");
		test("http://localhost:8080/coreyou.servletAndJSP/tagLig_HelloMyTag.jsp");
	}
}
