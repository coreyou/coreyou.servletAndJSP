

import java.io.FileNotFoundException;
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
 * 處理批次上傳檔案。
 * MultipartConfig標籤是必備的，裡面不一定要有值，但是沒有此標籤會有錯誤，getPart會是null，導致nullPointerException。
 * 
 * 開啟getParts.html測試。
 * 
 * @author coreyou
 */
@MultipartConfig(location="c:/")
@WebServlet(name = "GetPartsServlet", urlPatterns = "/getParts.view")
public class GetPartsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPartsServlet() {
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
		for(Part part : request.getParts()) {
			if(! part.getName().equals("upload")) {
				write(part);
			}
		}
	}
	
	private void write(Part part) throws IOException, FileNotFoundException {
		String header = part.getHeader("Content-Disposition");
		String filename = header.substring(header.indexOf("filename=\"") + 10, header.lastIndexOf("\""));
//		write(filename, part.getInputStream());	// 這行的功能可以直接換成part內建的功能: part.write(filename);
		part.write(filename);
	}

	private void write(String filename, InputStream in) throws IOException, FileNotFoundException {
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
