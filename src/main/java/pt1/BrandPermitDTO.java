package pt1;

import java.sql.Timestamp;

public class BrandPermitDTO {
	private String store_id;
    private int brandNo;
    private String brand;
    private String representative;
    private String bNumber;
    private String sectors;
    private String bLocation;
    private String bFile;
    private Timestamp application_date;
    private int permit;
    
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		this.store_id = store_id;
	}
	public int getBrandNo() {
		return brandNo;
	}
	public void setBrandNo(int brandNo) {
		this.brandNo = brandNo;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getRepresentative() {
		return representative;
	}
	public void setRepresentative(String representative) {
		this.representative = representative;
	}
	public String getbNumber() {
		return bNumber;
	}
	public void setbNumber(String bNumber) {
		this.bNumber = bNumber;
	}
	public String getSectors() {
		return sectors;
	}
	public void setSectors(String sectors) {
		this.sectors = sectors;
	}
	public String getbLocation() {
		return bLocation;
	}
	public void setbLocation(String bLocation) {
		this.bLocation = bLocation;
	}
	public String getbFile() {
		return bFile;
	}
	public void setbFile(String bFile) {
		this.bFile = bFile;
	}
	public Timestamp getApplication_date() {
		return application_date;
	}
	public void setApplication_date(Timestamp application_date) {
		this.application_date = application_date;
	}
	public int getPermit() {
		return permit;
	}
	public void setPermit(int permit) {
		this.permit = permit;
	}
}
