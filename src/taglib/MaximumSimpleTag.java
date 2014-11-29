package taglib;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
/**
 * 此檔為標記處理器(tag handler)，HelloTag.java這個標記處理器使用了實作Tag Interface或繼承TagSupport class的方法，
 * 但是這裡使用的方法不同，這裡使用實作SimpleTag Interface或繼承SimpleTagSupport class的方法，
 * 不同點在於SimpleTag提供了更簡化的doTag()，以取代Tag Interface中的doStartTag()、doEndTag()，
 * 所有商業邏輯、重複評估的標記內容都只需要寫在doTag()就可以了，SimpleTag的生命週期如下：
 * 1. create new instance來產生新的類別處理器。
 * 2. setJspContext()設定標記處理器所使用的JspContext object。
 * 3. setParent()/getParent()設定Tag的父子階層關係。
 * 4. setter()與JavaBean的setter意思一樣。
 * 5. setJspBody()於存在標記主體時，讓JSP container去設定標記內容。
 * 6. doTag()只會被呼叫一次，處理標記邏輯、重複性的主體內容評估。
 * 
 * 與web.xml、coreyouTagLib.tld、tagLig_MaximumSimpleTag.jsp有關，開啟tagLib_demo.html測試。
 * 
 * @author coreyou
 *
 */
public class MaximumSimpleTag extends SimpleTagSupport {
	private int x = 0;
	private int y = 0;
	
	public void setX(int x) {
		this.x = x;
	}
	
	public void setY(int y) {
		this.y = y;
	}
	
	public void doTag() throws JspException, IOException {
		JspWriter out = getJspContext().getOut();
		int z = 0;
		z = (x > y) ? x : y;
		out.println("<font color='blue'><b>" + z + "</b></font>");
	}
}
