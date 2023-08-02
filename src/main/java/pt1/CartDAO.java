package pt1;

import java.sql.Array;
import java.util.ArrayList;
import java.util.List;

public class CartDAO extends OracleServer{
	private static CartDAO instance = new CartDAO();
	public static CartDAO getInstance() {return instance;}
	private CartDAO(){}

	
	public List getCart(String user_id) {   // 회원 아이디로 자신의 장바구니를 불러오는 메서드
		List mylist = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from cart where user_id=? order by created_at DESC";  //cart 테이블에서 created_at 컬럼을 기준으로 내림차순으로 정렬
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CartDTO dto = new CartDTO();
				dto.setCart_id(rs.getInt("cart_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPimg(rs.getString("pimg"));
				dto.setPname(rs.getString("pname"));
				dto.setPrice(rs.getInt("price"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				mylist.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return mylist;
	}
	
	
	public int addCart(int product_id, String user_id,int quantity) {  // 장바구니에 상품을 추가하는 메서드
		int result=0;
		try {
			conn = getConnection();
			sql="SELECT * FROM cart WHERE product_id=? AND user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setString(2, user_id);
			rs=pstmt.executeQuery();	
			if(rs.next()) {
				//이미 cart에 있는 상품인 경우 상품의 수량만 업데이트
				quantity=quantity+rs.getInt("quantity");
				System.out.println(quantity);
				sql="UPDATE cart SET quantity=? WHERE product_id=? AND user_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, quantity);
				pstmt.setInt(2, product_id);
				pstmt.setString(3, user_id);
				pstmt.executeUpdate();
				result=2;
			}else {
				// cart에 없는 상품인 경우 새로 추가
				sql = "select * from product where pnum=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_id);
				rs = pstmt.executeQuery();
				if(rs.next()) { // cart_id, user_id, product_id, pimg, pname, price, quantity
					sql = "insert into cart values(cart_seq.NEXTVAL,?,?,?,?,?,?,sysdate)";
					pstmt = conn.prepareStatement(sql); 
					pstmt.setString(1, user_id);
					pstmt.setInt(2, rs.getInt("pnum")); // 상품 테이블에서 검색한 결과로 insert
					pstmt.setString(3, rs.getString("pimg"));
					pstmt.setString(4, rs.getString("pname"));
					pstmt.setInt(5, rs.getInt("price"));
					pstmt.setInt(6, quantity);
					pstmt.executeUpdate();
					result=1;
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			oracleClose();
		}
		return result;
	}
	

	public void deleteCart(int cart_id) {  	// 장바구니 안 품목 삭제하는 메서드
		try {
			conn = getConnection();
			sql = "delete from cart where cart_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	

	public int countCart(String user_id) { // 장바구니에 상품이 있는지 확인하는 메서드
		int result = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from cart where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		} 
		return result;
	}
	
	public List getPnameCart(String p_name) {  //상품명(p_name)을 기준으로 장바구니(cart)에서 상품을 검색해 리스트로 반환
		List mmylist = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from cart where p_name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_name);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CartDTO dto = new CartDTO();
				dto.setCart_id(rs.getInt("cart_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPimg(rs.getString("pimg"));
				dto.setPname(rs.getString("pname"));
				dto.setPrice(rs.getInt("price"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				mmylist.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return mmylist;   //최종적으로 검색된 장바구니 정보를 담고 있는 리스트
	}
	public int updateQuantity(int quantity, int cart_id, String user_id) {  //장바구니(cart)에서 특정 상품의 수량(quantity)을 업데이트
		int result = -1;
		try {
			conn = getConnection();
			sql = "update cart set quantity=? where cart_id=? and user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, quantity);
			pstmt.setInt(2, cart_id);
			pstmt.setString(3, user_id);
			result = pstmt.executeUpdate();     //update 작업이 성공하면 1이상의 값을, 실패하면 0을 반환
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return result;
	}
	public void deleteAll(String user_id) {   //데이터베이스에서 장바구니 정보를 삭제 (특정 사용자의 모든 장바구니 항목을 삭제)
		try {
			conn = getConnection();
			sql = "delete from cart where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	
	//특정 상품 ID에 해당하는 장바구니 항목을 삭제
	public void selectDelete(int product_id) {   
		try {
			conn = getConnection();
			sql = "delete from cart where product_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	
	
	
	//결제 완료한 상품을 장바구니에서 삭제
	public void deleteAfterPay(int product_id, String user_id) {   
		try {
			conn = getConnection();
			sql = "DELETE FROM cart WHERE product_id=? AND user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setString(2, user_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}


}

//	List myCart = new ArrayList();
//	public List getPayForm(int product_id) {  //바구니(cart)에서 특정 상품(product_id)에 대한 결제 정보를 가져오는 메서드
//		try {
//			conn = getConnection();
//			sql = "select * from cart where product_id=?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, product_id); 
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				CartDTO dto = new CartDTO();
//				dto.setCart_id(rs.getInt("cart_id"));
//				dto.setUser_id(rs.getString("user_id"));
//				dto.setProduct_id(rs.getInt("product_id"));
//				dto.setPimg(rs.getString("pimg"));
//				dto.setPname(rs.getString("pname"));
//				dto.setPrice(rs.getInt("price"));
//				dto.setQuantity(rs.getInt("quantity"));
//				dto.setCreated_at(rs.getTimestamp("created_at"));
//				myCart.add(dto);
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//		}finally {
//			oracleClose();
//		}
//		return myCart;
//	}
//	public List clearList() {  //장바구니 리스트(myCart)를 초기화하는 메서드
//		myCart.clear();
//		return myCart;
//	}