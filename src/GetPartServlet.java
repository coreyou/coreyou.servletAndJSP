

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class GetPartServlet
 * 
 * 處理上傳檔案(Servlet 3.0 supports 1.Part getPart(String name) and 2.Collection<Part> getParts())
 * 
 * 開啟getPart.html測試。
 * 
 * @author coreyou
 */
@MultipartConfig(location="c:/")
@WebServlet(name = "GetPartServlet", urlPatterns = "/getPart.view")
public class GetPartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");	// 處理中文檔名
		Part filePart1 = request.getPart("photo");	// <input type="file" name="photo">
		String header = filePart1.getHeader("Content-Disposition");
		String filename = header.substring(header.indexOf("filename=\"") + 10, header.lastIndexOf("\""));
		InputStream in = filePart1.getInputStream();
		OutputStream out = new FileOutputStream("c:/" + filename);
		byte[] buffer = new byte[1024];
		int length = -1;
		while((length = in.read(buffer)) != -1) {
			out.write(buffer, 0, length);
		}
		in.close();
		out.close();
	}

}
