package com;

import java.util.Date;

public class EmpBean {
	private int empno;			//사번(시퀀스)
	private String curlog;		//최근 접속
	private String lastlog;		//마지막 접속
	private String image;		//사원 프로필사진
	private String name;		//사원이름
	private String code;		//부서코드
	private String id;			//아이디('co'+부서코드+사번)
	private String pw;			//비밀번호
	private Date birth;		//생년월일
	private String email;		//이메일
	private String position;	//직급(사원,주임,대리,과장,차장,부장)
	private int salary;			//연봉
	private String authority;	//접근권한(일반or관리자)
	
	public EmpBean() {
		super();
	}

	public EmpBean(int empno, String curlog, String lastlog, String image, String name, String code, String id, String pw, Date birth, String email,
			String position, int salary, String authority) {
		super();
		this.empno = empno;
		this.curlog = curlog;
		this.lastlog = lastlog;
		this.image = image;
		this.name = name;
		this.code = code;
		this.id = id;
		this.pw = pw;
		this.birth = birth;
		this.email = email;
		this.position = position;
		this.salary = salary;
		this.authority = authority;
	}

	public int getEmpno() {
		return empno;
	}

	public void setEmpno(int empno) {
		this.empno = empno;
	}
	
	public String getCurlog() {
		return curlog;
	}

	public void setCurlog(String curlog) {
		this.curlog = curlog;
	}

	public String getLastlog() {
		return lastlog;
	}

	public void setLastlog(String lastlog) {
		this.lastlog = lastlog;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

}
