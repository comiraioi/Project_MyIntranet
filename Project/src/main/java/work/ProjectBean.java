package work;

public class ProjectBean {
	private int prono;
	private String code;
	private String id;
	private String pname;
	private String todo;
	private int progress;
	
	public ProjectBean() {
		super();
	}

	public ProjectBean(int prono, String code, String id, String pname, String todo, int progress) {
		super();
		this.prono = prono;
		this.code = code;
		this.id = id;
		this.pname = pname;
		this.todo = todo;
		this.progress = progress;
	}

	public int getProno() {
		return prono;
	}

	public void setProno(int prono) {
		this.prono = prono;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getTodo() {
		return todo;
	}

	public void setTodo(String todo) {
		this.todo = todo;
	}

	public int getProgress() {
		return progress;
	}

	public void setProgress(int progress) {
		this.progress = progress;
	}
	
}
