package pt1;


import java.util.ArrayList;
import java.util.List;

public class RefundDAO extends OracleServer{
	private static RefundDAO instance = new RefundDAO();
	public static RefundDAO getInstance() {return instance;}
	private RefundDAO(){}


	public void insertRefund(int product_id) {
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into refund values (?,?,?,?,?,sysdate)");
			pstmt.setInt(1, product_id);
			pstmt.setString(2, rs.getString("pname"));
			pstmt.setInt(3, rs.getInt("price"));
			pstmt.setInt(4, rs.getInt("quantity"));
			pstmt.setString(5, rs.getString("refundwhy"));


			pstmt.executeUpdate(); // 1행이 추가~ 막 이런 리턴 안받았음
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
	}

	public int addRefund(RefundDTO refund, int Payment_id) {
		int result=0;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into refund (refund_id,user_id,product_id,pname,price,quantity,refundwhy,added_at, STATUS, FIN_AT) "
					+ "values (?,?,?,?,?,?,?,sysdate, '1', NULL)");
			pstmt.setInt(1, Payment_id);
			pstmt.setString(2, refund.getUser_id());
			pstmt.setInt(3, refund.getProduct_id());
			pstmt.setString(4, refund.getPname());
			pstmt.setInt(5, refund.getPrice());
			pstmt.setInt(6, refund.getQuantity());
			pstmt.setString(7, refund.getRefundwhy());
			pstmt.executeUpdate(); // 1행이 추가~ 막 이런 리턴 안받았음
			result=1;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}
	// 환불 사유 작성하는 메서드
	public int addRefund(RefundDTO refund) {
		int result = 0;
		try { 
			conn = getConnection();
			sql = "select order_history_id from order_history where order_id = ? and product_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, refund.getUser_id());
			pstmt.setInt(2, refund.getProduct_id());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pstmt = conn.prepareStatement(
						"insert into refund (refund_id, user_id, product_id, pname, price, quantity, refundwhy, added_at, status, fin_at) "
								+ "values (?,?,?,?,?,?,?,sysdate,5,'')");
				pstmt.setInt(1, rs.getInt("order_history_id"));
				pstmt.setString(2, refund.getUser_id());
				pstmt.setInt(3, refund.getProduct_id());
				pstmt.setString(4, refund.getPname());
				pstmt.setInt(5, refund.getPrice());
				pstmt.setInt(6, refund.getQuantity());
				pstmt.setString(7, refund.getRefundwhy());
				result = pstmt.executeUpdate(); 
				if(result == 1) {
					sql = "update order_history set status=5 where order_history_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, rs.getInt("order_history_id"));
					pstmt.executeUpdate();
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}



	public void deleteRefund(String user_id, int product_id) {
		try {
			conn = getConnection();
			sql = "delete from PAYMENT_HISTORY where user_id=? and product_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, product_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}


	public List getRefund(String user_id) {
		List mmylist=null;
		try {
			conn = getConnection();
			sql = "select * from refund where user_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {   
				mmylist=new ArrayList();
				do {
					RefundDTO dto = new RefundDTO();
					dto.setRefund_id(rs.getInt("refund_id"));
					dto.setUser_id(rs.getString("user_id"));
					dto.setProduct_id(rs.getInt("product_id"));
					dto.setPname(rs.getString("pname"));
					dto.setPrice(rs.getInt("price"));
					dto.setQuantity(rs.getInt("quantity"));
					dto.setAdded_at(rs.getTimestamp("added_at"));
					dto.setStatus(rs.getString("status"));
					dto.setFin_at(rs.getTimestamp("fin_at"));
					dto.setRefundwhy(rs.getString("refundwhy"));
					dto.setStatus(rs.getString("status"));
					mmylist.add(dto);
				} while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return mmylist;
	}

	public RefundDTO checkRefund(String user_id, int product_id) {
		RefundDTO dto=null;
		try {
			conn = getConnection();
			sql = "select * from refund where user_id=? and product_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, product_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {	//
				dto = new RefundDTO();	//dto객체 생성
				dto.setUser_id(rs.getString("user_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setPrice(rs.getInt("price"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setAdded_at(rs.getTimestamp("added_at"));
				dto.setStatus(rs.getString("status"));
				dto.setFin_at(rs.getTimestamp("fin_at"));

			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return dto;
	}

	public int RefundCheck(String user_id, int product_id) {// 리턴타입 int임
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select pw from REFUND where user_id = ? and product_id=?"); // 쿼리문작성중. 멤버 태그에 있는 비밀번호만 검색하겠다는거임.
			// 매개변수로 입력받은 id대입해서 해당 아이디에 맞는
			// 비밀번호,,,
			pstmt.setString(1, user_id);
			pstmt.setInt(2, product_id);
			rs = pstmt.executeQuery();

			if (rs.next()) { // 얘가 트루일때..

				x = 1; 

			} else // 펄스면 이거 실행. 
				x = -1;

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}
	//환불 조회 (user_id, payment_id 로 판별)
	public List findRefund(String user_id, int Payment_id) {
		List refundlist=null;
		try {
			conn = getConnection();
			sql = "select * from refund where user_id = ? AND refund_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setInt(2, Payment_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {   
				refundlist=new ArrayList();
				do {
					RefundDTO dto = new RefundDTO();
					dto.setUser_id(rs.getString("user_id"));
					dto.setProduct_id(rs.getInt("product_id"));
					dto.setPname(rs.getString("pname"));
					dto.setPrice(rs.getInt("price"));
					dto.setQuantity(rs.getInt("quantity"));
					dto.setAdded_at(rs.getTimestamp("added_at"));
					dto.setStatus(rs.getString("status"));
					dto.setFin_at(rs.getTimestamp("fin_at"));
					dto.setRefundwhy(rs.getString("refundwhy"));
					refundlist.add(dto);
				} while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return refundlist;
	} 
	
	//환불 조회 (주문내역 번호로 판별)
	public RefundDTO findRefund(int c_num) {
		RefundDTO dto = null;
		try {
			conn = getConnection();
			sql = "select * from refund where refund_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {   
					dto = new RefundDTO();
					dto.setUser_id(rs.getString("user_id"));
					dto.setRefund_id(rs.getInt("refund_id"));
					dto.setProduct_id(rs.getInt("product_id"));
					dto.setPname(rs.getString("pname"));
					dto.setPrice(rs.getInt("price"));
					dto.setQuantity(rs.getInt("quantity"));
					dto.setAdded_at(rs.getTimestamp("added_at"));
					dto.setStatus(rs.getString("status"));
					dto.setFin_at(rs.getTimestamp("fin_at"));
					dto.setRefundwhy(rs.getString("refundwhy"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
		return dto;
	}
}



