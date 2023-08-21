package com;

public class CompanyBean {
	private int deptno;
	private String code;
	private String dept;
	
	public CompanyBean() {
		super();
	}

	public CompanyBean(int deptno, String code, String dept) {
		super();
		this.deptno = deptno;
		this.code = code;
		this.dept = dept;
	}
	
	public int getDeptno() {
		return deptno;
	}

	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}
	
}
