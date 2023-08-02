package pt1;
import java.util.ArrayList;
import java.util.List;

public class ProductListDAO extends OracleServer{

		//싱글톤
		private static ProductListDAO instance = new ProductListDAO();
		public static ProductListDAO getInstance() {
			return instance;
		}
		private ProductListDAO() {}
		
		
		//노출 개수에 맞춰 상품 정보 불러오기
		public ArrayList<ProductListDTO> getProList(int pageNum) {
			ArrayList<ProductListDTO>proList=new ArrayList<ProductListDTO>();
			try {
				conn = getConnection();
				sql="SELECT r, category, pnum, color, pname, brand, psize, stock, price,reg, readnum, onsale, active FROM (SELECT ROWNUM as r, category, pnum, color, pname, brand, psize, stock, price, reg, readnum, onsale, active FROM (SELECT * FROM product ORDER BY reg DESC))" +
	                 "WHERE r BETWEEN ? AND ?";
				int start = (pageNum - 1) * 50 + 1;
				int end = pageNum * 50;
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				while(rs.next()){
					ProductListDTO product= new ProductListDTO(); //반복횟수만큼 DTO 객체 생성
					product.setCategory(rs.getString("category"));
					product.setPnum(rs.getInt("pnum"));
					product.setColor(rs.getString("color"));
					product.setPname(rs.getString("pname"));
					product.setBrand(rs.getString("brand"));
					product.setPsize(rs.getString("psize"));
					product.setStock(rs.getInt("stock"));
					product.setPrice(rs.getInt("price"));
					product.setReg(rs.getTimestamp("reg"));
					product.setReadnum(rs.getInt("readnum"));
					product.setOnsale(rs.getInt("onsale"));
					product.setActive(rs.getInt("active"));
		            proList.add(product); //list에 모든 DTO 객체 추가
				}
			}catch(Exception ex) {
				ex.printStackTrace();
			}finally { oracleClose(); }
			return proList;
		}
		
		//상품 수 세기
		public int getProCount() {
			int count = 0;
			try {
				conn=getConnection();
				sql = "select count(*) from product";
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
		
		//상품 삭제
		/*
		public int deletePro(String pnum) {
			int result=0;
				try {
					conn=getConnection();
					sql="delete from product where pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, pnum);
					pstmt.executeUpdate();
					result=1;
				} catch (Exception ex) {
					ex.printStackTrace();
				}finally {	oracleClose();	}
			return result;
		}*/
		
		//상품 활성화 조정
		public int activePro(int pnum, int active) {
			int result=0;
				try {
					conn=getConnection();
					sql="select active from product where pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						sql="update product set active=? where pnum=?";
						pstmt = conn.prepareStatement(sql);
						if(active==1) { //활성화 여부 체크
							pstmt.setInt(1,0);
							pstmt.setInt(2, pnum);
						}else if(active==0) {
							pstmt.setInt(1,1);
							pstmt.setInt(2, pnum);
						}
						pstmt.executeUpdate();
						result=1;
					}
				} catch (Exception ex) {
					ex.printStackTrace();
				}finally {	oracleClose();	}
			return result;
		}
		
		//상품 판매 조정
		public int productOnsale(int pnum, int onsale) {
			int result=0;
				try {
					conn=getConnection();
					sql="select pnum from product where pnum=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pnum);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						sql="update product set onsale=? where pnum=?";
						pstmt = conn.prepareStatement(sql);
						if(onsale==1) { //활성화 여부 체크
							pstmt.setInt(1,0);
							pstmt.setInt(2, pnum);
						}else if(onsale==0) {
							pstmt.setInt(1,1);
							pstmt.setInt(2, pnum);
						}
						pstmt.executeUpdate();
						result=1;
					}
				} catch (Exception ex) {
					ex.printStackTrace();
				}finally {	oracleClose();	}
			return result;
		}
		
		//특정 브랜드 찾기
		public ArrayList<ProductListDTO> getBrandList(String stoId) {
			ArrayList<ProductListDTO>brandList=new ArrayList<ProductListDTO>();
			try {
				conn = getConnection();
				sql="SELECT DISTINCT brand FROM product WHERE brandno IN "
	                     + "(SELECT brandno FROM brand WHERE store_id = ?)ORDER BY brand";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, stoId);
				rs = pstmt.executeQuery();
				while(rs.next()){
					ProductListDTO product= new ProductListDTO(); //반복횟수만큼 DTO 객체 생성
					product.setBrand(rs.getString("brand"));
		            brandList.add(product); //list에 모든 DTO 객체 추가
				}
			}catch(Exception ex) {
				ex.printStackTrace();
			}finally { oracleClose(); }
			return brandList;
		}
		
		
		//특정 점주의 모든 상품
		public ArrayList<ProductListDTO> getProList(int pageNum, String stoId) {
			ArrayList<ProductListDTO>proList=new ArrayList<ProductListDTO>();
			try {
				conn = getConnection();
				sql="SELECT r, category, pnum, color, pname, brand, psize, stock, price,reg, readnum, onsale, active FROM"
						+ "(SELECT ROWNUM as r, category, pnum, color, pname, brand, psize, stock, price, reg, readnum, onsale, active FROM product WHERE brandno IN "
	                     + "(SELECT brandno FROM brand WHERE store_id = ?)ORDER BY reg DESC)"
	                     + "WHERE r BETWEEN ? AND ?";
				int start = (pageNum - 1) * 50 + 1;
				int end = pageNum * 50;				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, stoId);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				while(rs.next()){
					ProductListDTO product= new ProductListDTO(); //반복횟수만큼 DTO 객체 생성
					product.setCategory(rs.getString("category"));
					product.setPnum(rs.getInt("pnum"));
					product.setColor(rs.getString("color"));
					product.setPname(rs.getString("pname"));
					product.setBrand(rs.getString("brand"));
					product.setPsize(rs.getString("psize"));
					product.setStock(rs.getInt("stock"));
					product.setPrice(rs.getInt("price"));
					product.setReg(rs.getTimestamp("reg"));
					product.setReadnum(rs.getInt("readnum"));
					//product.setPdetail(rs.getString("pdetail"));
					product.setOnsale(rs.getInt("onsale"));
					//product.setPimg(rs.getString("pimg"));
					//product.setBrandNo(rs.getInt("brandno"));
					product.setActive(rs.getInt("active"));
		            proList.add(product); //list에 모든 DTO 객체 추가
				}
			}catch(Exception ex) {
				ex.printStackTrace();
			}finally { oracleClose(); }
			return proList;
		}
		
		//특정 점주의 특정 브랜드 총 상품
		public ArrayList<ProductListDTO> getProListByBrand(int pageNum, String stoId, String selectedBrand) {
			ArrayList<ProductListDTO>proList=new ArrayList<ProductListDTO>();
			try {
				conn = getConnection();
				sql="SELECT r, category, pnum, color, pname, brand, psize, stock, price,reg, readnum, onsale, active FROM"
						+ "(SELECT ROWNUM as r, category, pnum, color, pname, brand, psize, stock, price, reg, readnum, onsale, active FROM product WHERE brandno IN "
	                     + "(SELECT brandno FROM brand WHERE store_id = ? and brand=?)ORDER BY reg DESC)"
	                     + "WHERE r BETWEEN ? AND ?";
				int start = (pageNum - 1) * 50 + 1;
				int end = pageNum * 50;				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, stoId);
				pstmt.setString(2, selectedBrand);
				pstmt.setInt(3, start);
				pstmt.setInt(4, end);
				rs = pstmt.executeQuery();
				while(rs.next()){
					ProductListDTO product= new ProductListDTO(); //반복횟수만큼 DTO 객체 생성
					product.setCategory(rs.getString("category"));
					product.setPnum(rs.getInt("pnum"));
					product.setColor(rs.getString("color"));
					product.setPname(rs.getString("pname"));
					product.setBrand(rs.getString("brand"));
					product.setPsize(rs.getString("psize"));
					product.setStock(rs.getInt("stock"));
					product.setPrice(rs.getInt("price"));
					product.setReg(rs.getTimestamp("reg"));
					product.setReadnum(rs.getInt("readnum"));
					//product.setPdetail(rs.getString("pdetail"));
					product.setOnsale(rs.getInt("onsale"));
					//product.setPimg(rs.getString("pimg"));
					//product.setBrandNo(rs.getInt("brandno"));
					product.setActive(rs.getInt("active"));
		            proList.add(product); //list에 모든 DTO 객체 추가
				}
			}catch(Exception ex) {
				ex.printStackTrace();
			}finally { oracleClose(); }
			return proList;
		}
		
		
		
		//특정 점주 상품 수 세기
		public int getProCount(String stoId) {
			int count = 0;
			try {
				conn=getConnection();
				sql = "select count(*) from product WHERE brandno IN (SELECT brandno FROM brand WHERE store_id = ?)";
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
		
		//특정 점주 특정 브랜드 상품 수 세기
		public int getProCount(String stoId, String selectedBrand) {
			int count = 0;
			try {
				conn=getConnection();
				sql = "select count(*) from product WHERE brandno IN (SELECT brandno FROM brand WHERE store_id = ? and brand=?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, stoId);
				pstmt.setString(2, selectedBrand);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally {	oracleClose();	}
			return count;
		}
}