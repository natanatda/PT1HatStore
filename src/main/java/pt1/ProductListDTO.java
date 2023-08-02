package pt1;

import java.sql.Timestamp;

public class ProductListDTO {
private String category;
private int pnum;
private String color;
private String pname;
private String brand;
private String psize;
private int stock;
private int price;
private Timestamp reg;
private int readnum;
private String pdetail;
private int onsale;
private String pimg;
private int active;
private int brandno;

// getter/setter 메소드
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getPnum() {
        return pnum;
    }

    public void setPnum(int pnum) {
        this.pnum = pnum;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getPsize() {
        return psize;
    }

    public void setPsize(String psize) {
        this.psize = psize;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public Timestamp getReg() {
        return reg;
    }

    public void setReg(Timestamp reg) {
        this.reg = reg;
    }

    public int getReadnum() {
        return readnum;
    }

    public void setReadnum(int readnum) {
        this.readnum = readnum;
    }

    public String getPdetail() {
        return pdetail;
    }

    public void setPdetail(String pdetail) {
        this.pdetail = pdetail;
    }

    public int getOnsale() {
        return onsale;
    }

    public void setOnsale(int onsale) {
        this.onsale = onsale;
    }

    public String getPimg() {
        return pimg;
    }

    public void setPimg(String pimg) {
        this.pimg = pimg;
    }
    
    public int getBrandNo() {
    	return brandno;
    }
    
    public void setBrandNo(int brandno) {
    	this.brandno = brandno;
    }
    
    public int getActive() {
    	return active;
    }
    
    public void setActive(int active) {
    	this.active = active;
    }
}