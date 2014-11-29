package littleMVC;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LittleMVC
 * 
 * MVC中的Controller，
 * 1. 接受請求
 * 2. 驗證請求
 * 3. 判斷要轉發請求給哪個模型
 * 4. 判斷要轉發請求給哪個畫面
 * 
 * 本例轉發模型為private LittleModel model = new LittleModel();所宣告之物件。
 * 
 * 本例轉發畫面為LittleView.jsp，View的職責為:
 * 1. 提取模型狀態
 * 2. 執行呈現邏輯（Presentation logic）組織回應畫面
 * 
 * 本例連動LittleModel.java、LittleView.jsp。
 * 
 * 在瀏覽器輸入http://localhost:8080/coreyou.servletAndJSP/littleMVC?user=John測試
 * 
 * @author coreyou
 */
@WebServlet(name="LittleController", urlPatterns={"/littleMVC"})
public class LittleController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private LittleModel model = new LittleModel();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LittleController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("user");
		String message = model.doHello(name);
		request.setAttribute("message", message);
		request.getRequestDispatcher("/WEB-INF/LittleView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
