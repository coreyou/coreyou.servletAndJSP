import java.applet.*;
import java.awt.*;
/**
 * 與ae_plugin.jsp連動
 * 
 * @author coreyou
 *
 */

public class ActionElementPlugin extends Applet {
	
	private String strName, strAuthor, strColor;
	
	public void init() {
		strName = getParameter("ename");
		strAuthor = getParameter("author");
		strColor = getParameter("color");
	}
	
	public void paint(Graphics g) {
		Font font = new Font("Times New Roman", Font.BOLD, 28);
		g.setFont(font);
		if (strColor.indexOf("red") != -1) {
			g.setColor(Color.red);
		} else {
			g.setColor(Color.blue);
		}
		g.drawString("English name:" + strName, 20, 20);
		g.drawString("Author:" + strAuthor, 20, 50);
	}
}
