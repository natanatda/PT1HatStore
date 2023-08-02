package pt1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class BrandDAO extends OracleServer{
	
	//싱글톤
	private static BrandDAO instance = new BrandDAO();
	public static BrandDAO getInstance() {
		return instance;
	}
	private BrandDAO() {}
	
	
	/* 관리자 메소드 */	
	//브랜드 정보 모두 불러오기
	public ArrayList<BrandDTO> getBrandList(int pageNum) {
		ArrayList<BrandDTO>brandList=new ArrayList<BrandDTO>();
		try {
			conn = getConnection();
			sql="SELECT r, store_id, brandno, brand, representative, bnumber, sectors, blocation, bfile,application_date, permit, active FROM (SELECT ROWNUM as r, store_id, brandno, brand, representative, bnumber, sectors, blocation, bfile,application_date, permit, active FROM (SELECT * FROM brand ORDER BY application_date DESC))" +
                 "WHERE r BETWEEN ? AND ?";
			int start = (pageNum - 1) * 50 + 1;
			int end = pageNum * 50;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()){
				//System.out.println(rs.getString("store_id"));
				BrandDTO brand= new BrandDTO();
				brand.setStore_id(rs.getString("store_id"));
				brand.setBrandNo(rs.getInt("brandNo"));
				brand.setBrand(rs.getString("brand"));
				brand.setRepresentative(rs.getString("representative"));
				brand.setBNumber(rs.getString("bNumber"));
				brand.setSectors(rs.getString("sectors"));
				brand.setBLocation(rs.getString("bLocation"));
				brand.setBFile(rs.getString("bFile"));
				brand.setApplication_date(rs.getTimestamp("application_date"));
				brand.setPermit(rs.getInt("permit"));
				brand.setActive(rs.getInt("active"));
				brandList.add(brand);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return brandList;
	}
		
	//브랜드 수 세기
	public int getBrandCount() {
		int count = 0;
		try {
			conn=getConnection();
			sql = "select count(*) from brand";
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
	

	//브랜드 활성화 조정
	public int activePro(int brandNo, int active) {
		int result=0;
			try {
				conn=getConnection();
				sql="select active from brand where brandno=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, brandNo);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					sql="update brand set active=? where brandno=?";
					pstmt = conn.prepareStatement(sql);
					if(active==1) { //활성화 여부 체크
						pstmt.setInt(1,0);
						pstmt.setInt(2, brandNo);
					}else if(active==0) {
						pstmt.setInt(1,1);
						pstmt.setInt(2, brandNo);
					}
					pstmt.executeUpdate();
					result=1;
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
		return result;
	}
	
	public int updateAllProActiveToZero(int brandNo, int active){
		int result=0;
	    try {
	        conn = getConnection();
	        sql="UPDATE product SET active = ? WHERE brandno = ? AND brandno IN (SELECT brandno FROM brand WHERE store_id IN (SELECT store_id FROM store WHERE active = 1))";
	        pstmt = conn.prepareStatement(sql);
	        if(active==1) {
	            pstmt.setInt(1, 0);
	            result=1;
	        }else if(active==0) {
	            pstmt.setInt(1, 1);
	            result=1;
	        }
	        pstmt.setInt(2, brandNo);
	        pstmt.executeUpdate();
	    }catch(Exception ex) {
	        ex.printStackTrace();
	    }finally { oracleClose(); }
	    return result;
	}
	
	
	//특정 브랜드 정보 불러오기
	public BrandDTO getBrand(int brandNo) {
		BrandDTO brand=null;
        try {
            conn = getConnection();
            sql="select * from brand where brandno=?";
            pstmt = conn.prepareStatement(sql); //id에 맞는 모든 값을 꺼내라
            pstmt.setInt(1, brandNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	brand = new BrandDTO();
            	brand.setStore_id(rs.getString("store_id"));
            	brand.setBrandNo(rs.getInt("brandNo"));
            	brand.setBrand(rs.getString("brand"));
            	brand.setRepresentative(rs.getString("representative"));
            	brand.setBNumber(rs.getString("bNumber"));
            	brand.setSectors(rs.getString("sectors"));
            	brand.setBLocation(rs.getString("bLocation"));
            	brand.setBFile(rs.getString("bFile"));
            	brand.setApplication_date(rs.getTimestamp("application_date"));     
            	brand.setPermit(rs.getInt("permit"));
            	brand.setActive(rs.getInt("active"));
			}
        } catch (Exception ex) {
			ex.printStackTrace();
		}finally {	oracleClose();	}
		return brand;
    }
	
	//브랜드 입점 수락
	public int permitBrand(int brandNo) {
		int result=0;
			try {
				conn=getConnection();
				sql="select permit, active from brand where brandno=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, brandNo);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					sql="update brand set permit=?, active=? where brandno=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, 1);
					pstmt.setInt(2, 1);
					pstmt.setInt(3, brandNo);
					pstmt.executeUpdate();
					result=1;
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
		return result;
	}
	
	//브랜드 정보 수정
	public int updateBrand(int brandNo) {
		int result=0;
			try {
				conn=getConnection();
				sql="select brand, representative, bnumber, sectors, blocation, bfile,application_date, permit, active from brand where brandno=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, brandNo);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					sql="update brand set permit=?, active=? where brandno=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, 1);
					pstmt.setInt(2, 1);
					pstmt.setInt(3, brandNo);
					
					pstmt.executeUpdate();
					result=1;
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
		return result;
	}
	
	
	/* 점주 메소드 */
	//브랜드 입점 신청
		public int applicationBrand(BrandDTO dto) {
			int result=0;
			try {
				conn = getConnection();
				sql = "insert into brand values (?,product_seq.nextval,?,?,?,?,?,?,?,?,?)"; //sql문장 작성
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getStore_id());
				pstmt.setString(2, dto.getBrand());
				pstmt.setString(3, dto.getRepresentative());
				pstmt.setString(4, dto.getBNumber());
				pstmt.setString(5, dto.getSectors());
				pstmt.setString(6, dto.getBLocation());
				pstmt.setString(7, dto.getBFile()); //사용자가 업로드한 이미지를 서버에 등록한 이름
				pstmt.setTimestamp(8, dto.getApplication_date());
				pstmt.setInt(9, dto.getPermit());
				pstmt.setInt(10, dto.getActive());
				pstmt.executeUpdate();
				result=1;
			}catch(Exception e) {
				e.printStackTrace();
			}finally { oracleClose();}
			return result;
		}
		
	//점주의 브랜드 정보 모두 불러오기
	public ArrayList<BrandDTO> getStoreBrandList(int pageNum, String stoId) {
		ArrayList<BrandDTO>brandList=new ArrayList<BrandDTO>();
		try {
			conn = getConnection();
			sql="SELECT r, store_id, brandno, brand, representative, bnumber, sectors, blocation, bfile,application_date, permit,active FROM (SELECT ROWNUM as r, store_id, brandno, brand, representative, bnumber, sectors, blocation, bfile,application_date, permit, active FROM (SELECT * FROM brand WHERE store_id=? ORDER BY application_date DESC))" +
                 "WHERE r BETWEEN ? AND ?";
			int start = (pageNum - 1) * 50 + 1;
			int end = pageNum * 50;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()){
				BrandDTO brand= new BrandDTO();
				brand.setStore_id(rs.getString("store_id"));
				brand.setBrandNo(rs.getInt("brandNo"));
				brand.setBrand(rs.getString("brand"));
				brand.setRepresentative(rs.getString("representative"));
				brand.setBNumber(rs.getString("bNumber"));
				brand.setSectors(rs.getString("sectors"));
				brand.setBLocation(rs.getString("bLocation"));
				brand.setBFile(rs.getString("bFile"));
				brand.setApplication_date(rs.getTimestamp("application_date"));
				brand.setPermit(rs.getInt("permit"));
				brand.setActive(rs.getInt("active"));
				brandList.add(brand);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return brandList;
	}
	
	//점주의 브랜드 수 세기
	public int getStoreBrandCount(String stoId) {
		int count = 0;
		try {
			conn=getConnection();
			sql = "select count(*) from brand where store_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally {	oracleClose();	}
		return count;
	}
	
	//점주의 모든 브랜드명 출력
	public ArrayList<BrandDTO> getStoreBrandNameList(String stoId) {
		ArrayList<BrandDTO>brandList=new ArrayList<BrandDTO>();
		try {
			conn = getConnection();
			sql="SELECT brandno,brand FROM brand WHERE store_id=? and permit=1 and active=1  ORDER BY brand";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			rs = pstmt.executeQuery();
			while(rs.next()){
				BrandDTO brand= new BrandDTO();
				brand.setBrandNo(rs.getInt("brandNo"));
				brand.setBrand(rs.getString("brand"));
				brandList.add(brand);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return brandList;
	}
	
	//점주의 브랜드번호에 맞는 브랜드명 출력
	public String getStoreBrandName(int brandNo) {
		String brandName=null;
		try {
			conn = getConnection();
			sql="SELECT brand FROM brand WHERE brandno=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brandNo);
			rs = pstmt.executeQuery();
			if(rs.next()){
				brandName=rs.getString("brand");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return brandName;
	}
	//점주 id를 매개변수로 대입해서 점주가 가지고 있는 브랜드번호, 브랜드명을 출력
	public ArrayList<BrandDTO> getBrandNo(String store_id){
		ArrayList<BrandDTO> list=new ArrayList<>();
		try {
			conn=getConnection();
			sql="select brandNo, brand from brand where store_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, store_id);
			rs=pstmt.executeQuery();
			while(rs.next()){
				BrandDTO dto=new BrandDTO();
				dto.setBrandNo(rs.getInt("brandNo"));
				dto.setBrand(rs.getString("brand"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return list;
	}
	//brandMain.jsp에서 사용 active 활성화된 브랜드를 브랜드 페이지에 나타냄
	public List brandList() {
		List brandList=null;
		try {
			conn=getConnection();
			sql="select * from brand where active=1";
			pstmt=conn.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				brandList=new ArrayList();
				do {
					BrandDTO brand=new BrandDTO();
					brand.setStore_id(rs.getString("store_id"));
					brand.setBrandNo(rs.getInt("brandNo"));
					brand.setBrand(rs.getString("brand"));
					brand.setRepresentative(rs.getString("representative"));
					brand.setBNumber(rs.getString("bNumber"));
					brand.setSectors(rs.getString("sectors"));
					brand.setBLocation(rs.getString("bLocation"));
					brand.setBFile(rs.getString("bFile"));
					brand.setApplication_date(rs.getTimestamp("application_date"));
					brand.setPermit(rs.getInt("permit"));
					brand.setActive(rs.getInt("active"));
					brandList.add(brand);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return brandList;
	}
}
