package actionElement;
/**
 * 和actionElements.jsp與actionElementBean.jsp連動，
 * 本檔案為以上兩個JSP的POJO
 * 
 * @author coreyou
 */
public class Action {
	private String name;
	private int age;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
}
