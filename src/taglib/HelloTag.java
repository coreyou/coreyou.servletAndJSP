package taglib;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
import java.io.IOException;
/**
 * 此檔為標記處理器(tag handler)，必須實作Tag Interface或是繼承TagSupport class(這裡使用後者)，
 * Tag Interface的生命週期:
 * 1. setPageContext()讓自訂標記可以存取JSP隱含物件。
 * 2. setParent()/getParent()設定Tag的父子階層關係。
 * 3. setter()與JavaBean的setter意思一樣。
 * 4. doStartTag()為標記中開始處理商業邏輯的地方，有兩個回傳值:EVAL_BODY_INCLUDE, SKIPE_BODY，
 *    前者代表評估並執行標記主體內容，並丟回輸出結果；後者代表忽略標記主體其餘內容，並返回呼叫者。
 * 5. doEndTag()為標記結束前該進行的清理動作，有兩個回傳值:EVAL_PAGE, SKIP_PAGE，
 *    前者代表將繼續處理自訂標記後的JSP程式碼；後者表示將忽略自訂標記後JSP的其餘內容，並返回呼叫者。
 * 6. release()由JSP引擎判斷認為不在需要某tag handler object的時候，呼叫release()清除佔用的資源，
 *    此方法也可以不實作，讓垃圾回收機制去做。
 * 
 * 
 * 與web.xml、coreyouTagLib.tld、tagLig_HelloMyTag.jsp有關，開啟tagLib_demo.html測試。
 * 
 * @author coreyou
 *
 */
public class HelloTag extends TagSupport {
	
	private String name = null;
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int doStartTag() throws JspException {
		JspWriter out = pageContext.getOut();
		try {
			out.println("<p>");
			if (this.name == null) {
				out.println("Hello, world!");
			} else {
				out.println("Hello, " + this.name + "!");
			}
			out.println("</p>");
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		return SKIP_BODY;
	}
}
