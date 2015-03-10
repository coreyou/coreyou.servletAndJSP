package taglib;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
/**
 * input: num
 * ouput: size
 * 
 * 與web.xml、coreyouTagLib.tld、tagLig_ChangeSizeTag.jsp有關，開啟tagLig_ChangeSizeTag.jsp測試。
 * 
 * @author coreyou
 *
 */
public class ChangeSizeTag extends SimpleTagSupport {
	private int num;
	
	public void setNum(int num) {
		this.num = num;
	}
	
	public void doTag() throws JspException, IOException {
		for (int i = 0; i < num; i++) {
			getJspContext().setAttribute("size", String.valueOf(i+1));
			getJspBody().invoke(null);	// 將上一行設定的變數以預設的JspWriter類別回傳給呼叫者
		}
	}
}
