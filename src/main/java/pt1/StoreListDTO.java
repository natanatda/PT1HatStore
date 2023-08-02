package pt1;

public class StoreListDTO {
	private String store_id;
	private String store_pw;
	private String store_name;
	private String store_tel;
	private String store_email;
	private int active;
	
	
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public String getStore_pw() {
		return store_pw;
	}
	public void setStore_pw(String store_pw) {
		this.store_pw = store_pw;
	}
	public String getStore_name() {
		return store_name;
	}
	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}
	public String getStore_tel() {
		return store_tel;
	}
	public void setStore_tel(String store_tel) {
		this.store_tel = store_tel;
	}
	public String getStore_email() {
		return store_email;
	}
	public void setStore_email(String store_email) {
		this.store_email = store_email;
	}
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
	}
 
}
