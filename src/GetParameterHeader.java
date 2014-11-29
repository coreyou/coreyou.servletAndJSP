

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetParameterHeader
 * 
 * 當請求來到伺服器時，Web容器會建立HttpServletRequest實例來包裝請求中的相關訊息，
 * HttpServletRequest定義了取得一些通用請求資訊的方法: getParameter()、getParameterValues()、getParameterNames()、getParameterMap()。
 * 
 * 對於HTTP的標頭（Header）資訊，可以使用以下的方法來取得: getHeader()、getHeaders()、getHeaderNames()。
 * 
 * 也可以設定請求的編碼: setCharacterEncoding()。
 * 
 * @author coreyou
 */
@WebServlet(name = "GetParameterHeader", urlPatterns = {"/GetParameterHeader"})
public class GetParameterHeader extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetParameterHeader() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet ShowHeader</title>");
        out.println("</head>");
        out.println("<body>");
        // 指定標頭名稱後可傳回Enumeration，元素為字串。
        Enumeration headers = request.getHeaders("host");
        // request.getHeaderNames()取得所有標頭名稱，以Enumeration傳回，內含所有標頭字串名稱。
        Enumeration names = request.getHeaderNames();
        while (names.hasMoreElements()) {
            String name = (String) names.nextElement();
        	// request.getHeader(name)指定標頭名稱後可傳回瀏覽器所送出的標頭訊息，為字串值。
            out.println(name + ": " + request.getHeader(name) + "<br>");
        }	
        
        /* 
         * 如果表單上有可複選的元件，例如核取方塊（Checkbox）、清單（List）等，
         * 則同一個請求參數名稱會有多個值（此時的HTTP查詢字串其實就是像name=10&name=20&name=30），
         * 此時你可以用getParameterValues()方法取得一個String陣列，陣列元素代表所有被選取選項的值，
         * 下面那列會取出name表單元件的所有值，並回傳給values字串陣列。
         */
        String[] values = request.getParameterValues("name");
        // request.getParameterNames()方法，會傳回一個Enumeration物件，當中包括所有的請求參數名稱。
        Enumeration parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String parameterName = (String) names.nextElement();
        	// request.getParameter(parameterName)指定請求參數名稱來取得對應的值，為字串值，若無指定值則回傳Null。
            out.println(parameterName + ": " + request.getParameter(parameterName) + "<br />");
        }	
        
        /*
         * 如果客戶端沒有在Content-Type標頭中設定字元編碼資訊（例如Content-Type: text/html; charset=UTF-8），
         * 此時使用HttpServletRequest的getCharacterEncoding()傳回值會是null。
         * 你可以在取得任何請求值之「前」，使用HttpServletRequest的setCharacterEncoding()方法來指定取得請求參數時所使用的編碼，
         * setCharacterEncoding()只對POST產生作用，GET不一定有用。
         * 因為GET是把資料放在URL後面，直接讓HTTP伺服器處理；而POST的資料是放在HTTP Request封包中，容器才處理得到。
         * 
         * 如果要處理已經收到的request的編碼，可以參照以下兩行範例，以下是由ISO-8859-1轉換成UTF-8
         * String username = req.getParameter("name");
         * String username = new String(username.getBytes("ISO-8859-1"), "UTF-8");
         */
        out.println("characterEncoding: " + request.getCharacterEncoding() + "<br />");	// 印出null
        request.setCharacterEncoding("UTF-8");
        out.println("characterEncoding: " + request.getCharacterEncoding());	// 印出UTF-8
        
        out.println("</body>");
        out.println("</html>");
        out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
