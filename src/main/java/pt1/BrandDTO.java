package pt1;

import java.sql.Timestamp;

public class BrandDTO{
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
    private int active;
    
    
	public String getStore_id() {
		return store_id;
	}
	public void setStore_id(String store_id) {
		if(store_id!=null || store_id != "") {
			this.store_id = store_id;
		}
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
		if(brand !=null || brand!="") {
			this.brand = brand;
		}
	}
	public String getRepresentative() {
		return representative;
	}
	public void setRepresentative(String representative) {
		if(representative!=null || representative!="") {
			this.representative = representative;
		}
	}
	public String getBNumber() {
		return bNumber;
	}
	public void setBNumber(String bNumber) {
		if(bNumber!=null || bNumber!="") {
			this.bNumber = bNumber;
		}
	}
	public String getSectors() {
		return sectors;
	}
	public void setSectors(String sectors) {
		if(sectors!=null || sectors!="") {
			this.sectors = sectors;
		}
	}
	public String getBLocation() {
			return bLocation;
	}
	public void setBLocation(String bLocation) {
		if(bLocation!=null || bLocation!="") {
			this.bLocation = bLocation;
		}
	}
	public String getBFile() {
		return bFile;
	}
	public void setBFile(String bFile) {
		if(bFile!=null || bFile!="") {
			this.bFile = bFile;
		}
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
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
	}
}
