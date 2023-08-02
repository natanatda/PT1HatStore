package pt1;

public class Order_ChangeDAO extends OracleServer{
	private static Order_ChangeDAO instance = new Order_ChangeDAO();
    public static Order_ChangeDAO getInstance() {return instance; }  
    private Order_ChangeDAO() {}
    
    // 취소, 환불사유 작성하는 메서드
    public int sendContent(int order_history_id,String content) {
    	int result = -1;
    	try { 
    		conn = getConnection();
    		sql = "insert into order_change values(?,?)";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, order_history_id);
    		pstmt.setString(2, content);
    		result = pstmt.executeUpdate(); // 성공 = 1, 실패 = -1
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		oracleClose();
    	}
    	return result;
    }
    
    // 사유 보여주는 메서드
    public Order_ChangeDTO getContent(int order_history_id) {
    	Order_ChangeDTO dto = new Order_ChangeDTO();
    	try {
    		conn = getConnection();
    		sql = "select * from Order_Change where c_num=?";
    		pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, order_history_id);
    		rs = pstmt.executeQuery();
    		if(rs.next()) {
    			dto.setC_num(rs.getInt("c_num"));
    			dto.setContent(rs.getString("content"));
    		}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}finally {
    		oracleClose();
    	}
    	return dto;
    }
}
