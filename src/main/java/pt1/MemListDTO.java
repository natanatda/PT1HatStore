package pt1;

import java.sql.Timestamp;

public class MemListDTO {
   private String id;
   private String pw;
   private String name;
   private String tel;
   private String email;
   private String address;
   private Timestamp reg;
   private int active;
   
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getPw() {
      return pw;
   }
   public void setPw(String pw) {
      this.pw = pw;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getTel() {
      return tel;
   }
   public void setTel(String tel) {
      this.tel = tel;
   }
   public String getEmail() {
      return email;
   }
   public void setEmail(String email) {
      this.email = email;
   }
   public String getAddress() {
      return address;
   }
   public void setAddress(String address) {
      this.address = address;
   }
   public Timestamp getReg() {
	   return reg;
   }
   public void setReg(Timestamp reg) {
	   this.reg = reg;
   }
   public int getActive() {
	   return active;
   }
   public void setActive(int active) {
	   this.active = active;
   }
}