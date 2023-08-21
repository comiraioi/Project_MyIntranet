package board;

public class NoticeBean {
	private int seqno;
	private int impor;
	private String code;
	private String id;
	private String subject;
	private String regdate;
	private String content;
	
	public NoticeBean(int seqno, int impor, String code, String id, String subject, String regdate, String content) {
		super();
		this.seqno = seqno;
		this.impor = impor;
		this.code = code;
		this.id = id;
		this.subject = subject;
		this.regdate = regdate;
		this.content = content;
	}

	public NoticeBean() {
		super();
	}

	public int getSeqno() {
		return seqno;
	}

	public void setSeqno(int seqno) {
		this.seqno = seqno;
	}

	public int getImpor() {
		return impor;
	}

	public void setImpor(int impor) {
		this.impor = impor;
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

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}
