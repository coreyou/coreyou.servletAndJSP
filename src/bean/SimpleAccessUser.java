package bean;
/**
 * 與el_accessJavaBean.jsp連動
 * 
 * @author coreyou
 *
 */
public class SimpleAccessUser {
	private String name;
	private String dept;
	
	/**
	 * mutator
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * mutator
	 * @param dept
	 */
	public void setDept(String dept) {
		this.dept = dept;
	}
	
	/**
	 * accessors
	 * @return
	 */
	public String getName() {
		return name;
	}
	
	/**
	 * accessors
	 * @return
	 */
	public String getDept() {
		return dept;
	}
}
