package edu;

public class RegisterBean {
	private int regino;
	private int lecno;
	private String id;
	
	public RegisterBean() {
		super();
	}

	public RegisterBean(int regino, int lecno, String id) {
		super();
		this.regino = regino;
		this.lecno = lecno;
		this.id = id;
	}

	public int getRegino() {
		return regino;
	}

	public void setRegino(int regino) {
		this.regino = regino;
	}

	public int getLecno() {
		return lecno;
	}

	public void setLecno(int lecno) {
		this.lecno = lecno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
}
