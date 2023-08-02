package pt1;

import java.sql.Timestamp;

public class InquiryDTO {
	private int num;
	private String writer;
	private String subject;
	private String content;
	private Timestamp reg_date;
	private int readcount;
	private int ref;
	private int re_step;
	private int re_level;
	private int status;
	private String ip;
	private String category;

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		if (ip != null) {
			this.ip = ip;
		}
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		if (category != null && category != "") {
			this.category = category;
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

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		if (reg_date != null) {
			this.reg_date = reg_date;
		}
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		if (readcount >= 0)
			this.readcount = readcount;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		if (ref > 0) {
			this.ref = ref;
		}
	}

	public int getRe_step() {
		return re_step;
	}

	public void setRe_step(int re_step) {
		if (re_step > 0) {
			this.re_step = re_step;
		}
	}

	public int getRe_level() {
		return re_level;
	}

	public void setRe_level(int re_level) {
		if (re_level > 0) {
			this.re_level = re_level;
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

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		if (writer != null) {
			this.writer = writer;
		}
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		if (subject != null) {
			if (subject.length() >= 2 ) {
				this.subject = subject;
			}
		}
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		if (content != null && content.length() >= 10) {
			this.content = content;
		}
	}

}