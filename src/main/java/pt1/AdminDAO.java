package pt1;


import java.sql.*;
import javax.sql.*;

import pt1.AdminDTO;

import javax.naming.*;


public class AdminDAO extends OracleServer{
	    
	 	private static AdminDAO instance = new AdminDAO();
	    
	    public static AdminDAO getInstance() {return instance; }  //자기자신을 리턴값으로 가지고있는 메서드 ...객체를 리턴하고있음 
	    
	    private AdminDAO() {}  // 생성자 
	 
	    public void insertAdmin (AdminDTO admin)   // admin 계정 추가 메서드 
	    throws Exception {
	        
	        try {
	            conn = getConnection();
	            
	            pstmt = conn.prepareStatement(
	            	"insert into Admin values (?,?)");
	            pstmt.setString(1, admin.getId());
	            pstmt.setString(2, admin.getPw());
	            

	            pstmt.executeUpdate();  //1행이 추가~ 막 이런 리턴 안받았음
	        } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            oracleClose();
	        }
	    }



//admin 계정 체크
   public int adminCheck(String id, String pw)   //리턴타입 int임 
         throws Exception {
      String dbpasswd="";
      int x=-1;

      try {
         conn = getConnection();

         pstmt = conn.prepareStatement(
               "select pw from ADMIN where id = ?");
         pstmt.setString(1,id); 
         rs= pstmt.executeQuery();

         if(rs.next()){ 
            dbpasswd= rs.getString("pw");
            if(dbpasswd.equals(pw))
               x= 1; //아이디 비번 모두 맞음
            else
               x= 0; //비번 틀림
         }else  //펄스면 이거 실행. (아이디 잘못 입력했을때-아이디 틀림) 
            x= -1;

      } catch(Exception ex) {
         ex.printStackTrace();
      } finally {
    	  oracleClose();
      }
      return x;
   }
   
   public AdminDTO getAdmin(String id)  // admin 계정 정보 조회
		    throws Exception {
		        AdminDTO admin=null;
		        try {
		            conn = getConnection();
		            
		            pstmt = conn.prepareStatement(
		            	"select * from ADMIN where id = ?");
		            pstmt.setString(1, id);
		            rs = pstmt.executeQuery();

		            if (rs.next()) {
		                admin = new AdminDTO();          //DTO에 다 보냄.
		                admin.setId(rs.getString("id"));
		                admin.setPw(rs.getString("pw"));
				
					}

		        } catch(Exception ex) {
		            ex.printStackTrace();
		        } finally {
		        	oracleClose();
		        }
				return admin;  //DTO 리턴받음
		    }
   
   public void updateAdmin(AdminDTO admin)  // admin 계정 정보 업데이트 
		    throws Exception {
		        
		        try {
		            conn = getConnection();
		            
		            pstmt = conn.prepareStatement(
		              "update ADMIN set pw=? where id=?");
		            pstmt.setString(1, admin.getPw());
		            pstmt.setString(2, admin.getId());
		            
		            pstmt.executeUpdate();
		        } catch(Exception ex) {
		            ex.printStackTrace();
		        } finally {
		        	oracleClose();
		        }
		    }
   
   //관리자 비밀번호 찾기
   public String pwFind(String id) {  // 주어진 MemberDTO 객체의 정보(id, email, tel)를 이용해 DB에서 해당 사용자의 비밀번호(pw)를 조회하는 메서드
		String result = null;
		try {
			conn = getConnection();
			String sql = "SELECT pw FROM admin WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("pw");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}
}