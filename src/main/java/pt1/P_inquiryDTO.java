package pt1;

import java.sql.Timestamp;

public class P_inquiryDTO {
	private int num; // 글 번호
	private int pnum; // 상품 번호
	private String writer; // 작성자
	private String subject; // 제목
	private String content; // 내용
	private Timestamp reg; // 올린 날짜
	private int ref; // 글 그룹
	private int ref_step; // 그룹별 답글
	private int status; // 상태
	private String brand; // 브랜드
	private String pname; // 상품명

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		if (brand != null) {
			this.brand = brand;
		}
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		if (pname != null) {
			this.pname = pname;
		}
	}

	public int getRef_step() {
		return ref_step;
	}

	public void setRef_step(int ref_step) {
		if (ref_step > 0) {
			this.ref_step = ref_step;
		}
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		if (num >= 0) {
			this.num = num;
		}
	}

	public int getPnum() {
		return pnum;
	}

	public void setPnum(int pnum) {
		if (pnum > 0) {
			this.pnum = pnum;
		}
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		if (writer != null && writer != "") {
			this.writer = writer;
		}
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		if (subject != null && subject != "") {
			this.subject = subject;
		}
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		if (content.length() >= 10 && content != null) {
			this.content = content;
		}
	}

	public Timestamp getReg() {
		return reg;
	}

	public void setReg(Timestamp reg) {
		if (reg != null) {
			this.reg = reg;
		}
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		if (ref > 0) {
			this.ref = ref;
		}
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		if (status == 0 || status == 1) {
			this.status = status;
		}
	}
}
