package pt1;

import java.sql.Timestamp;

public class DeliveryDTO {
	private int delivery_id;		//pk 시퀀스로 100에서 증가하도록 설정
	private String id;
	private String pname;
	private int brandno;			//브랜드no (product테이블의 brandno)
	private String recipient_name;	//수령인 이름
	private String address;			//주소
	private Timestamp created_at;	//송장 입력 날짜
	private String status;				//배송상태 (배송준비 1) (배송중 2) (배송완료 3)
	private Timestamp end_at;
	private String tel;

	//SET 메소드
	public void setDelivery_id(int delivery_id) {
		this.delivery_id=delivery_id;
	}
	public void setId(String id) {
		this.id=id;
	}
	public void setPname(String pname) {
		this.pname=pname;
	}
	public void setBrandno(int brandno) {
		this.brandno=brandno;
	}
	public void setRecipient_name(String recipient_name) {
		this.recipient_name=recipient_name;
	}
	public void setAddress(String address) {
		this.address=address;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at=created_at;
	}
	public void setStatus(String status) {
		this.status=status;
	}
	public void setEnd_at(Timestamp end_at) {
		this.end_at=end_at;
	}
	public void setTel(String tel) {
		this.tel=tel;
	}
	//GET 메소드
	public int  getDelivery_id() {
		return delivery_id;
	}
	public String getId() {
		return id;
	}
	public String getPname() {
		return pname;
	}
	public int getBrandno() {
		return brandno;
	}
	public String getRecipient_name() {
		return recipient_name;
	}
	public String getAddress() {
		return address;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public String getStatus() {
		return status;
	}
	public Timestamp getEnd_at() {
		return end_at;
	}
	public String getTel() {
		return tel;
	}
}
