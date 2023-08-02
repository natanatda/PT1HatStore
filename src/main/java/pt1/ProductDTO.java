package pt1;
import java.sql.Timestamp;
import java.util.Date;

public class ProductDTO {
	    private String category;
	    private int pnum;
	    private String color;
	    private String pname;	    
	    private int brandNo;
	    private String brand;
	    private String psize;
	    private int stock;
	    private double price;
	    private Timestamp reg;
	    private int readnum;
	    private String pdetail;
	    private int onsale;
	    private String pimg;
	    private int active;

	    public int getActive() {
			return active;
		}

		public void setActive(int active) {
			this.active = active;
		}

		public String getCategory() {
	        return category;
	    }

	    public void setCategory(String category) {
	    	if(category!=null || category != "") {
	    		this.category = category;
	    	}
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
	    	if(color!=null || color != "") {
	    		this.color = color;
		    }
	    }

	    public String getPname() {
	        return pname;
	    }

	    public void setPname(String pname) {
	    	if(pname!=null || pname != "") {
	    		this.pname = pname;
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
	    	if(brand!=null || brand != "") {
	    		this.brand = brand;
	    	}
	    }

	    public String getPsize() {
	        return psize;
	    }

	    public void setPsize(String psize) {
	    	if(brand !=null || brand!="") {
	    		this.psize = psize;
	    	}
	    }

	    public int getStock() {
	        return stock;
	    }

	    public void setStock(int stock) {
	    	if(stock >0) {
	    		this.stock = stock;
	    	}
	    }

	    public double getPrice() {
    		return price;
	    }

	    public void setPrice(double price) {
	    	if(price >0) {
	    		this.price = price;
	    	}
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
	    	if(pimg!=null || pimg!="") {
	    		this.pimg = pimg;
	    	}
	    }
}
