package listener;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionActivationListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionEvent;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 和singletonLogin.jsp、PersonInfo.java有關
 * 
 * 7.HttpSessionBindingListener:
 * 	當物件被放到session裡會執行valueBound，物件從session中移除會執行valueUnbound。
 * 8.HttpSessionActivationListener:
 * 	伺服器關閉時，會將session裡的內容存到硬碟上，這個過程叫做鈍化，會執行sessionWillPassivate()，
 * 	伺服器重新開機時，session內容會從硬碟重新載入，會執行sessionDidActivate()
 * 
 * 7.8.兩種Listener監聽的是session中的物件而非session等，所以不需要在web.xml中宣告，寫在PersonInfo.java裡面。
 * 但是除了以上兩種，這裡的HttpSessionAttributeListener還是需要在web.xml中宣告。
 * 
 * @author coreyou
 *
 */
public class LoginSessionListener implements HttpSessionAttributeListener,
	Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8822467858812735884L;

	Log log = LogFactory.getLog(this.getClass());

	// map存所有的登入者(包含所有機器上的)
	Map<String, HttpSession> allMachineUserMap = new HashMap<String, HttpSession>();

	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {

		String sessionName = event.getName();

		// 登入
		if (sessionName.equals("personInfo")) {

			PersonInfo personInfo = (PersonInfo) event.getValue();

			if (allMachineUserMap.get(personInfo.getAccount()) != null) {

				// map 中有記錄，表明該帳號在其他機器上登入過，將以前的登入失效
				HttpSession session = allMachineUserMap.get(personInfo.getAccount());
				PersonInfo oldPersonInfo = (PersonInfo) session.getAttribute("personInfo");

				log.info("LoginSessionListener attributeAdded(): 帳號" + oldPersonInfo.getAccount() + "在" + oldPersonInfo.getIp() + "已經登入，該登入將被迫下線。");

				session.removeAttribute("personInfo");
				session.setAttribute("msg", "您的帳號已經在其他機器上登入，您被迫下線。");
			}

			// 將session以使用者名稱為索引，放入map中
			allMachineUserMap.put(personInfo.getAccount(), event.getSession());
			log.info("LoginSessionListener attributeAdded(): 帳號" + personInfo.getAccount() + "在" + personInfo.getIp() + "登入。");
		}
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {

		String sessionName = event.getName();

		// 註銷
		if (sessionName.equals("personInfo")) {
			// 將該session從map中移除
			PersonInfo personInfo = (PersonInfo) event.getValue();
			allMachineUserMap.remove(personInfo.getAccount());
			log.info("LoginSessionListener attributeRemoved(): 帳號" + personInfo.getAccount() + "註銷。");
		}
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {

		String sessionName = event.getName();

		// 沒有註銷的情況下，用另一個帳號登入
		if (sessionName.equals("personInfo")) {

			// 移除舊的的登入資訊
			PersonInfo oldPersonInfo = (PersonInfo) event.getValue();
			allMachineUserMap.remove(oldPersonInfo.getAccount());

			// 新的登入資訊
			PersonInfo personInfo = (PersonInfo) event.getSession()
					.getAttribute("personInfo");

			// 也要檢查新登入的帳號是否在別的機器上登入過
			if (allMachineUserMap.get(personInfo.getAccount()) != null) {
				// map 中有記錄，表明該帳號在其他機器上登入過，將以前的登入失效
				HttpSession session = allMachineUserMap.get(personInfo.getAccount());
				session.removeAttribute("personInfo");
				session.setAttribute("msg", "您的帳號已經在其他機器上登入，您被迫下線。");
			}
			allMachineUserMap.put("personInfo", event.getSession());
		}

	}
	
//	@Override
//	public void valueBound(HttpSessionBindingEvent event) {
//		// TODO Auto-generated method stub
//		// 被放進session前被呼叫
//		HttpSession session = event.getSession();	// 所在的session
//		String name = event.getName();	// session中的屬性名
//		log.info("LoginSessionListener valueBound() :" + this + "被綁定到session \"" + session.getId() + "\"的 " + name + "屬性上");
//	}
//
//	@Override
//	public void valueUnbound(HttpSessionBindingEvent event) {
//		// TODO Auto-generated method stub
//		// 從session中移除後被呼叫
//		HttpSession session = event.getSession();	// 發生變化的session
//		String name = event.getName();
//		log.info("LoginSessionListener valueUnbound():" + this + "被從session \"" + session.getId() + "\"的" + name + "屬性上移除");
//	}
//
//	@Override
//	public void sessionWillPassivate(HttpSessionEvent se) {
//		// TODO Auto-generated method stub
//		// 即將被鈍化到硬碟時呼叫
//		HttpSession session = se.getSession();	// 所在的session
//		log.info("LoginSessionListener sessionWillPassivate():" + this + "即將儲存到硬碟。sessionId: " + session.getId());
//	}
//
//	@Override
//	public void sessionDidActivate(HttpSessionEvent se) {
//		// TODO Auto-generated method stub
//		// 從硬碟回復後被呼叫
//		HttpSession session = se.getSession();	//　所在的session
//		log.info("LoginSessionListener sessionDidActivate():" + this + "已經成功從硬碟中載入。sessionId: " + session.getId());
//	}
	
}
