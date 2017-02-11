package el;
/**
 * 對應到coreyouTagLib.tld裡面的<function></function>元素，
 * 
 * 開啟el_function.jsp測試。
 * 
 * @author coreyou
 *
 */
public class ElFunction {
	
	public static String uCase(String input) {
		return input.toUpperCase();
	}
	
	public static String lCase(String input) {
		return input.toLowerCase();
	}
	
	public static String reverse(String input) {
		String output = new StringBuffer(input).reverse().toString();
		return output;
	}
	
	public static Boolean contain(String x, String y) {
		boolean isContain = (x.indexOf(y) == -1) ? false : true;
		return Boolean.valueOf(isContain);
	}
}
