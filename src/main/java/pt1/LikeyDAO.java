package pt1;

import java.util.concurrent.ExecutionException;

public class LikeyDAO extends OracleServer{
	private static LikeyDAO instance = new LikeyDAO();
	public static LikeyDAO getInstance() {return instance;}
	private LikeyDAO(){}
	
	// 리뷰 추천하기
	public int like(String memberid,int replyNum,int product_num) {
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into likey values(?,?,?)");
			pstmt.setString(1, memberid);
			pstmt.setInt(2, replyNum);
			pstmt.setInt(3, product_num);
			pstmt.executeUpdate();
			result=1;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return result;
	}
	
	//추천한 글 있는지(result가 1개 이상이면 추천한적 있음)
	public int checkLike(String memberid,int replyNum, int product_num){	
		int count=0;
		int like=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from likey where  memberid=? and replyNum=? and product_num=?");	//
			pstmt.setString(1, memberid);
			pstmt.setInt(2, replyNum);
			pstmt.setInt(3, product_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				like= rs.getInt(1); 
				if(like==1) {
					count=1;
				}else if(like==0) {
					count=0;
				}
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return count; 
	}
	//	db에서 추천 정보 삭제
	public int deleteLike(int replyNum, String memberid){	
		int x=0;
		try {
			conn = getConnection();
			sql="delete from likey where replyNum=? and memberid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyNum);
			pstmt.setString(2, memberid);
			pstmt.executeUpdate();
			x=1;
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x; 
	}
}
