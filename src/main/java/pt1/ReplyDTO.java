package pt1;

import java.sql.Timestamp;

public class ReplyDTO {
	private int replyNum;
	private int productNum;
	private String memberId;
	private Timestamp regDate;
	private String subject;
	private String content;
	private double rating;
	private String rimg;
	private int ref;
	private int re_step;	
	private int re_level;
	private int recommend;
	
	public int getReplyNum() {
		return replyNum;
	}
	public int getProductNum() {
		return productNum;
	}
	public String getMemberId() {
		return memberId;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public String getSubject() {
		return subject;
	}
	public String getContent() {
		return content;
	}
	public double getRating() {
		return rating;
	}
	public String getRimg() {
		return rimg;
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
	public int getRecommend() {
		return recommend;
	}
	
	
	public void setReplyNum(int replyNum) {
		if(replyNum != 0) {
			this.replyNum = replyNum;
		}
	}
	public void setProductNum(int productNum) {
		if(productNum != 0) {
			this.productNum = productNum;
		}
	}
	public void setMemberId(String memberId) {
		if(memberId != null) {
			this.memberId = memberId;
		}
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public void setSubject(String subject) {
				this.subject = subject;
	}
	public void setContent(String content) {
		if(content != null) {
			if(content.length() >= 10) {
				this.content = content;
			}
		}
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public void setRimg(String rimg) {
		this.rimg = rimg;
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
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	
}
