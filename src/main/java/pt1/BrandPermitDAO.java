package pt1;

public class BrandPermitDAO extends OracleServer{
	private static BrandPermitDAO instance = new BrandPermitDAO();
	public static BrandPermitDAO getInstance() {
		return instance;
	}
	private BrandPermitDAO() {}

	//브랜드 수정 신청
	public int applicationBrand(BrandPermitDTO dto) {
		int result=0;
		try {
			conn = getConnection();
			sql = "insert into brandpermit values (?,?,?,?,?,?,?,?,?,?)"; //sql문장 작성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getStore_id());
			pstmt.setInt(2, dto.getBrandNo());
			pstmt.setString(3, dto.getBrand());
			pstmt.setString(4, dto.getRepresentative());
			pstmt.setString(5, dto.getbNumber());
			pstmt.setString(6, dto.getSectors());
			pstmt.setString(7, dto.getbLocation());
			pstmt.setString(8, dto.getbFile()); //사용자가 업로드한 이미지를 서버에 등록한 이름
			pstmt.setTimestamp(9, dto.getApplication_date());
			pstmt.setInt(10, dto.getPermit());
			pstmt.executeUpdate();
			result=1;
		}catch(Exception e) {
			e.printStackTrace();
		}finally { oracleClose();}
		return result;
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
	
	//브랜드 수정 수락
	public int permitBrandModify(int brandNo) {
		int result=0;
			try {
				conn=getConnection();
				sql="select permit from brand where brandno=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, brandNo);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					sql="update brand set permit=? where brandno=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, 1);
					pstmt.setInt(2, brandNo);
					pstmt.executeUpdate();
					result=1;
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
		return result;
	}
	
	//브랜드 수정
	public int updateBrand(BrandDTO dto) {
		int result=0;
			try {
				conn=getConnection();
				sql="UPDATE brand SET store_id=?, brandno=?, brand=?, representative=?, bnumber=?, sectors=?, blocation=?, bfile=?,application_date=? WHERE brandno=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getStore_id());
				pstmt.setInt(2, dto.getBrandNo());
				pstmt.setString(3, dto.getBrand());
				pstmt.setString(4, dto.getRepresentative());
				pstmt.setString(5, dto.getBNumber());
				pstmt.setString(6, dto.getSectors());
				pstmt.setString(7, dto.getBLocation());
				pstmt.setString(8, dto.getBFile());
				pstmt.setTimestamp(9, dto.getApplication_date());
				pstmt.setInt(10, dto.getBrandNo());
				pstmt.executeUpdate();
				result=1;
				if(result ==1) {
					sql="UPDATE product SET brand = ? WHERE brandno = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dto.getBrand());
					pstmt.setInt(2, dto.getBrandNo());
					pstmt.executeUpdate();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
		return result;
	}
	
	//브랜드 수정 정보 삭제
	public int deleteBrandModify(int brandNo) {
		int result=0;
			try {
				conn=getConnection();
				sql="delete from brandpermit where brandno=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, brandNo);
				pstmt.executeUpdate();
				result=1;
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
		return result;
		}
	
	//특정 브랜드 정보 불러오기
	public BrandPermitDTO getBrand(int brandNo) {
		BrandPermitDTO brand=null;
        try {
            conn = getConnection();
            sql="select * from brandpermit where brandno=?";
            pstmt = conn.prepareStatement(sql); //id에 맞는 모든 값을 꺼내라
            pstmt.setInt(1, brandNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	brand = new BrandPermitDTO();
            	brand.setStore_id(rs.getString("store_id"));
            	brand.setBrandNo(rs.getInt("brandNo"));
            	brand.setBrand(rs.getString("brand"));
            	brand.setRepresentative(rs.getString("representative"));
            	brand.setbNumber(rs.getString("bNumber"));
            	brand.setSectors(rs.getString("sectors"));
            	brand.setbLocation(rs.getString("bLocation"));
            	brand.setbFile(rs.getString("bFile"));
            	brand.setApplication_date(rs.getTimestamp("application_date"));     
            	brand.setPermit(rs.getInt("permit"));
			}
        } catch (Exception ex) {
			ex.printStackTrace();
		}finally {	oracleClose();	}
		return brand;
    }
    
}
