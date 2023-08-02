package test.web.model;

import java.util.ArrayList;

public class MemberBean {
   public boolean result = false; //결과저장할 변수먼저 정하기
   public ArrayList <Integer> number = null;   //숫자
   public ArrayList <Integer> upStr = null;   //대문자
   public ArrayList <Integer> lowStr = null;   //소문자
   
   public MemberBean() {   //생성자에서 생성-이때 public써야 다른데서도 사용가능.
      number = new ArrayList<>();
      upStr = new ArrayList<>();
      lowStr = new ArrayList<>();
      for(int i=48; i <=57; i++){
         number.add(i);
      }
      for(int i=65; i <=90; i++){
         upStr.add(i);
      }
      for(int i=97; i <=122; i++){
         lowStr.add(i);
      }
   }
   // 문자열의 길이가 min, max의 범위안에 있는지 판단.
   public boolean lengthCheck(String id , int min, int max) {
      if(id != null) {
         int length = id.length();   //length() 문자열의 길이 
         if(min <= length && max >= length) {
            result = true;
         }
      }
      return result;
   }
   // 문자열의 첫글자가 숫자인지 판단하는 매서드.
   public boolean firstChar(String id) {
      if(id != null) {
         int c = (int)id.charAt(0);   //charAt(0) 문자열의 첫번째 글자
         if(number.contains(c)) {
            result = true;
         }
      }
      return result;
   }
   // 문자열에 특수문자 포함되어있는지 판단.
   public boolean speStr(String id) {
      if(id != null) {
         int len = id.length();
         int c;
         for(int i = 0 ; i < len ; i++) {
            c = (int)id.charAt(i);
            if(number.contains(c) || upStr.contains(c) || lowStr.contains(c)) {
               result = false;
            }else {
               result = true;   //특수문자면 true
               break;
            }
         }
      }
      return result;
   }
   
	public boolean Em(String email) {
		if (email != null) {
			for (int i = 0; i < email.length(); i++) {
				if (email.charAt(i) == '@') {
					result = true;
					break;
				}
				result = false;
			}
		}
	return result;
	}
   
	public boolean Tel(String tel) {
		if (tel != null) {
			for (int i = 0; i < tel.length(); i++) {
				if (tel.charAt(i) == '-') {
					result = false;
					break;
				}
				result = true;
			}
		}
	   
	   
	   return result;
   }
   
   public boolean firstString(String id) {
	      if(id != null) {
	         String c = id;
	         if(c.contains("admin")) {
	            result = true;
	         }
	      }
	      return result;
	   }
   
}