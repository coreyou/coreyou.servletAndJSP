package listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Servlet 2.5規範中有8種Listener，分別用於監聽Session、Context、Request等的建立、銷毀、屬性變化等；
 * 另外有一個Listenter能夠監聽存放在Session中的物件。共有6種Event。 這裡一次實現多個介面，讓各種不同的Listener能夠共享資源。
 * Listener需要註冊到web.xml中
 * 
 * 1.HttpSessionListener: 
 * 	監聽session的建立和銷毀，建立時執行sessionCreated，
 * 	逾時或session.invalidate()時執行sessionDestroyed。
 * 2.ServletContextListener: 
 * 	監聽context的建立和銷毀，伺服器啟動或熱部屬War檔時執行contextInitialized，
 * 	關閉伺服器或Web時執行contextDestroyed。
 * 3.ServletRequestListener: 
 * 	監聽request的建立和銷毀，使用者每次請求都會執行requestInitialized，
 * 	處理完畢自動銷毀前執行requestDestroyed，如果一個HTML有多個圖片，請求一次可能會觸發多次request事件。
 * 4.HttpSessionAttributeListener:
 * 	監聽session的屬性變化，session增加、更新、移除屬性時，會分別執行attributeAdded、attributeReplaced、attributeRemoved。
 * 5.ServletContextAttributeListener:
 * 	監聽context的屬性變化
 * 6.ServletRequestAttributeListener:
 * 	監聽request的屬性變化
 * 7.HttpSessionBindingListener:
 * 	當物件被放到session裡會執行valueBound，物件從session中移除會執行valueUnbound。
 * 8.HttpSessionActivationListener:
 * 	伺服器關閉時，會將session裡的內容存到硬碟上，這個過程叫做鈍化，會執行sessionWillPassivate()，
 * 	伺服器重新開機時，session內容會從硬碟重新載入，會執行sessionDidActivate()
 * 
 * 7.8.兩種Listener監聽的是session中的物件而非session等，所以不需要在web.xml中宣告，寫在PersonInfo.java裡面。
 * 
 * @author coreyou
 *
 */
public class ListenerTest implements HttpSessionListener,
		ServletContextListener, ServletRequestListener, 
		HttpSessionAttributeListener {

	Log log = LogFactory.getLog(getClass());

	// 建立 session
	public void sessionCreated(HttpSessionEvent se) {
		HttpSession session = se.getSession();
		log.info("ListenerTest sessionCreated(): 新建立一個session, ID為: "
				+ session.getId());
	}

	// 銷毀 session
	public void sessionDestroyed(HttpSessionEvent se) {
		HttpSession session = se.getSession();
		log.info("ListenerTest sessionDestroyed(): 銷毀一個session, ID為: "
				+ session.getId());
	}

	// 載入 context
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext servletContext = sce.getServletContext();
		log.info("ListenerTest contextInitialized(): 即將啟動"
				+ servletContext.getContextPath());
	}

	// 移除 context
	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext servletContext = sce.getServletContext();
		log.info("ListenerTest contextDestroyed(): 即將關閉"
				+ servletContext.getContextPath());
	}

	// 建立 request
	public void requestInitialized(ServletRequestEvent sre) {

		HttpServletRequest request = (HttpServletRequest) sre
				.getServletRequest();

		String uri = request.getRequestURI();
		uri = request.getQueryString() == null ? uri : (uri + "?" + request
				.getQueryString());

		request.setAttribute("dateCreated", System.currentTimeMillis());

		log.info("ListenerTest requestInitialized(): IP "
				+ request.getRemoteAddr() + " 請求 " + uri);
	}

	// 銷毀 request
	public void requestDestroyed(ServletRequestEvent sre) {

		HttpServletRequest request = (HttpServletRequest) sre
				.getServletRequest();

		long time = System.currentTimeMillis()
				- (Long) request.getAttribute("dateCreated");

		log.info("ListenerTest requestDestroyed(): " + request.getRemoteAddr()
				+ "請求處理結束, 耗時" + time + "毫秒. ");
	}

	// 增加session屬性
	public void attributeAdded(HttpSessionBindingEvent se) {
		HttpSession session = se.getSession();
		String name = se.getName();
		log.info("ListenerTest attributeAdded(): 新增session屬性：" + name + ", 值為：" + se.getValue());
	}

	// 刪除session屬性
	public void attributeRemoved(HttpSessionBindingEvent se) {
		HttpSession session = se.getSession();
		String name = se.getName();
		log.info("ListenerTest attributeRemoved(): 刪除session屬性：" + name + ", 值為：" + se.getValue());
	}

	// 修改session屬性
	public void attributeReplaced(HttpSessionBindingEvent se) {
		HttpSession session = se.getSession();
		String name = se.getName();
		Object oldValue = se.getValue();
		log.info("ListenerTest attributeReplaced(): 修改session屬性：" + name + ", 原值：" + oldValue + ", 新值："
				+ session.getAttribute(name));
	}

}