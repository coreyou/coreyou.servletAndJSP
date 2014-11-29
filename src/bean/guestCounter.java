package bean;
/**
 * 與guestCounterWithBean.jsp連動
 * 
 * @author coreyou
 *
 */
public class guestCounter {

	private int count;
	
	public int getCount() {
		return ++count;
	}
	
	public void setCount(int count) {
		this.count = count;
	}
}
