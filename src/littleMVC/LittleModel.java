package littleMVC;

import java.util.*;
/**
 * MVC中的Model，
 * 1. 保存應用程式狀態
 * 2. 執行應用程式商務邏輯（Business logic）
 * 
 * 本例根據使用者的user請求參數不同，會取得不同的訊息給message。
 * 
 * 本例連動LittleController.java、LittleView.jsp。
 * 
 * @author coreyou
 *
 */
public class LittleModel {
	private Map<String, String> messages;
	
	public LittleModel() {
		// TODO Auto-generated constructor stub
		messages = new HashMap<String, String>();
		messages.put("Corey", "Hello");
		messages.put("John", "Hi");
		messages.put("Peter", "Yo");
	}
	
	public String doHello(String user) {
		String message = messages.get(user);
		return message + ", " + user + "!";
	}
}
