import java.awt.Image;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ghost4j.document.DocumentException;
import org.ghost4j.document.PDFDocument;
import org.ghost4j.renderer.RendererException;
import org.ghost4j.renderer.SimpleRenderer;

/**
 * 1.下載ghostscript 64bit，並安裝。
 * 2.設定環境變數PATH，新增ghostscript安裝資料夾下的bin資料夾
 * 3.下載ghost4j。
 * 4.Window >> Preferences >> Java >> Build Path >> User Libraries >> new 一個ghost4j-1.0.0的library，
 *   將ghost4j.jar和ghost4j/bin/下面的所有jar檔放到這一個Library中。
 * 5.將Library ghost4j-1.0.0加入build path。
 * 6.Project >> Properties >> Deployment Assembly >> Add.. >> Java Build Path Entries >> 
 *   選剛剛加入build path的Library ghost4j-1.0.0。
 *   
 * 注意: ghost4j-0.5.1沒辦法在Tomcat8上面跑，要到ghost4j-1.0.0才可以!!
 * 
 * @author coreyou
 *
 */
@WebServlet("/pdfRender")
public class PictureRenderFromPdfServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PictureRenderFromPdfServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * javax.servlet.http.HttpServletRequest是GET請求的Java代表物件，有關於GET請求的資訊都是由它來取得，
	 * 當請求來到伺服器時，Web容器會建立HttpServletRequest實例來包裝請求中的相關訊息，
	 * 而javax.servlet.http.HttpServletResponse則是回應的Java代表物件。
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.log("執行doGet()...");
		
			// load PDF document
			PDFDocument document = new PDFDocument();
			String rootPath = "C:" + File.separator + "Users" + File.separator + "Corey" + File.separator + "Downloads" + File.separator;
			String pdfFileName = "test.pdf";
			String outputPath = rootPath + "pdfRender" + File.separator;
			document.load(new File(rootPath + pdfFileName));
			
			// create renderer
			SimpleRenderer renderer = new SimpleRenderer();
			
			// set resolution (in DPI)
			renderer.setResolution(300);
			
			// render
			List<Image> images = null;
			try {
				images = renderer.render(document);
			} catch (RendererException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (DocumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			// create output folder
			File outputFolder = new File(outputPath);
			if (!outputFolder.exists()) {
				outputFolder.mkdirs();
			}
			// write images to files to disk as PNG
				for (int i = 0; i < images.size(); i++) {
					ImageIO.write((RenderedImage) images.get(i), "png", new File(outputPath + (i + 1) + ".png"));
				}
			
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.log("執行doPost()...");
		
		String method = request.getMethod();	// 存取Servlet的方式，get或post
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		// 指定請求參數名稱來取得對應元件的值，這裡指定name，getParameter()會對應到name的值並回傳字串
		String name = request.getParameter("name");	
		// getInitParameter("name");也可以替換為getServletConfig().getInitParameter("name");
		// 用來取得web.xml中定義的參數
		String secretName = getInitParameter("name");
		
		// 取得所有init參數的方法
//		Enumeration initParams = this.getInitParameterNames();
//		while(initParams.hasMoreElements()) {
//			String paramName = (String) initParams.nextElement();
//			String paramValue = getInitParameter(paramName);
//		}
		
		/* 
		 * 功能: 在input輸入"HelloServlet"就換頁到secret.html
		 * 換頁轉址有兩種作法: 1.透過RequestDispatcher().forward()  2.透過SendRedirect() 
		 */
		if (name.equalsIgnoreCase(secretName)) {
			/*
			 * 1.
			 * RequestDispatcher()，裡面輸入的參數就是要轉址的位置。如果是以"/"作為開頭，表示取得網站的root path，然後在加上path。
			 * 這裡的路徑會是http://localhost:8080/coreyou.servletAndJSP/WEB-INF/Secret.html，
			 * 但是因為它在WEB-INF下面，因此預設Tomcat是不會允許用http取得裡面的資料，不過只要我們透過forward()就可以取得資源，
			 * 所以最後轉址過後，瀏覽器的網址列不會改變，會維持顯示本頁，也就是http://localhost:8080/coreyou.servletAndJSP/HelloServlet， 
			 * 呼叫forward()之後，就放了一個return;。原因是，當呼叫了forward()以後，程式還是會繼續執行下去。
			 * 但已經說了要把內容輸出交給另外一個資源(/WEB-INF/secret.html)，如果你還在你這邊輸出內容，就會出錯。
			 * 因此，我需要呼叫forward()以後，跳出這個 method，避免輸出到內容造成出錯。
			 */
			request.getRequestDispatcher("/WEB-INF/secret.html").forward(request, response);
			return;
			/*
			 * 2.
			 * SendRedirect()，伺服器發送一個http status 301或者 302給browser告知內容的位置，由browser在去對那個網址發出request。
			 * (301: 永久性重新導向。 302: 臨時性重新導向)
			 * 因此，browser的連接會變換，轉變為http://localhost:8080/coreyou.servletAndJSP/WEB-INF/Secret.html，
			 * 同時 browser總共會有兩個request（一個取得301或302，然後再發出一個request到返回的地址）。
			 * 使用forward()的方法還有一個好處，那就是有些外部沒法直接取得的內容（例如在WEB-INF下面的資源是沒有辦法透過http request取得），不過用forward就可以取得資料。
			 */
//			response.sendRedirect("secret.html");	// 等於下面兩行的功能
			
//			response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);	// http status設為302
//			response.setHeader("Location", "http://localhost:8080/WEB-INF/secret.html");
			
//			response.setHeader("Refresh", "1000; URL=http://localhost:8080/WEB-INF/secret.html");	// 每一秒重新整理此頁面一次
			
		}
		response.setContentType("text/html");
		String requestUri = request.getRequestURI();
		PrintWriter out = response.getWriter();
		out.println("<!DOCTYPE html>");
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Hello Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1> Hello World! </h1>");
		out.println("<p>以" + method + "方式存取頁面</p>");
		out.println("<form action='" + requestUri + "' method='post'>");
		out.println("<input type='text' name='name' />");
		out.println("<input type='submit' value='submit' />");		
		out.println("</form>");
		
		// 取得全域參數(context-param)，定義在web.xml中，全域參數在所有servlet都可以取得，
		// 一般的init-param，只能在該servlet取得。
		// 這裡的效果是當input沒有輸入HelloServlet的時候會顯示message參數的value
		out.println(getServletContext().getInitParameter("message"));
		
		out.println("</body>");
		out.println("</html>");
		out.flush();
		out.close();		
	}

}
