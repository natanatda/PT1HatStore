package pt1;
import java.sql.Timestamp;
public class NoticeDTO {
	private int num;
	private String writer;
	private String subject;
	private String category;
	private String content;
	private Timestamp reg;
	
	public void setNum(int num) {
		if(num != 0) {
			this.num=num;
		}
	}
	public void setWriter(String writer) {
		if(writer != null) {
			this.writer=writer;
		}
	}
	public void setSubject(String subject) {
		if(subject != null) {
			if(subject.length() >= 2) {
				this.subject=subject;
			}
		}
	}
	public void setCategory(String category) {
		if(category != null) {
			this.category=category;
		}
	}
	public void setContent(String content) {
		if(content != null) {
			if(content.length() >= 10) {
				this.content=content;
			}
		}
	}
	public void setReg(Timestamp reg) {
		this.reg=reg;
	}
	
	public int getNum() {
		return num;
	}
	public String getWriter() {
		return writer;
	}
	public String getSubject() {
		return subject;
	}
	public String getCategory() {
		return category;
	}
	public String getContent() {
		return content;
	}
	public Timestamp getReg() {
		return reg;
	}
	
}