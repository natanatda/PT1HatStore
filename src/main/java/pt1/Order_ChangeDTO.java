package pt1;

public class Order_ChangeDTO {
	private int c_num;
	private String content;

	public int getC_num() {
		return c_num;
	}

	public void setC_num(int c_num) {
		if (c_num > 0) {
			this.c_num = c_num;
		}
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		if (content != null) {
			this.content = content;
		}
	}
}
