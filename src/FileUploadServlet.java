

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


/**
 * Servlet implementation class FileUploadServlet
 * 
 * 使用Apache Common Fileupload類別函式庫來實作上傳功能，
 * 必須先將commons-fileupload-1.2.1.jar和commons-io-2.4.jar放入\WebContent\WEB-INF\lib，
 * 
 * 
 * 開啟fileUpload.html測試。
 */
@WebServlet("/FileUploadServlet")
public class FileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private static final String UPLOAD_DIRECTORY = "upload";		// location to store file uploaded
	private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;	// 3MB
	private static final int MAX_FILE_SIZE = 1024 * 1024 * 40;		// 40MB
	private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50;	// 50MB
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTF-8");
		response.getWriter().println("請以 POST 方式上傳檔案");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// checks if the request actually contains upload file
        if (!ServletFileUpload.isMultipartContent(request)) {
        	// if not, we stop here
            PrintWriter writer = response.getWriter();
            writer.println("Error: Form must has enctype=multipart/form-data.");
            writer.flush();
            return;
        }
        
		File file1 = null, file2 = null;
		String description1 = null, description2 = null;
		
		// configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk 
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        
        ServletFileUpload upload = new ServletFileUpload(factory);
        
        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);
         
        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);
        
        // constructs the directory path to store upload file
        // this path is relative to application's directory
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }               
        
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">");
		out.println("<html>");
		out.println("<head><title>上傳檔案</title></head>");
		out.println("	<body>");		
		out.println("		<fieldset>");
		out.println("			<legend>上傳檔案</legend>");
		out.println("			<label>上傳日誌: <br />");
				
		
		/** 
		 * 可以把這段和下面那段互換，分別使用不同方法來實作上傳檔案 
		 * 這段使用的是DiskFileUpload解析 request
		 */
//		DiskFileUpload diskFileUpload = new DiskFileUpload();
//		try {
//			// 將 解析的結果 放置在 List 中
//			List<FileItem> list = diskFileUpload.parseRequest(request);
//			out.println("檢查所有的 FileItem ... <br/>");
//			// 檢查 list 中所有的 FileItem
//			for (FileItem fileItem : list) {
//				if (fileItem.isFormField()) {
//					// 如果是 文字域
//					if ("description1".equals(fileItem.getFieldName())) {
//						// 如果該 FileItem 名稱為 description1
//						out.println("檢查到 description1 ... <br/>");
//						description1 = new String(fileItem.getString().getBytes(), "UTF-8");
//					}
//					if ("description2".equals(fileItem.getFieldName())) {
//						// 如果該 FileItem 名稱為 description2
//						out.println("檢查到 description2 ... <br/>");
//						description2 = new String(fileItem.getString().getBytes(), "UTF-8");
//					}
//				} else {
//					// 否則，為檔案域
//					if ("file1".equals(fileItem.getFieldName())) {
//						// 客戶端檔案路徑建構的 File 對象
//						File remoteFile = new File(new String(fileItem.getName().getBytes(), "UTF-8"));
//						out.println("檢查到 file1 ... <br/>");
//						out.println("客戶端檔案位置: " + remoteFile.getAbsolutePath() + "<br/>");
//						// 服務器端檔案，放在 upload 檔案夾下
//						file1 = new File(this.getServletContext().getRealPath("upload"), remoteFile.getName());
//						file1.getParentFile().mkdirs();
//						file1.createNewFile();
//						
//						// 寫檔案，將 FileItem 的檔案內容寫到檔案中
//						InputStream ins = fileItem.getInputStream();
//						OutputStream ous = new FileOutputStream(file1);
//						
//						try {
//							byte[] buffer = new byte[1024]; 
//							int len = 0;
//							while((len = ins.read(buffer)) > -1)
//								ous.write(buffer, 0, len);
//							out.println("已儲存檔案" + file1.getAbsolutePath() + "<br/>");
//						} finally {
//							ous.close();
//							ins.close();
//						}
//					}
//					if ("file2".equals(fileItem.getFieldName())) {
//						// 客戶端檔案路徑建構的 File 對象
//						File remoteFile = new File(new String(fileItem.getName().getBytes(), "UTF-8"));
//						out.println("檢查到 file2 ... <br/>");
//						out.println("客戶端檔案位置: " + remoteFile.getAbsolutePath() + "<br/>");
//						// 服務器端檔案，放在 upload 檔案夾下
//						file2 = new File(this.getServletContext().getRealPath("upload"), remoteFile.getName());
//						file2.getParentFile().mkdirs();
//						file2.createNewFile();
//						
//						// 寫檔案，將 FileItem 的檔案內容寫到檔案中
//						InputStream ins = fileItem.getInputStream();
//						OutputStream ous = new FileOutputStream(file2);
//						
//						try {
//							byte[] buffer = new byte[1024]; 
//							int len = 0;
//							while((len=ins.read(buffer)) > -1)
//								ous.write(buffer, 0, len);
//							out.println("已儲存檔案" + file2.getAbsolutePath() + "<br/>");
//						} finally {
//							ous.close();
//							ins.close();
//						}
//					}
//				}
//			}
//			out.println("Request 解析完畢");
//		} catch (FileUploadException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		/****************************************************************************************/
		
		/** 
		 * 可以把這段和上面那段互換，分別使用不同方法來實作上傳檔案 
		 * 這段使用的是Apache Commons Fileupload
		 */
		try {
            // parses the request's content to extract file data
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);	// 解析request，把結果放在list中
 
            // 檢查 list 中所有的 FileItem
            if (formItems != null && formItems.size() > 0) {
                // iterates over form's fields
                for (FileItem item : formItems) {
                    // processes only fields that are not form fields
                    if (!item.isFormField()) {	// 為檔案域時
                    	File remoteFile = new File(new String(item.getName().getBytes(), "UTF-8"));
                        String fileName = new File(item.getName()).getName();
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
 
                        if ("file1".equals(item.getFieldName())) {
                        	out.println("檢查到 file1... <br/>");
    						out.println("客戶端檔案位置: " + remoteFile.getAbsolutePath() + "<br/>");	// 這個位址是錯誤的
    						
                            // saves the file on disk
                            item.write(storeFile);
                            
                            out.println("已儲存檔案: " + storeFile.getAbsolutePath() + "<br/>");
                        }
                        if ("file2".equals(item.getFieldName())) {
                        	out.println("檢查到 file2... <br/>");
    						out.println("客戶端檔案位置: " + remoteFile.getAbsolutePath() + "<br/>");
    						
                            // saves the file on disk
                            item.write(storeFile);
                            
                            out.println("已儲存檔案: " + storeFile.getAbsolutePath() + "<br/>");
                        }
                        
                    } else {	// 為文字域時
                    	if ("description1".equals(item.getFieldName())) {
    						// 如果該 FileItem 名稱為 description1
    						out.println("檢查到 description1 ... <br/>");
    						//description1 = new String(item.getString().getBytes(), "UTF-8");
    						description1 = request.getParameter("description1");
    					}
    					if ("description2".equals(item.getFieldName())) {
    						// 如果該 FileItem 名稱為 description2
    						out.println("檢查到 description2 ... <br/>");
    						//description2 = new String(item.getString().getBytes(), "UTF-8");
    						description2 = request.getParameter("description2");
    					}
                    }
                }
            }
        } catch (Exception ex) {
            request.setAttribute("message", "There was an error: " + ex.getMessage());
        }
		/****************************************************************************************/
		
		out.println("			</label>");
		out.println("			<label>description1: +" + description1 + "</label><br />");
		out.println("			<label>description2: +" + description2 + "</label>");
		out.println("		</fieldset>");		
		out.println("	</body>");
		out.println("</html>");
		out.flush();
		out.close();
	}

}
