package filter;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
/**
 * 如果想要測試要在web.xml加上<filter>和<filter-mapping>、<init-param>
 * 並且設定一個privilege.properties在WEB-INF中。
 * 
 * @author coreyou
 *
 */
public class PrivilegeFilter implements Filter {
	
	private Properties pp = new Properties();

	@Override
	public void init(FilterConfig config) throws ServletException {
		// TODO Auto-generated method stub
		// 從 初始化參數 中獲得權 限設定檔案 的位置
		String file = config.getInitParameter("file");	// 在web.xml設定init-param
		String realPath = config.getServletContext().getRealPath(file);
		try {
			pp.load(new FileInputStream(realPath));
		} catch (Exception e) {
			config.getServletContext().log("讀取權限控制檔案失敗。", e);
		}
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;
		// 獲得存取的路徑，例如：admin.jsp
		String requestURI = req.getRequestURI().replace(req.getContextPath() + "/", "");
		// 獲得 action 參數，例如：add
		String action = req.getParameter("action");
		action = action == null ? "" : action;
		
		// 拼接成 URI。例如：log.do?action=list
		String uri = requestURI + "?action=" + action;
		
		// 從 session 中獲得使用者權限角色。
		String role = (String) req.getSession(true).getAttribute("role");
		role = role == null ? "guest" : role;
		
		boolean authentificated = false;
		// 開始檢查該使用者角色是否有權限存取 uri
		for (Object obj : pp.keySet()) {
			String key = ((String) obj);
			// 使用正則表達式驗證 需要將 ? . 替換一下，並將通配符 * 處理一下
			if (uri.matches(key.replace("?", "\\?").replace(".", "\\.")
					.replace("*", ".*"))) {
				// 如果 role 比對
				if (role.equals(pp.get(key))) {
					authentificated = true;
					break;
				}
			}
		}
		if (!authentificated) {
//			throw new RuntimeException(new AccountException("您無權存取該頁面。請以合適的身份登陸後檢視。"));
		}
		// 繼續執行
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		pp = null;	// 註銷
	}

}
