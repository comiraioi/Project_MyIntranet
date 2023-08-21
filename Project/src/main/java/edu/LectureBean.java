package edu;

public class LectureBean {
	private int lecno;
	private String code;
	private String title;
	private String thumbnail;
	private int lectime;
	private String contents;
	
	public LectureBean() {
		super();
	}

	public LectureBean(int lecno, String code, String title, String thumbnail, int lectime, String contents) {
		super();
		this.lecno = lecno;
		this.code = code;
		this.title = title;
		this.thumbnail = thumbnail;
		this.lectime = lectime;
		this.contents = contents;
	}

	public int getLecno() {
		return lecno;
	}

	public void setLecno(int lecno) {
		this.lecno = lecno;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	
	public int getLectime() {
		return lectime;
	}

	public void setLectime(int lectime) {
		this.lectime = lectime;
	}
	
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}
	
}
