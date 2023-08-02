package pt1;

import java.util.ArrayList;
import java.util.List;

public class PaymentDAO extends OracleServer{
	private static PaymentDAO instance = new PaymentDAO();
	public static PaymentDAO getInstance() {return instance;}
	private PaymentDAO(){}

	//payment테이블에 상품 추가
	public int addPayment(String user_id, int product_id) {
		int result = -1;
		try {
			conn = getConnection();
			sql = "select * from cart where product_id =? AND user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();					// status는 1고정! 
			if(rs.next()) { // user_id , product_id, pname, price, quantity, status, created_at
				sql = "insert into payment values(payment_seq.NEXTVAL,?,?,?,?,?,1,sysdate,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_id);
				pstmt.setInt(2, product_id);
				pstmt.setString(3, rs.getString("pname"));
				pstmt.setInt(4, rs.getInt("price"));
				pstmt.setInt(5, rs.getInt("quantity"));
				pstmt.setString(6, rs.getString("pimg"));
				pstmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return result;
	}
	
	
	public void addPayment2(String user_id, int product_id, int quantity) {
		try {
			conn = getConnection();
			sql = "select * from product where pnum =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();					// status는 1고정! 
			if(rs.next()) { // user_id , product_id, pname, price, quantity, status, created_at
				sql = "insert into payment values(payment_seq.NEXTVAL,?,?,?,?,?,1,sysdate,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_id);
				pstmt.setInt(2, product_id);
				pstmt.setString(3, rs.getString("pname"));
				pstmt.setInt(4, rs.getInt("price"));
				pstmt.setInt(5, quantity);
				pstmt.setString(6, rs.getString("pimg"));
				pstmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}

	List myPayment = new ArrayList();
	public List clearList() {
		myPayment.clear();
		return myPayment;
	}




	public List getPayment(String user_id) {
		List paylist = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from payment where user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PaymentDTO dto = new PaymentDTO();
				dto.setPayment_id(rs.getInt("payment_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setPrice(rs.getInt("price"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPimg(rs.getString("pimg"));
				paylist.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return paylist;
	}

	public void deletePay(int payment_id) {
		try {
			conn = getConnection();
			sql = "delete from payment where payment_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, payment_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	public int countPay() {
		int result = -1;
		try {
			conn = getConnection();
			sql = "select count(*) from payment";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = 1;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return result;
	}


	public void deletePayAll(String memid) {
		try {
			conn = getConnection();
			sql = "delete from payment where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memid);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}

	public PaymentDTO checkPayment(String product_id) {
		PaymentDTO dto=null;
		try {
			conn = getConnection();
			sql = "select * from payment where product_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {	//
				dto = new PaymentDTO();	//dto객체 생성
				dto.setPayment_id(rs.getInt("payment_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setPrice(rs.getInt("price"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPimg(rs.getString("pimg"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return dto;
	}
	public void deleteLastProduct(String memid) {
		try {
			conn = getConnection();
			sql=" DELETE FROM payment WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memid);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
//	public List getPayment(String user_id) {
//		List paylist = new ArrayList();
//		try {
//			conn = getConnection();
//			sql = "select * from (select address, id, name from member) m, (select * from payment) p, (select brandno, pname from product) pr"
//					+"where p.user_id=m.id AND p.pname=pr.pname"
//					+"AND id=?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, user_id);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				PaymentDTO dto = new PaymentDTO();
//				dto.setPayment_id(rs.getInt("payment_id"));
//				dto.setUser_id(rs.getString("user_id"));
//				dto.setProduct_id(rs.getInt("product_id"));
//				dto.setPname(rs.getString("pname"));
//				dto.setPrice(rs.getInt("price"));
//				dto.setQuantity(rs.getInt("quantity"));
//				dto.setStatus(rs.getInt("status"));
//				dto.setCreated_at(rs.getTimestamp("created_at"));
//				dto.setPimg(rs.getString("pimg"));
//				paylist.add(dto);
//			}
//		}catch(Exception e) {
//			e.printStackTrace();
//		}finally {
//			oracleClose();
//		}
//		return paylist;
//	}
} 