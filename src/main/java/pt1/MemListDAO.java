package pt1;

import java.util.ArrayList;
import java.util.List;

public class MemListDAO extends OracleServer{
	//싱글톤
	private static MemListDAO instance = new MemListDAO();
	public static MemListDAO getInstance() {
		return instance;
	}
	private MemListDAO() {}
	
	
	//노출 개수에 맞춰 글 정보 불러오기
	public ArrayList<MemListDTO> getMemList(int pageNum) {
		ArrayList<MemListDTO>memList=new ArrayList<MemListDTO>();
		try {
			conn = getConnection();
			sql="SELECT r, id, pw, name, tel, email, address, reg, active FROM (SELECT ROWNUM as r, id, pw, name, tel, email, address, reg, active FROM (SELECT * FROM member ORDER BY id))" +
                 "WHERE r BETWEEN ? AND ?";
			int start = (pageNum - 1) * 50 + 1;
			int end = pageNum * 50;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MemListDTO member= new MemListDTO(); //반복횟수만큼 DTO 객체 생성
				member.setId(rs.getString("id"));
	            member.setPw(rs.getString("pw"));
	            member.setName(rs.getString("name"));
	            member.setTel(rs.getString("tel"));
	            member.setEmail(rs.getString("email"));
	            member.setAddress(rs.getString("address"));
	            member.setReg(rs.getTimestamp("reg"));
	            member.setActive(rs.getInt("active"));
	            memList.add(member); //list에 모든 DTO 객체 추가
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return memList;
	}
	
	//멤버수 세기
	public int getMemCount() {
		int count = 0;
		try {
			conn=getConnection();
			sql = "select count(*) from member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {	oracleClose();	}
		return count;
	}
	
	//일반회원 계정 삭제하기
	/*
	public int deleteMem(String memId) {
		int result=0;
			try {
				conn=getConnection();
				sql="delete from member where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, memId);
				pstmt.executeUpdate();
				result=1;
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
		return result;
	}*/
	
	//일반회원 활성화 조정
	public int activeMem(String memId, int active) {
		int result=0;
			try {
				conn=getConnection();
				sql="select active from member where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, memId);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					sql="update member set active=? where id=?";
					pstmt = conn.prepareStatement(sql);
					if(active==1) { //활성화 여부 체크
						pstmt.setInt(1,0);
						pstmt.setString(2, memId);
					}else if(active==0) {
						pstmt.setInt(1,1);
						pstmt.setString(2, memId);
					}
					pstmt.executeUpdate();
					result=1;
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
		return result;
	}
}