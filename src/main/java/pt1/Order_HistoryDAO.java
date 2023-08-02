package pt1;

import java.util.ArrayList;

public class Order_HistoryDAO extends OracleServer {
	private static Order_HistoryDAO instance = new Order_HistoryDAO();

	public static Order_HistoryDAO getInstance() {
		return instance;
	}

	private Order_HistoryDAO() {
	}

	// 결제 완료 창에 등록된 데이터를 주문내역 데이터에 넣는 메서드 (핸드폰번호는 사용자가 회원가입할 때 쓴 번호)
	public void setHistory(PaymentDTO dto, String address) {
		int result = -1;
		try {
			conn = getConnection();
			sql = "select tel from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_id());
			rs = pstmt.executeQuery();
			if (rs.next()) { // status빼고 다 insert ( status는 기본값 0 )
				sql = "insert into order_history (order_history_id, order_id, product_id, pname, quantity, price, address, tel, created_at, payment_method, brand)"
						+ " values(order_history_seq.NEXTVAL,?,?,?,?,?,?,?,?,'kakaopay',' ')";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getUser_id());
				pstmt.setInt(2, dto.getProduct_id());
				pstmt.setString(3, dto.getPname());
				pstmt.setInt(4, dto.getQuantity());
				pstmt.setInt(5, dto.getPrice());
				pstmt.setString(6, address);
				pstmt.setString(7, rs.getString("tel"));
				pstmt.setTimestamp(8, dto.getCreated_at());
				result = pstmt.executeUpdate();
				if (result == 1) {
					sql = "select brand from product where pnum=?"; // 상품테이블에서 상품 번호로 브랜드값을 불러옴
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, dto.getProduct_id());
					rs = pstmt.executeQuery();
					if (rs.next()) {
						sql = "update order_history set brand=? where product_id=?"; // 불러온 브랜드 값 상품 번호에 따라 다르게 수정
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, rs.getString("brand"));
						pstmt.setInt(2, dto.getProduct_id());
						pstmt.executeUpdate();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

// 모든 주문내역을 불러오는 메서드 (관리자 버전)
	public ArrayList<Order_HistoryDTO> getHistory(int pageNum) {
		ArrayList<Order_HistoryDTO> o_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select order_history_id,order_id,product_id,pname,quantity,price, address,tel,status,created_at,payment_method,brand, r "
					+ "from (select order_history_id,order_id,product_id,pname,quantity,price, address,tel,status,created_at,payment_method,brand, rownum r "
					+ "from (select * from order_history order by created_at desc) order by created_at desc) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setOrder_history_id(rs.getInt("order_history_id"));
				dto.setOrder_id(rs.getString("order_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setPrice(rs.getInt("price"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPayment_method(rs.getString("payment_method"));
				dto.setBrand(rs.getString("brand"));
				o_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return o_list;
	}

// 브랜드별로 주문 내역을 불러오는 메서드 (관리자 버전)
	public ArrayList<Order_HistoryDTO> getBrandHistory(int pageNum, String brand) {
		ArrayList<Order_HistoryDTO> o_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select order_history_id,order_id,product_id,pname,quantity,price, address,tel,status,created_at,payment_method,brand, r "
					+ "from (select order_history_id,order_id,product_id,pname,quantity,price, address,tel,status,created_at,payment_method,brand, rownum r "
					+ "from (select * from order_history where brand = ? order by created_at desc) order by created_at desc) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setOrder_history_id(rs.getInt("order_history_id"));
				dto.setOrder_id(rs.getString("order_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setPrice(rs.getInt("price"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPayment_method(rs.getString("payment_method"));
				dto.setBrand(rs.getString("brand"));
				o_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return o_list;
	}

// 처리상태로 주문 내역을 불러오는 메서드 (관리자 버전)
	public ArrayList<Order_HistoryDTO> getStatusHistory(int pageNum, int status) {
		ArrayList<Order_HistoryDTO> o_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select order_history_id,order_id,product_id,pname,quantity,price, address,tel,status,created_at,payment_method,brand, r "
					+ "from (select order_history_id,order_id,product_id,pname,quantity,price, address,tel,status,created_at,payment_method,brand, rownum r "
					+ "from (select * from order_history where status = ? order by created_at desc) order by created_at desc) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setOrder_history_id(rs.getInt("order_history_id"));
				dto.setOrder_id(rs.getString("order_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setPrice(rs.getInt("price"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPayment_method(rs.getString("payment_method"));
				dto.setBrand(rs.getString("brand"));
				o_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return o_list;
	}

// 주문내역이 몇 개 인지 세는 메서드
	public int countHistory() {
		int count = -1;
		try {
			conn = getConnection();
			sql = "select count(*) from order_history";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return count;
	}

// 주문내역이 몇 개 인지 세는 메서드 ( 브랜드 기준 )
	public int countBrandHistory(String brand) {
		int count = -1;
		try {
			conn = getConnection();
			sql = "select count(*) from order_history where brand=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return count;
	}

// 주문내역이 몇 개 인지 세는 메서드 ( 처리상태 기준 )
	public int countStatusHistory(int s_status) {
		int count = -1;
		try {
			conn = getConnection();
			sql = "select count(*) from order_history where status=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, s_status);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return count;
	}

// 처리상태 변경하는 메서드 
	public void updateStatus(int status, int order_history_id) {
		int result = 0;
		try {
			conn = getConnection();
			sql = "update order_history set status=? where order_history_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setInt(2, order_history_id);
			result = pstmt.executeUpdate();
			if (status >= 5 && status <= 8) { // 처리상태가 환불요철 ~ 환불완료일때 동작 (5,6,7,8)
				if (result == 1) {
					sql = "select * from order_history where status = ? and order_history_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, status);
					pstmt.setInt(2, order_history_id);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						String sta = String.valueOf(status); // 처리상태 int => String 형변환
						sql = "update refund set status=? where refund_id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, sta);
						pstmt.setInt(2, order_history_id);
						pstmt.executeUpdate();
						if(status == 8) { // 처리상태가 환불 완료일때 동작
							sql = "update refund set fin_at=sysdate where refund_id=?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, order_history_id);
							pstmt.executeUpdate();
						}
					} 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

// 처리상태 환불중으로변경하는 메서드(환불 신청 승인시)  
	public void updateRefund(int order_history_id) {
		int result = 0;
		try {
			conn = getConnection();
			sql = "update order_history set status=6 where order_history_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_history_id);
			result = pstmt.executeUpdate();
			if (result == 1) {
				sql = "select * from order_history where status = 6 and order_history_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, order_history_id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					sql = "update refund set status=6 where refund_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, order_history_id);
					pstmt.executeUpdate();
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}
// 처리상태 환불실패로변경하는 메서드(환불 신청 취소시)  
	public void cancelRefund(int order_history_id) {
		int result = 0;
		try {
			conn = getConnection();
			sql = "update order_history set status=7 where order_history_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_history_id);
			result = pstmt.executeUpdate();
			if (result == 1) {
				sql = "select * from order_history where status=7 and order_history_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, order_history_id);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					sql = "update refund set status=7 where refund_id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, order_history_id);
					pstmt.executeUpdate();
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

// 주문내역 불러오는 메서드
	public Order_HistoryDTO getContent(int order_history_id) {
		Order_HistoryDTO dto = null;
		try {
			conn = getConnection();
			sql = "select * from order_history where order_history_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_history_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new Order_HistoryDTO();
				dto.setOrder_history_id(rs.getInt("order_history_id"));
				dto.setOrder_id(rs.getString("order_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setPrice(rs.getInt("price"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPayment_method(rs.getString("payment_method"));
				dto.setBrand(rs.getString("brand"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}

// 주문 목록에서 삭제하는 메서드
	public void deleteOrder(int order_history_id) {
		try {
			conn = getConnection();
			sql = "delete from order_history where order_history_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_history_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

// 처리상태 완료로 바꾸는 메서드
	public void updateFinal(int status, int order_history_id) {
		try {
			conn = getConnection();
			sql = "update order_history set status=10 where status=? and order_history_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setInt(2, order_history_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

// 점주본인의 브랜드만 보이게 리스트 출력
	public ArrayList<Order_HistoryDTO> getList(int pageNum, String store) {
		ArrayList<Order_HistoryDTO> list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select * from (select rownum r, o.* from brand b, order_history o where b.brand = o.brand and b.store_id = ?"
					+ " order by o.created_at desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setOrder_history_id(rs.getInt("order_history_id"));
				dto.setOrder_id(rs.getString("order_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setPrice(rs.getInt("price"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPayment_method(rs.getString("payment_method"));
				dto.setBrand(rs.getString("brand"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return list;
	}

// 점주별로 문의 글 갯수 확인하는 메서드
	public int allCount(String store) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from brand b, order_history o where b.brand=o.brand and b.store_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

// 점주별, 브랜드별로 문의 글 갯수 확인하는 메서드
	public int allCount(String store, String brand) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from brand b, order_history o where b.brand=o.brand and o.brand =? and b.store_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			pstmt.setString(2, store);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

// 점주별, 처리상태별로 문의 글 갯수 확인하는 메서드
	public int allCount(String store, int status) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from brand b, order_history o where b.brand=o.brand and b.store_id = ? and status = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store);
			pstmt.setInt(2, status);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

// 브랜드별로 주문 내역을 불러오는 메서드 (점주버전)
	public ArrayList<Order_HistoryDTO> getBrandHistory(int pageNum, String brand, String store) {
		ArrayList<Order_HistoryDTO> o_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select * from (select rownum r, o.* from brand b, order_history o where b.brand = o.brand and b.store_id = ?"
					+ " and o.brand =? order by o.created_at desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store);
			pstmt.setString(2, brand);
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setOrder_history_id(rs.getInt("order_history_id"));
				dto.setOrder_id(rs.getString("order_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setPrice(rs.getInt("price"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPayment_method(rs.getString("payment_method"));
				dto.setBrand(rs.getString("brand"));
				o_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return o_list;
	}

// 처리상태별로 주문 내역을 불러오는 메서드 (점주버전)
	public ArrayList<Order_HistoryDTO> getStatusHistory(int pageNum, int status, String store) {
		ArrayList<Order_HistoryDTO> o_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select * from (select rownum r, o.* from brand b, order_history o where b.brand = o.brand and b.store_id = ?"
					+ " and o.status =? order by o.created_at desc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store);
			pstmt.setInt(2, status);
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setOrder_history_id(rs.getInt("order_history_id"));
				dto.setOrder_id(rs.getString("order_id"));
				dto.setProduct_id(rs.getInt("product_id"));
				dto.setPname(rs.getString("pname"));
				dto.setQuantity(rs.getInt("quantity"));
				dto.setPrice(rs.getInt("price"));
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));
				dto.setStatus(rs.getInt("status"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setPayment_method(rs.getString("payment_method"));
				dto.setBrand(rs.getString("brand"));
				o_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return o_list;
	}

// 드롭다운 메뉴에 현재 있는 브랜드명만 보이게 하기위한 메서드 (점주버전)
	public ArrayList<Order_HistoryDTO> selectBran(String stoId) {
		ArrayList<Order_HistoryDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			sql = "select distinct o.brand from brand b, order_history o where b.brand = o.brand and b.store_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setBrand(rs.getString("brand"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return list;
	}

// 드롭다운 메뉴에 현재 있는 처리상태만 보이게 하기위한 메서드 (점주버전)
	public ArrayList<Order_HistoryDTO> selectSta(String stoId) {
		ArrayList<Order_HistoryDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			sql = "select distinct o.status from brand b, order_history o where b.brand = o.brand and b.store_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setStatus(rs.getInt("status"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return list;
	}

// 드롭다운 메뉴에 현재 있는 브랜드만 보이게 하기위한 메서드 (관리자버전)
	public ArrayList<Order_HistoryDTO> selectBran() {
		ArrayList<Order_HistoryDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			sql = "select distinct brand from order_history"; // 중복제거하고 검색
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setBrand(rs.getString("brand"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return list;
	}

// 드롭다운 메뉴에 현재 있는 처리상태만 보이게 하기위한 메서드 (관리자버전)
	public ArrayList<Order_HistoryDTO> selectStatus() {
		ArrayList<Order_HistoryDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			sql = "select distinct status from order_history"; // 중복제거하고 검색
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order_HistoryDTO dto = new Order_HistoryDTO();
				dto.setStatus(rs.getInt("status"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return list;
	}

	// 점주가 자신의 브랜드 주문내역만 볼 수 있게 자신의 브랜드인지 확인하는 메서드
	public int checkContent(String brand, String store_id) {
		int result = 0;
		try {
			conn = getConnection();
			sql = "select o.* from brand b, order_history o where b.brand = ? and b.store_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			pstmt.setString(2, store_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}
}

//	public void updateStoreId() {
//		try {
//			conn = getConnection();
//			sql = "select * from brand";
//			pstmt = conn.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				sql = "update order_history set store_id=? where brand=? and store_id=?";
//				pstmt = conn.prepareStatement(sql);
//				pstmt.setString(1, rs.getString("store_id"));
//				pstmt.setString(2, rs.getString("brand"));
//				pstmt.setString(3, rs.getString("store_id"));
//				pstmt.executeUpdate();
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			oracleClose();
//		}
//	}