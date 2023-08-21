package attd;

public class OverBean {
	private String id;	//emp 아이디
	private String odate;	//초과근무 날짜
	private int hour;	//초과근무 시간
	private String otst;	//초과근무 사유
	private int cumul;	//누적 초과근무 시간
	
	public OverBean() {
		super();
	}

	public OverBean(String id, String odate, int hour, String otst, int cumul) {
		super();
		this.id = id;
		this.odate = odate;
		this.hour = hour;
		this.otst = otst;
		this.cumul = cumul;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOdate() {
		return odate;
	}

	public void setOdate(String odate) {
		this.odate = odate;
	}

	public int getHour() {
		return hour;
	}

	public void setHour(int hour) {
		this.hour = hour;
	}

	public String getOtst() {
		return otst;
	}

	public void setOtst(String otst) {
		this.otst = otst;
	}

	public int getCumul() {
		return cumul;
	}

	public void setCumul(int cumul) {
		this.cumul = cumul;
	}
	
	
}
