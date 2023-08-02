package pt1;

import java.util.ArrayList;

public class StoreListDAO extends OracleServer{

	//싱글톤
	private static StoreListDAO instance = new StoreListDAO();
	public static StoreListDAO getInstance() {
		return instance;
	}
	private StoreListDAO() {}
	
	//스토어 리스트 불러오기
	public ArrayList<StoreListDTO> getStoreList(int pageNum) {
		ArrayList<StoreListDTO>storeList=new ArrayList<StoreListDTO>();
		try {
			conn = getConnection();
			sql="SELECT r, store_id, store_name, store_tel, store_email, active FROM (SELECT ROWNUM as r, store_id, store_name, store_tel, store_email, active FROM (SELECT * FROM store))" +
                 "WHERE r BETWEEN ? AND ?";
			int start = (pageNum - 1) * 50 + 1;
			int end = pageNum * 50;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()){
				StoreListDTO store= new StoreListDTO(); //반복횟수만큼 DTO 객체 생성
				store.setStore_id(rs.getString("store_id"));
				store.setStore_name(rs.getString("store_name"));
				store.setStore_tel(rs.getString("store_tel"));
				store.setStore_email(rs.getString("store_email"));
				store.setActive(rs.getInt("active"));
				storeList.add(store); //list에 모든 DTO 객체 추가
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return storeList;
	}
	
	
	//점주 수 세기
	public int getStoreCount() {
		int count = 0;
		try {
			conn=getConnection();
			sql = "select count(*) from store";
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
	
	
	//점주 활성화 조정
	public int activePro(String store_id, int active) {
		int result=0;
			try {
				conn=getConnection();
				sql="select active from store where store_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, store_id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					sql="update store set active=? where store_id=?";
		            pstmt = conn.prepareStatement(sql);
		            if(active==1) { //활성화 여부 체크
		                pstmt.setInt(1,0);
		                pstmt.setString(2, store_id);
		            }else if(active==0) {
		                pstmt.setInt(1,1);
		                pstmt.setString(2, store_id);
		            }
		            pstmt.executeUpdate();
		            sql="update brand set active=? where store_id=?";
		            pstmt=conn.prepareStatement(sql);
		            if(active==1) { //활성화 여부 체크
		                pstmt.setInt(1,0);
		                pstmt.setString(2, store_id);
		            }else if(active==0) {
		                pstmt.setInt(1,1);
		                pstmt.setString(2, store_id);
		            }
		            pstmt.executeUpdate();
		            result=1;
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
		return result;
	}
	
	public int updateAllProActiveToZero(String stoId, int active){
		int result=0;
	    try {
	        conn = getConnection();
	        sql="UPDATE product SET active = ? WHERE brandno IN (SELECT brandno FROM brand WHERE store_id = ? and active=1)";
	        pstmt = conn.prepareStatement(sql);
	        if(active==1) {
	            pstmt.setInt(1, 0);
	            result=1;
	        }else if(active==0) {
	            pstmt.setInt(1, 1);
	            result=1;
	        }
	        pstmt.setString(2, stoId);
	        pstmt.executeUpdate();
	    }catch(Exception ex) {
	        ex.printStackTrace();
	    }finally { oracleClose(); }
	    return result;
	}
	
}

