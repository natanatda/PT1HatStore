package pt1;

public class LikeyDTO {
	String memberid;
	int replyNum;
	int product_num;
	
	public void setMemberid(String memberid) {
		if(memberid != null) {
			
			this.memberid = memberid;
		}
	}
	public void setReplyNum(int replyNum) {
		if(replyNum != 0) {
			
			this.replyNum = replyNum;
		}
	}
	public void setProduct_num(int product_num) {
		if(product_num != 0) {
			
			this.product_num = product_num;
		}
	}
	
	public String getMemberid() {
		return memberid;
	}
	public int getReplyNum() {
		return replyNum;
	}
	public int getProduct_num() {
		return product_num;
	}
	
	public LikeyDTO(String memberid,int replyNum,int product_num) {
		super();
		this.memberid = memberid;
		this.replyNum = replyNum;
		this.product_num = product_num;
	}
}

	
