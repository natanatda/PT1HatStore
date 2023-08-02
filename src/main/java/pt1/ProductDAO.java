package pt1;

import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends OracleServer{
	private static ProductDAO instance = new ProductDAO();
	public static ProductDAO getInstance() {
		return instance;
	}
	private ProductDAO() {}

	//상품 추가 -> pUploadForm.jsp
	public int insertProduct(ProductDTO dto) {
		int result=0;
		try {
			conn = getConnection();//Connection 객체 생성 및 서버 연결
			sql = "insert into product values (?,product_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?)"; //sql문장 작성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCategory());
			pstmt.setString(2, dto.getColor());
			pstmt.setString(3, dto.getPname());
			pstmt.setInt(4, dto.getBrandNo());
			pstmt.setString(5, dto.getBrand());
			pstmt.setString(6, dto.getPsize());
			pstmt.setInt(7, dto.getStock());
			pstmt.setDouble(8, dto.getPrice());
			pstmt.setTimestamp(9, dto.getReg());
			pstmt.setInt(10, dto.getReadnum());
			pstmt.setString(11, dto.getPdetail());
			pstmt.setInt(12, dto.getOnsale());
			pstmt.setString(13, dto.getPimg()); //사용자가 업로드한 이미지를 서버에 등록한 이름
			pstmt.setInt(14, 1);
			pstmt.executeUpdate();
			result=1;
		}catch(Exception e) {
			e.printStackTrace(); //예외가 발생하면 위치 출력
		}finally { oracleClose();} //상속받은 OracleServer의 서버연결을 종료하는 메소드. finally이므로 예외 유무와 상관없이 무조건 수행.
		return result;
	}

	//상품 넘버(pnum 컬럼)로 구분하여 상품 상세 페이지 연결
	public ArrayList<ProductDTO> checkProduct (int pnum){
		ArrayList<ProductDTO> list=new ArrayList<>();
		try {
			conn=getConnection();
			//pnum에 맞는 상품 정보 불러오는 쿼리문 판매중(onsale==1) && active활성화 상태 (active=1) 
			sql="select * from product where onsale=1 and active=1 and pnum=?";
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setInt(1, pnum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				ProductDTO dto=new ProductDTO();
				dto.setCategory(rs.getString("category"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setColor(rs.getString("color"));
				dto.setPname(rs.getString("pname"));
				dto.setBrand(rs.getString("brand"));
				dto.setPsize(rs.getString("psize"));
				dto.setStock(rs.getInt("stock"));
				dto.setPrice(rs.getDouble("price"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadnum(rs.getInt("readnum"));
				dto.setPdetail(rs.getString("pdetail"));
				dto.setOnsale(rs.getInt("onsale"));
				dto.setPimg(rs.getString("pimg"));
				dto.setActive(rs.getInt("active"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return list;
	}  
	//검색창에서 상품 이름 검색하면 상품 목록 출력 / 최근 상품부터 불러오기 위해서 order by pnum desc 로 설정
	public List searchProduct(String pname){
		List productList=null;
		try {
			conn=getConnection();
			// 상품 검색창에 문자 입력하면 해당 문자가 포함되는 상품 목록을 불러오는 쿼리문 판매중(onsale==1) && active활성화 상태 (active=1) 
			// 최근 상품부터 불러오기 위해서 pnum desc로 정렬		
			sql="select * from product where onsale=1 and active=1 and pname like '%'||?||'%' order by pnum desc";
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setString(1, pname);
			rs=pstmt.executeQuery();
			if(rs.next()) {   
				productList=new ArrayList();
				do {
					ProductDTO dto=new ProductDTO();
					dto.setCategory(rs.getString("category"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setColor(rs.getString("color"));
					dto.setPname(rs.getString("pname"));
					dto.setBrand(rs.getString("brand"));
					dto.setPsize(rs.getString("psize"));
					dto.setStock(rs.getInt("stock"));
					dto.setPrice(rs.getDouble("price"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setReadnum(rs.getInt("readnum"));
					dto.setPdetail(rs.getString("pdetail"));
					dto.setOnsale(rs.getInt("onsale"));
					dto.setPimg(rs.getString("pimg"));
					dto.setActive(rs.getInt("active"));
					productList.add(dto);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return productList;
	}  

//	//브랜드 (brand 칼럼) 검색하면 해당 브랜드 정보 출력  / 최근 상품부터 불러오기 위해서 order by pnum desc 로 설정
//	//현재는 브랜드 검색을 하지 않아서 사용하지 않는 메소드
//	public ArrayList<ProductDTO> searchBrand(String brand){
//		ArrayList<ProductDTO> list=new ArrayList<>();
//		try {
//			conn=getConnection();
//
//			sql="select * from product where onsale=1 and active=1 and  brand=? order by pnum desc";
//			pstmt=conn.prepareStatement(sql.toString());
//			pstmt.setString(1, brand);
//			rs=pstmt.executeQuery();
//			if(rs.next()) {
//				ProductDTO dto=new ProductDTO();
//				dto.setCategory(rs.getString("category"));
//				dto.setPnum(rs.getInt("pnum"));
//				dto.setColor(rs.getString("color"));
//				dto.setPname(rs.getString("pname"));
//				dto.setBrand(rs.getString("brand"));
//				dto.setPsize(rs.getString("psize"));
//				dto.setStock(rs.getInt("stock"));
//				dto.setPrice(rs.getDouble("price"));
//				dto.setReg(rs.getTimestamp("reg"));
//				dto.setReadnum(rs.getInt("readnum"));
//				dto.setPdetail(rs.getString("pdetail"));
//				dto.setOnsale(rs.getInt("onsale"));
//				dto.setPimg(rs.getString("pimg"));
//				dto.setActive(rs.getInt("active"));
//				list.add(dto);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			oracleClose();
//		} return list;
//	}  


	//상품 번호에 따른 상품의 모든 정보보기  
	public ProductDTO getData(int pnum) {
		ProductDTO dto = new ProductDTO();

		conn = getConnection();
		pstmt = null;
		rs = null;

		String sql = "select * from product where pnum=? order by pnum desc";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				dto.setCategory(rs.getString("category"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setColor(rs.getString("color"));
				dto.setPname(rs.getString("pname"));
				dto.setBrand(rs.getString("brand"));
				dto.setPsize(rs.getString("psize"));
				dto.setStock(rs.getInt("stock"));
				dto.setPrice(rs.getDouble("price"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadnum(rs.getInt("readnum"));
				dto.setPdetail(rs.getString("pdetail"));
				dto.setOnsale(rs.getInt("onsale"));
				dto.setPimg(rs.getString("pimg"));
				dto.setActive(rs.getInt("active"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}

		return dto;
	}


	//조건(where)에 맞는 카테고리의 상품 목록 출력하기 위한 메소드  / 최근 상품부터 불러오기 위해서 order by pnum desc 로 설정
	public List selectCategory(String category){
		List categoryList=null;
		try {
			conn=getConnection();
			//         카테고리 조건에 맞는 상품 목록 불러오는 쿼리문 판매중(onsale==1) && active활성화 상태 (active=1) 
			sql="select * from product where onsale=1 and active=1 and category=? order by pnum desc";
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setString(1, category);
			rs=pstmt.executeQuery();
			if(rs.next()) {   
				categoryList=new ArrayList();
				do {
					ProductDTO dto=new ProductDTO();
					dto.setCategory(rs.getString("category"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setColor(rs.getString("color"));
					dto.setPname(rs.getString("pname"));
					dto.setBrand(rs.getString("brand"));
					dto.setPsize(rs.getString("psize"));
					dto.setStock(rs.getInt("stock"));
					dto.setPrice(rs.getDouble("price"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setReadnum(rs.getInt("readnum"));
					dto.setPdetail(rs.getString("pdetail"));
					dto.setOnsale(rs.getInt("onsale"));
					dto.setPimg(rs.getString("pimg"));
					dto.setActive(rs.getInt("active"));
					categoryList.add(dto);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return categoryList;
	}  


	//조건(where)에 맞는 브랜드의 상품 목록 출력하기 위한 메소드  / 최근 상품부터 불러오기 위해서 order by pnum desc 로 설정
	public List selectBrand(String brand){
		List brandList=null;
		try {
			conn=getConnection();
			// 조건에 맞는 브랜드 상품 목록 불러오는 쿼리문 판매중(onsale==1) && active활성화 상태 (active=1) 
			sql="select * from product where onsale=1 and active=1 and  brand=? order by pnum desc";
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setString(1, brand);
			rs=pstmt.executeQuery();
			if(rs.next()) {   
				brandList=new ArrayList();
				do {
					ProductDTO dto=new ProductDTO();
					dto.setCategory(rs.getString("category"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setColor(rs.getString("color"));
					dto.setPname(rs.getString("pname"));
					dto.setBrand(rs.getString("brand"));
					dto.setPsize(rs.getString("psize"));
					dto.setStock(rs.getInt("stock"));
					dto.setPrice(rs.getDouble("price"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setReadnum(rs.getInt("readnum"));
					dto.setPdetail(rs.getString("pdetail"));
					dto.setOnsale(rs.getInt("onsale"));
					dto.setPimg(rs.getString("pimg"));
					dto.setActive(rs.getInt("active"));
					brandList.add(dto);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return brandList;
	}


	// 특정 상품 정보 가져오기 -> productModify.jsp에서 사용
	public ProductDTO getProduct(int pnum) {
		ProductDTO dto = new ProductDTO();
		try {
			conn=getConnection();
			String sql = "select * from product where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setCategory(rs.getString("category"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setColor(rs.getString("color"));
				dto.setPname(rs.getString("pname"));
				dto.setBrandNo(rs.getInt("brandno"));
				dto.setBrand(rs.getString("brand"));
				dto.setPsize(rs.getString("psize"));
				dto.setStock(rs.getInt("stock"));
				dto.setPrice(rs.getDouble("price"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadnum(rs.getInt("readnum"));
				dto.setPdetail(rs.getString("pdetail"));
				dto.setOnsale(rs.getInt("onsale"));
				dto.setPimg(rs.getString("pimg"));
				dto.setActive(rs.getInt("active"));
			}
		} catch (Exception e) {	e.printStackTrace();
		} finally {oracleClose();	}

		return dto;
	}


	// 특정 상품 삭제하기 -> productDeletePro.jsp에서 사용
	public int deleteProduct(int pnum) {
		int result=0;
		try {
			conn=getConnection();
			sql="select pnum from product where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				String sql = "delete from product where pnum=? and onsale=0";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				pstmt.executeUpdate();
				result=1;
			}
		} catch (Exception e) {	e.printStackTrace();
		} finally {oracleClose();	}
		return result;
	}


	// 점주가 상품 관리 페이지에서 상품 이름 검색하면 상품 목록 출력
	public List searchProductStore(String pname, String stoId) {
		List productList = null;
		try {
			conn = getConnection();
			sql = "select * from product where brandno In" + "(select brandno from brand where store_id=?)"
					+ "and pname like '%'||?||'%' order by reg desc";
			pstmt = conn.prepareStatement(sql.toString());
			pstmt.setString(1, pname);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				productList = new ArrayList();
				do {
					ProductDTO dto = new ProductDTO();
					dto.setCategory(rs.getString("category"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setColor(rs.getString("color"));
					dto.setPname(rs.getString("pname"));
					dto.setBrand(rs.getString("brand"));
					dto.setPsize(rs.getString("psize"));
					dto.setStock(rs.getInt("stock"));
					dto.setPrice(rs.getDouble("price"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setReadnum(rs.getInt("readnum"));
					dto.setPdetail(rs.getString("pdetail"));
					dto.setOnsale(rs.getInt("onsale"));
					dto.setPimg(rs.getString("pimg"));
					dto.setActive(rs.getInt("active"));
					productList.add(dto);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return productList;
	} 
	//베스트 상품 목록 리스트 (readnum(조회수) 높은 순서로 정렬)
	public List bestProduct() {
		List bestProduct=null;
		try {
			conn=getConnection();
			sql="select * from product order by readnum desc";
			pstmt=conn.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				bestProduct=new ArrayList();
				do {
					ProductDTO dto=new ProductDTO();
					dto.setCategory(rs.getString("category"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setColor(rs.getString("color"));
					dto.setPname(rs.getString("pname"));
					dto.setBrand(rs.getString("brand"));
					dto.setPsize(rs.getString("psize"));
					dto.setStock(rs.getInt("stock"));
					dto.setPrice(rs.getDouble("price"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setReadnum(rs.getInt("readnum"));
					dto.setPdetail(rs.getString("pdetail"));
					dto.setOnsale(rs.getInt("onsale"));
					dto.setPimg(rs.getString("pimg"));
					dto.setActive(rs.getInt("active"));
					bestProduct.add(dto);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return bestProduct;
	}
	//브랜드번호(brandno)에 맞는 상품 리스트 출력
	public ArrayList<ProductDTO> getProductList(int brandno){
		ArrayList<ProductDTO> list=new ArrayList<>();
		try {
			conn=getConnection();
			sql="select * from product where brandno=? order by stock";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, brandno);
			rs=pstmt.executeQuery();
			while(rs.next()){
				ProductDTO dto=new ProductDTO();
				dto.setCategory(rs.getString("category"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setColor(rs.getString("color"));
				dto.setPname(rs.getString("pname"));
				dto.setBrand(rs.getString("brand"));
				dto.setPsize(rs.getString("psize"));
				dto.setStock(rs.getInt("stock"));
				dto.setPrice(rs.getDouble("price"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadnum(rs.getInt("readnum"));
				dto.setPdetail(rs.getString("pdetail"));
				dto.setOnsale(rs.getInt("onsale"));
				dto.setPimg(rs.getString("pimg"));
				dto.setActive(rs.getInt("active"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return list;
	}
	//상품번호(Pnum)에 맞는 stock(재고) 수정
	public void updateStock(ProductDTO dto) {
		try {
			conn=getConnection();
			sql="update product set stock=? where pnum=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,dto.getStock());
			pstmt.setInt(2,dto.getPnum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} 
	}

	// 상품 수정 -> productModifyPro.jsp
	public int updateProduct(ProductDTO dto, int pnum) {
		int result=0;
		try {
			conn=getConnection();
			sql = "UPDATE product "
					+ "SET COLOR=?, PNAME=?, PSIZE=?, STOCK=?, PRICE=?, REG=?, PDETAIL=?, ONSALE=?, PIMG=?, ACTIVE=? "
					+ "WHERE PNUM=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getColor());
			pstmt.setString(2, dto.getPname());
			pstmt.setString(3, dto.getPsize());
			pstmt.setInt(4, dto.getStock());
			pstmt.setDouble(5, dto.getPrice());
			pstmt.setTimestamp(6, dto.getReg());
			pstmt.setString(7, dto.getPdetail());
			pstmt.setInt(8, dto.getOnsale());
			pstmt.setString(9, dto.getPimg());
			pstmt.setInt(10, 1);
			pstmt.setInt(11, pnum);
			pstmt.executeUpdate();
			result=1;
		}catch(Exception e) {
			e.printStackTrace(); //예외가 발생하면 위치 출력
		}finally { oracleClose();} //상속받은 OracleServer의 서버연결을 종료하는 메소드. finally이므로 예외 유무와 상관없이 무조건 수행.
		return result;
	}
	//주문내역 페이지(mypay.jsp)에서 상품이름으로 브랜드 찾음 
	public String getProductBrandName(String pname) {
		String productName=null;
		try {
			conn = getConnection();
			sql="SELECT brand FROM product WHERE pname=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
			rs = pstmt.executeQuery();
			if(rs.next()){
				productName=rs.getString("brand");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return productName;
	}
}