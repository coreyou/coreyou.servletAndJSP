package uploadFileStatus;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class ProgressUploadServlet
 * 
 * 請開啟progressUpload.jsp測試
 */
@WebServlet("/ProgressUploadServlet")
public class ProgressUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProgressUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * 
	 * 這裡用doGet做傳輸條
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		response.setHeader("Cache-Control", "no-store");	// 禁止瀏覽器快取記憶體
		response.setHeader("Pragrma", "no-cache");			// 禁止瀏覽器快取記憶體
		response.setDateHeader("Expires", 0);				// 禁止瀏覽器快取記憶體

		// 從session上讀取上傳資訊
		UploadStatus status = (UploadStatus) request.getSession(true).getAttribute("uploadStatus");

		if (status == null) {
			response.getWriter().println("沒有上傳資訊");
			return;
		}

		long startTime = status.getStartTime();
		long currentTime = System.currentTimeMillis();

		// 已傳輸的時間 單位：s
		long time = (currentTime - startTime) / 1000 + 1;

		// 傳輸速度 單位：byte/s
		double velocity = ((double) status.getBytesRead()) / (double) time;

		// 估計總時間 單位：s
		double totalTime = status.getContentLength() / velocity;

		// 估計剩餘時間 單位：s
		double timeLeft = totalTime - time;

		// 已完成的百分比
		int percent = (int) (100 * (double) status.getBytesRead() / (double) status
				.getContentLength());

		// 已完成數 單位：M
		double length = ((double) status.getBytesRead()) / 1024 / 1024;

		// 總長度 單位：M
		double totalLength = ((double) status.getContentLength()) / 1024 / 1024;

		// 格式：百分比||已完成數(M)||檔案總長度(M)||傳輸速率(K)||已用時間(s)||估計總時間(s)||估計剩餘時間(s)||正在上傳第幾個檔案
		String value = percent + "||" + length + "||" + totalLength + "||"
				+ velocity + "||" + time + "||" + totalTime + "||" + timeLeft
				+ "||" + status.getItems();

		response.getWriter().println(value);	// 輸出給瀏覽器的進度條
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * 
	 * 這裡用doPost做上傳
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		UploadStatus status = new UploadStatus();	// 上傳狀態
		UploadListener listener = new UploadListener(status);	// 監聽器
		
		request.getSession(true).setAttribute("uploadStatus", status);	// 把 UploadStatus 放到 session 裡
		
		ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());	// Apache 上傳工具
		upload.setProgressListener(listener);	// 設定listener
		
		try {
			List itemList = upload.parseRequest(request);

			for (Iterator it = itemList.iterator(); it.hasNext();) {
				FileItem item = (FileItem) it.next();

				if (item.getName() == "") {	// 無內容的空欄位
					break;
				} else if (item.isFormField()) {	// 非上傳檔案的form資料
					System.out.println("FormField: " + item.getFieldName() + " = " + item.getString());
				} else {	// 上傳檔案資料
					System.out.println("File: " + item.getName());

					// 統一 Linux 與 windows 的路徑分隔符
					String fileName = item.getName().replace("/", "\\");
					if (fileName.lastIndexOf("\\") >= 0) {
						fileName = fileName.substring(fileName.lastIndexOf("\\"));
					}					

					File saved = new File("C:\\upload_test", fileName);
					saved.getParentFile().mkdirs();	// 保證路徑存在

					InputStream ins = item.getInputStream();
					OutputStream ous = new FileOutputStream(saved);

					byte[] tmp = new byte[1024];
					int len = -1;

					while ((len = ins.read(tmp)) != -1) {
						ous.write(tmp, 0, len);
					}

					ous.close();
					ins.close();

					response.getWriter().println("已儲存檔案：" + saved);
				}
			}
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
			response.getWriter().println("上傳發生錯誤：" + fnfe.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("上傳發生錯誤：" + e.getMessage());
		}
	}

}
