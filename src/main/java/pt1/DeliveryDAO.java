package pt1;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DeliveryDAO extends OracleServer{

	private static DeliveryDAO instance = new DeliveryDAO();

	public static DeliveryDAO getInstance() {return instance; }  //자기자신을 리턴값으로 가지고있는 메서드 ...객체를 리턴하고있음 

	private DeliveryDAO() {}  // 생성자 

	
	//점주가 자신의 브랜드의 배송 목록 출력
	public ArrayList<DeliveryDTO> deliveryListCheck(int brandno) {
		ArrayList<DeliveryDTO> list=new ArrayList<>();
		try {
			conn=getConnection();
			sql="select * from delivery where brandno=? order by delivery_id desc";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, brandno);
			rs=pstmt.executeQuery();
			while(rs.next()){
				DeliveryDTO dto=new DeliveryDTO();
				dto.setDelivery_id(rs.getInt("delivery_id"));
				dto.setAddress(rs.getString("address"));
				dto.setRecipient_name(rs.getString("recipient_name"));
				dto.setCreated_at(rs.getTimestamp("created_at"));
				dto.setStatus(rs.getString("status"));
				dto.setBrandno(rs.getInt("brandno"));
				dto.setEnd_at(rs.getTimestamp("end_at"));
				dto.setTel(rs.getString("tel"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return list;
	}	

	//배송 준비 상태로 update (status =1)	,	end_at(배송완료시간) null 대입
	public int updateDeliveryOne(int delivery_id) {
		int result=0;
		try {
			conn=getConnection();
			//배송번호가 맞으면 배송준비상태 : status="1" 배송완료날짜 null로 변경 
			sql="update delivery set status=?, end_at=null where delivery_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "1");
			pstmt.setInt(2, delivery_id);
			pstmt.executeUpdate();
			result=1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return result;
	}
	//배송 중 상태로 update (status =2)	,	end_at(배송완료시간) null 대입
	public int updateDeliveryTwo(int delivery_id) {
		int result=0;
		try {
			conn=getConnection();
			//배송번호가 맞으면 배송준비상태 : status="2" 배송완료날짜 null로 변경
			sql="update delivery set status=?, end_at=null where delivery_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "2");
			pstmt.setInt(2, delivery_id);
			pstmt.executeUpdate();
			result=2;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return result;
	}
	//배송 완료 상태로 update (status =3)	,	end_at(배송완료시간) sysdate(현재 시간) 대입
	public int updateDeliveryThree(int delivery_id) {
		int result=0;
		try {
			conn=getConnection();
			//배송번호가 맞으면 배송준비상태 : status="3" 배송완료날짜 현재 날짜로 변경
			sql="update delivery set status=?, end_at=sysdate where delivery_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "3");
			pstmt.setInt(2, delivery_id);
			pstmt.executeUpdate();
			result=3;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return result;
	}
	//카카오페이 결제 완료되는 동시에 배송정보 등록
	public void setDelivery(PaymentDTO dto, String name, String address) {
		try {
			int brandno=0;
			String tel="";
			conn = getConnection();            
			sql="select tel from member where id=?";//PaymentDTO에 tel컬럼이 없기 때문에 사용자가 회원가입할 때 쓴 번호(tel) 가져옴
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_id());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				tel=rs.getString("tel");
				sql = "select brandno from product where pnum=?"; // 상품테이블에서 상품 번호로 브랜드값을 불러옴 
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getProduct_id());
				rs = pstmt.executeQuery();
				if(rs.next()) {   
					brandno = rs.getInt("brandno");
					sql="insert into delivery (delivery_id, id, pname, brandno, recipient_name, address, created_at, status, end_at, tel) "
							+ " values(delivery_seq.nextval, ?, ?, ?, ?, ?, sysdate, '1', null, ?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dto.getUser_id());
					pstmt.setString(2, dto.getPname());
					pstmt.setInt(3, brandno);
					pstmt.setString(4, name);
					pstmt.setString(5, address); 
					pstmt.setString(6, tel);
					pstmt.executeUpdate();
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	//payment_history 테이블의 payment_id와 회원 계정 id를 가지고 배송 정보 조회
	public List delivery_history(String memid, int payment_id){
		List delivery_historyList=null;
		try {
			conn=getConnection();
			sql="select * from delivery where id=? AND delivery_id=?";
			pstmt=conn.prepareStatement(sql.toString());
			pstmt.setString(1, memid);
			pstmt.setInt(2, payment_id);
			rs=pstmt.executeQuery();
			if(rs.next()) {   
				delivery_historyList=new ArrayList();
				do {
					DeliveryDTO dto=new DeliveryDTO();
					dto.setRecipient_name(rs.getString("recipient_name"));
					dto.setDelivery_id(rs.getInt("delivery_id"));
					dto.setPname(rs.getString("pname"));
					dto.setStatus(rs.getString("status"));
					delivery_historyList.add(dto);
				} while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		} return delivery_historyList;
	} 
}
