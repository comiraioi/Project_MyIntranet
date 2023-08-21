package attd;

import java.util.Date;

public class DayoffBean {
	private String id;		//emp 아이디
	private String fdate;		//휴가 시작날
	private double off;		//사용 연차일수
	private String dost;	//연차 사유
	private double remain;	//잔여 연차일
	
	public DayoffBean() {
		super();
	}

	public DayoffBean(String id, String fdate, double off, String dost, double remain) {
		super();
		this.id = id;
		this.fdate = fdate;
		this.off = off;
		this.dost = dost;
		this.remain = remain;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFdate() {
		return fdate;
	}

	public void setFdate(String fdate) {
		this.fdate = fdate;
	}

	public double getOff() {
		return off;
	}

	public void setOff(double off) {
		this.off = off;
	}

	public String getDost() {
		return dost;
	}

	public void setDost(String dost) {
		this.dost = dost;
	}

	public double getRemain() {
		return remain;
	}

	public void setRemain(double remain) {
		this.remain = remain;
	}
	
}
