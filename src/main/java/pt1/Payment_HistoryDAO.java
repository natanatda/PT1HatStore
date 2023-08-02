package pt1;

import java.util.ArrayList;
import java.util.List;

public class Payment_HistoryDAO extends OracleServer{
	private static Payment_HistoryDAO instance = new Payment_HistoryDAO();
	public static Payment_HistoryDAO getInstance() {return instance;}
	private Payment_HistoryDAO(){}
	
	public int addPayment_History(String user_id, int product_id) {  // 주어진 user_id와 product_id를 이용하여 카트 테이블에서 해당 상품 정보를 조회한 후,
		                                                             // 조회된 정보를 이용하여 payment_history 테이블에 새로운 결제 내역을 추가하는 메서드
		int result = -1;
		try {
			conn = getConnection();
			sql = "select * from cart where product_id =? AND user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();					// status는 1고정! 
			if(rs.next()) { // user_id , product_id, pname, price, quantity, status, created_at
				sql = "insert into payment_history values(payment_history_seq.NEXTVAL,?,?,?,?,?,1,sysdate,?)";   // payment_history에 결제 내역을 추가
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
	// 주문내역에 추가하는 메서드
	public void addPayment_History(PaymentDTO dto) {
		try {
			conn = getConnection();
				sql = "insert into payment_history values(payment_history_seq.NEXTVAL,?,?,?,?,?,1,sysdate,?)";   // payment_history에 결제 내역을 추가
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getUser_id());
				pstmt.setInt(2, dto.getProduct_id());
				pstmt.setString(3, dto.getPname());
				pstmt.setInt(4, dto.getPrice());
				pstmt.setInt(5, dto.getQuantity());
				pstmt.setString(6, dto.getPimg());
				pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	
	List myPayment_History = new ArrayList();    // 결제 내역을 저장하는 ArrayList인 myPayment_History를 초기화하는 메서드
	public List clearList() {
		myPayment_History.clear();    // 결제 내역이 담긴 ArrayList를 초기화
		return myPayment_History;
	}
		
	


	public List getPayment_History(String user_id) {   //사용자의 결제 이력을 조회하는 메서드
		List mmylist = new ArrayList();
		try {
			conn = getConnection();
			sql = "select * from payment_history where user_id = ? order by payment_id desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {   // 결제 이력 정보를 Payment_HistoryDTO 객체에 담아서 List에 추가
				Payment_HistoryDTO dto = new Payment_HistoryDTO();
				dto.setPayment_id(rs.getInt("payment_id"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setPrice(rs.getInt("price"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPimg(rs.getString("pimg"));
				mmylist.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return mmylist;
	}
	
	public void deletePay(int payment_id) {  // 주어진 payment_id에 해당하는 결제 정보를 삭제하는 메소드
		try {
			conn = getConnection();
			sql = "delete from payment_history where payment_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, payment_id);
			pstmt.executeUpdate();  // 실행된 row의 개수 반환 X
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	public int countPay() {  // payment_history 테이블에 저장된 총 결제 수를 반환하는 메소드
		int result = -1;
		try {
			conn = getConnection();
			sql = "select count(*) from payment_history";
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
	
	
	public void deletePayAll() {  //payment_history 테이블에서 모든 데이터를 삭제하는 기능을 수행하는 메소드
		try {
			conn = getConnection();
			sql = "delete from payment_history";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	
	public Payment_HistoryDTO checkPayment(String productNum, String user_id) {  //구매한적 있는지 확인 (리뷰쓰기위함)
		Payment_HistoryDTO dto=null;
		try {
			conn = getConnection();
			sql = "select * from Payment_History where product_id = ? AND user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productNum);
			pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {	//
				dto = new Payment_HistoryDTO();	//dto객체 생성
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
} 