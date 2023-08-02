package pt1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends OracleServer {
    
	private static OrderDAO instance = new OrderDAO();
	public static OrderDAO getInstance() {return instance;}
	private OrderDAO(){}
	
    
    // 주문 추가
    public int insertOrder(OrderDTO order) {
        int result = 0;
        PreparedStatement pstmt = null;
        String sql = "INSERT INTO P_ORDER (ORDER_ID, USER_ID, DELIVERY_ID, TOTAL_PRICE, STATUS, CREATED_AT) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, order.getOrder_id());
            pstmt.setString(2, order.getUser_id());
            pstmt.setInt(3, order.getDelivery_id());
            pstmt.setInt(4, order.getTotal_price());
            pstmt.setString(5, order.getStatus());
            pstmt.setTimestamp(6, order.getCreated_at());
            result = pstmt.executeUpdate();
        }catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
        return result;
    }
    
    // 주문 조회
    public List<OrderDTO> getOrdersByUserId(String user_id) {
        List<OrderDTO> orders = new ArrayList<>();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM P_ORDER WHERE USER_ID=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrder_id(rs.getInt("ORDER_ID"));
                order.setUser_id(rs.getString("USER_ID"));
                order.setDelivery_id(rs.getInt("DELIVERY_ID"));
                order.setTotal_price(rs.getInt("TOTAL_PRICE"));
                order.setStatus(rs.getString("STATUS"));
                order.setCreated_at(rs.getTimestamp("CREATED_AT"));
                orders.add(order);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
        return orders;
    }
    
    // 주문 상태 변경
    public int updateOrderStatus(String order_id, String status) {
        int result = 0;
        PreparedStatement pstmt = null;
        String sql = "UPDATE P_ORDER SET STATUS=? WHERE ORDER_ID=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setString(2, order_id);
            result = pstmt.executeUpdate();
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if(pstmt != null) pstmt.close();
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    
    // 주문 총액 조회
    public int getTotalOrderPrice(int orderId) {
        int total = 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();

            String sql = "SELECT SUM(PRICE * QUANTITY) AS TOTAL_PRICE FROM ORDER_DETAIL WHERE ORDER_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                total = rs.getInt("TOTAL_PRICE");
            }
        }catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
        

        return total;
    }
    public void addOrderDetail(int cart_id, int product_id, int quantity) {
        PreparedStatement pstmt = null;
        try {
            String query = "INSERT INTO P_ORDER (order_id, product_id, quantity) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, cart_id);
            pstmt.setInt(2, product_id);
            pstmt.setInt(3, quantity);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
}
    }
}

