

import java.io.DataInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetInputSreamServlet
 * 
 * 處理上傳檔案。
 * 開啟getInputStream.html測試。
 * 
 * @author coreyou
 */
@WebServlet(name = "GetInputSreamServlet", urlPatterns = "/getInputStream.view")
public class GetInputSreamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetInputSreamServlet() {
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
		String contentType = request.getContentType();	// multipart/form-data; boundary=---------------------------7de31025069e
		int formDataLength = request.getContentLength();
		
		// 讀取請求本體，存成byte datas[]
		DataInputStream dataStream = new DataInputStream(request.getInputStream());
		byte datas[] = new byte[formDataLength];
		int totalBytes = 0;
		while(totalBytes < formDataLength) {
			int bytes = dataStream.read(datas, totalBytes, formDataLength);
			totalBytes += bytes;
		}
		
		// 取得所有本體內容的字串表示，也就是將byte datas[]轉成字串
        String reqBody = new String(datas, "ISO-8859-1");
        // 取得上傳的檔案名稱
        String filename = reqBody.substring(reqBody.indexOf("filename=\"") + 10);	// wallpaper-1480324.png"\r\n
        filename = filename.substring(0, filename.indexOf("\n"));	// wallpaper-1480324.png"\r
        filename = filename.substring(filename.lastIndexOf("\\") + 1, filename.indexOf("\""));	// wallpaper-1480324.png
        
        // 取得檔案區段邊界資訊
        String boundary = contentType.substring(contentType.lastIndexOf("=") + 1, contentType.length());	// ---------------------------7de31025069e
        
        // 取得實際上傳檔案的起始與結束位置
        int pos;
        pos = reqBody.indexOf("filename=\"");
        pos = reqBody.indexOf("\n", pos) + 1;
        pos = reqBody.indexOf("\n", pos) + 1;
        pos = reqBody.indexOf("\n", pos) + 1;
        int boundaryLoc = reqBody.indexOf(boundary, pos) - 4;
        int startPos = ((reqBody.substring(0, pos)).getBytes("ISO-8859-1")).length;
        int endPos = ((reqBody.substring(0, boundaryLoc)).getBytes("ISO-8859-1")).length;
        
        // 輸出至檔案
        FileOutputStream fileOutputStream = new FileOutputStream("c:/" + filename);
        fileOutputStream.write(datas, startPos, (endPos - startPos));
        fileOutputStream.flush();
        fileOutputStream.close();
	}

}
