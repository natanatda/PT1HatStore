package pt1;

import java.sql.Timestamp;

public class Admin_MessageDTO {
	int message_num;
	String writer;
	String store_id;
	int brandno;
	String brandname;
	String subject;
	String content;
	Timestamp regDate;
	String mimg;
	int status;
	int ref;
	int re_step;
	int re_level;
	
	public void setMessage_num(int message_num) {
		this.message_num = message_num;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public void setBrandno(int brandno) {
		if(brandno != 0) {
			this.brandno = brandno;
		}
	}
	public void setBrandname(String brandname) {
		this.brandname = brandname;
	}
	public void setSubject(String subject) {
		if(subject != null) {
			this.subject = subject;
		}
	}
	public void setContent(String content) {
		if(content != null) {
			this.content = content;
		}
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public void setMimg(String mimg) {
		this.mimg = mimg;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	
	
	
	public int getMessage_num() {
		return message_num;
	}
	public String getWriter() {
		return writer;
	}
	public String getStore_id() {
		return store_id;
	}
	public int getBrandno() {
		return brandno;
	}
	public String getBrandname() {
		return brandname;
	}
	public String getSubject() {
		return subject;
	}
	public String getContent() {
		return content;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public String getMimg(){
		return mimg;
	}
	public int getStatus() {
		return status;
	}
	public int getRef() {
		return ref;
	}
	public int getRe_step() {
		return re_step;
	}
	public int getRe_level() {
		return re_level;
	}
}
