package pt1;


public class MemberDTO {
	private String id;
	private String pw;
	private String name;
	private String tel;
	private String pw2;
	private String birth;
	private String email;
	private String address;
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
	public String getPw2() {
		return pw2;
	}
	public void setPw2(String pw2) {
		this.pw2 = pw2;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
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
	
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
	}

}



/*  유효성 검사


public void setTel(String tel) {
if(!tel.contains("-")) {
	this.tel=tel;
	}
}

public void setId(String pw) {
if(pw.length()==8) {
	this.id=id;
}
}
public void setBirth(String birth) {
if(birth.length()==6) {
	this.birth=birth;
}
}

	public void setEmail(String email) {
		for(int i=0;i<email.length();i++) {
			if(email.charAt(i)=='@') {
		       this.email=email;
		       break;
			}
		  }
		}

*/