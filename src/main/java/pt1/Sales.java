package pt1;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Sales extends OracleServer{
	private static Sales instance = new Sales();
	public static Sales getInstance() {
		return instance;
	}
	private Sales() {}

	//-------------------관리자-------------------
	// 금일 주문수와 매출액 조회
	public Map<String, Object> getTodayOrdersAndRevenue() {
		Map<String, Object> result = new HashMap<>();
		try {
			conn = getConnection();
			sql = "SELECT COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE "
					+ "FROM PAYMENT_HISTORY "
					+ "WHERE TRUNC(CREATED_AT) = TRUNC(SYSDATE)";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result.put("order_count", rs.getInt("ORDER_COUNT"));
				result.put("revenue", rs.getInt("REVENUE"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return result;
	}

	//모든 기간의 일별 매출 및 주문수
	public List<Map<String, Object>> getDailyOrdersAndRevenue() {
		List<Map<String, Object>> orders = new ArrayList<>();
		try {
			conn=getConnection();
			sql = "SELECT TO_CHAR(CREATED_AT, 'YYYY-MM-DD') AS ORDER_DATE, COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE "
					+ "FROM PAYMENT_HISTORY "
					+ "GROUP BY TO_CHAR(CREATED_AT, 'YYYY-MM-DD')"
					+ "ORDER BY TO_CHAR(CREATED_AT, 'YYYY-MM-DD') DESC";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> order = new HashMap<>();
				order.put("order_date", rs.getString("ORDER_DATE"));
				order.put("order_count", rs.getLong("ORDER_COUNT"));
				order.put("revenue", rs.getLong("REVENUE"));
				orders.add(order);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return orders;
	}


	//금일, 전일, 일주일, 한달 매출 및 주문수
	public Map<String, Object> getOrdersAndRevenue(String duration) {
		Map<String, Object> result = new HashMap<>();
		try {
			conn = getConnection();
			String sql = "";
			switch (duration) {
			case "today":
				sql = "SELECT COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE "
						+ "FROM PAYMENT_HISTORY "
						+ "WHERE TRUNC(CREATED_AT) = TRUNC(SYSDATE)";
				break;
			case "yesterday":
				sql = "SELECT COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE "
						+ "FROM PAYMENT_HISTORY "
						+ "WHERE TRUNC(CREATED_AT) = TRUNC(SYSDATE - 1)";
				break;
			case "last_week":
				sql = "SELECT COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE "
						+ "FROM PAYMENT_HISTORY "
						+ "WHERE CREATED_AT BETWEEN TRUNC(SYSDATE - 7) AND TRUNC(SYSDATE - 1) ";
				break;
			case "last_month":
				sql = "SELECT COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE FROM PAYMENT_HISTORY WHERE CREATED_AT >= ADD_MONTHS(SYSDATE, -1) AND CREATED_AT < SYSDATE";
				break;
			}
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result.put("order_count", rs.getLong("ORDER_COUNT"));
				result.put("revenue", rs.getLong("REVENUE"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return result;
	}


	//특정 기간 내 일일 매출 조회
	public List<Map<String, Object>> getDailySales(String startDate, String endDate) {
		List<Map<String, Object>> dailySalesList = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "SELECT TRUNC(created_at) AS order_date, COUNT(*) AS daily_order_count, SUM(price * quantity) AS daily_sales "
					+ "FROM PAYMENT_HISTORY "
					+ "WHERE TRUNC(created_at) BETWEEN ? AND ? "
					+ "GROUP BY TRUNC(created_at) "
					+ "ORDER BY TRUNC(created_at) DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> dailySales = new HashMap<>();
				dailySales.put("orderDate", rs.getDate("order_date"));
				dailySales.put("dailyOrderCount", rs.getInt("daily_order_count"));
				dailySales.put("dailySales", rs.getInt("daily_sales"));
				dailySalesList.add(dailySales);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return dailySalesList;
	}


	//특정 기간 내 브랜드별 매출 조회
	public List<Map<String, Object>> getSalesByBrandAndPeriod(String startDate, String endDate, String sort) {
		List<Map<String, Object>> salesList = new ArrayList<>();

		// 대소문자 구분 없이 asc, desc 구분하기. 파라미터 값에 따라 오름차순, 내림차순 정렬
		String orderBy = sort.equalsIgnoreCase("desc") ? "DESC" : "ASC";
		try{
			conn = getConnection();
			sql = "SELECT pr.BRAND, pr.BRANDNO, b.STORE_ID, COUNT(*) AS ORDER_COUNT, SUM(p.PRICE * p.QUANTITY) AS TOTAL_SALES "
					+ "FROM PAYMENT_HISTORY p, product pr, (SELECT DISTINCT BRANDNO, STORE_ID FROM brand) b "
					+ "WHERE p.product_id = pr.pnum AND pr.BRANDNO = b.BRANDNO "
					+ "AND TRUNC(p.CREATED_AT) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') "
					+ "GROUP BY pr.BRAND, pr.BRANDNO, b.STORE_ID "
					+ "ORDER BY TOTAL_SALES "+orderBy;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> sales = new HashMap<>();
				sales.put("brand", rs.getString("BRAND"));
				sales.put("brandno", rs.getInt("BRANDNO"));
				sales.put("store_id", rs.getString("STORE_ID"));
				sales.put("order_count", rs.getInt("ORDER_COUNT"));
				sales.put("total_sales", rs.getInt("TOTAL_SALES"));
				salesList.add(sales);
				
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return salesList;	
	}


	//특정 기간 내 해당 브랜드의 일일 매출 조회
	public List<Map<String, Object>> getDailySales(String startDate, String endDate, int brandno) {
		List<Map<String, Object>> dailySalesList = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "SELECT TRUNC(ph.CREATED_AT) AS order_date, "
					+ "COUNT(*) AS daily_order_count, "
					+ "SUM(p.PRICE * ph.QUANTITY) AS daily_sales "
					+ "FROM PAYMENT_HISTORY ph, PRODUCT p, BRAND b "
					+ "WHERE ph.PRODUCT_ID = p.PNUM AND b.BRAND = p.BRAND AND b.BRANDNO = ? "
					+ "AND TRUNC(ph.CREATED_AT) BETWEEN ? AND ? "
					+ "GROUP BY TRUNC(ph.CREATED_AT) "
					+ "ORDER BY TRUNC(ph.CREATED_AT) DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brandno);
			pstmt.setString(2, startDate);
			pstmt.setString(3, endDate);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> dailySales = new HashMap<>();
				dailySales.put("orderDate", rs.getDate("order_date"));
				dailySales.put("dailyOrderCount", rs.getInt("daily_order_count"));
				dailySales.put("dailySa"
						+ "les", rs.getInt("daily_sales"));
				dailySalesList.add(dailySales);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return dailySalesList;
	}
	
	//특정 기간 내 해당 점주의 일일 매출 조회
		public List<Map<String, Object>> getDailySales(String startDate, String endDate, String stoId) {
			List<Map<String, Object>> dailySalesList = new ArrayList<>();
			try {
				conn = getConnection();
				String sql = "SELECT TRUNC(ph.CREATED_AT) AS order_date, "
						+ "COUNT(*) AS daily_order_count, "
						+ "SUM(p.PRICE * ph.QUANTITY) AS daily_sales "
						+ "FROM PAYMENT_HISTORY ph, PRODUCT p, BRAND b "
						+ "WHERE ph.PRODUCT_ID = p.PNUM AND b.BRAND = p.BRAND AND b.STORE_ID = ? "
						+ "AND TRUNC(ph.CREATED_AT) BETWEEN ? AND ? "
						+ "GROUP BY TRUNC(ph.CREATED_AT) "
						+ "ORDER BY TRUNC(ph.CREATED_AT) DESC";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, stoId);
				pstmt.setString(2, startDate);
				pstmt.setString(3, endDate);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					Map<String, Object> dailySales = new HashMap<>();
					dailySales.put("orderDate", rs.getDate("order_date"));
					dailySales.put("dailyOrderCount", rs.getInt("daily_order_count"));
					dailySales.put("dailySales", rs.getInt("daily_sales"));
					dailySalesList.add(dailySales);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally { oracleClose(); }
			return dailySalesList;
		}


	//해당 브랜드의 경고 수 카운트
	public int getWarningCount(int brandno) {
		int count=0;
		try {
			conn = getConnection();
			String sql = "SELECT COUNT(*) FROM admin_message "
					+ "WHERE BRANDNO = ? and SUBJECT=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brandno);
			pstmt.setString(2, "경고");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				count=rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return count;
	}


	//특정 기간 내 점주별 매출 조회
	public List<Map<String, Object>> getSalesByStoreAndPeriod(String startDate, String endDate, String sort) {
		List<Map<String, Object>> salesList = new ArrayList<>();

		// 대소문자 구분 없이 asc, desc 구분하기. 파라미터 값에 따라 오름차순, 내림차순 정렬
		String orderBy = sort.equalsIgnoreCase("desc") ? "DESC" : "ASC";
		try{
			conn = getConnection();
			sql = "SELECT b.STORE_ID, COUNT(*) AS ORDER_COUNT, SUM(p.PRICE * p.QUANTITY) AS TOTAL_SALES "
					+ "FROM PAYMENT_HISTORY p, product pr, (SELECT DISTINCT BRANDNO, STORE_ID FROM brand) b "
					+ "WHERE p.product_id = pr.pnum AND pr.BRANDNO = b.BRANDNO "
					+ "AND TRUNC(p.CREATED_AT) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') "
					+ "GROUP BY b.STORE_ID "
					+ "ORDER BY TOTAL_SALES "+orderBy;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> sales = new HashMap<>();
				sales.put("store_id", rs.getString("STORE_ID"));
				sales.put("order_count", rs.getInt("ORDER_COUNT"));
				sales.put("total_sales", rs.getInt("TOTAL_SALES"));
				salesList.add(sales);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return salesList;	
	}


	//특정 기간 내 상품별 매출
	public List<Map<String, Object>> getSalesByProductAndPeriod(String startDate, String endDate, String sort) {
		List<Map<String, Object>> salesList = new ArrayList<>();

		// 대소문자 구분 없이 asc, desc 구분하기. 파라미터 값에 따라 오름차순, 내림차순 정렬
		String orderBy = sort.equalsIgnoreCase("desc") ? "DESC" : "ASC";
		try{
			conn = getConnection();
			sql = "SELECT pr.pnum, b.BRAND, b.BRANDNO, b.STORE_ID, SUM(p.QUANTITY) AS TOTAL_QUANTITY, COUNT(*) AS ORDER_COUNT, SUM(p.PRICE * p.QUANTITY) AS TOTAL_SALES "
					+ "FROM PAYMENT_HISTORY p, (SELECT DISTINCT pnum, BRANDNO FROM product) pr, (SELECT STORE_ID, BRAND, BRANDNO FROM brand) b "
					+ "WHERE pr.pnum = p.product_id AND pr.BRANDNO = b.BRANDNO "
					+ "AND TRUNC(p.CREATED_AT) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') "
					+ "GROUP BY pr.pnum, b.BRAND, b.BRANDNO, b.STORE_ID "
					+ "ORDER BY TOTAL_SALES "+orderBy;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> sales = new HashMap<>();
				sales.put("pnum", rs.getString("PNUM"));
				sales.put("brand", rs.getString("BRAND"));
				sales.put("brandno", rs.getInt("BRANDNO"));
				sales.put("total_quantity", rs.getInt("TOTAL_QUANTITY"));
				sales.put("store_id", rs.getString("STORE_ID"));
				sales.put("order_count", rs.getInt("ORDER_COUNT"));
				sales.put("total_sales", rs.getInt("TOTAL_SALES"));
				salesList.add(sales);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return salesList;   
	}







	//-------------------점주-------------------
	//특정 기간 내 일일 매출 상세 조회
	public List<Map<String, Object>> getDailySalesStore(String startDate, String endDate, String store_id) {
		List<Map<String, Object>> dailySalesList = new ArrayList<>();
		System.out.println(startDate);
		System.out.println(endDate);
		try {
			conn = getConnection();
			String sql = "SELECT "
					+ "PH.CREATED_AT AS SALES_DATE, "
					+ "P.PNAME AS PRODUCT_NAME, "
					+ "PH.PRICE AS PPRICE, "
					+ "SUM(PH.QUANTITY) AS ORDER_QUANTITY, "
					+ "SUM(PH.PRICE * PH.QUANTITY) AS PAYMENT_AMOUNT "
					+ "FROM PAYMENT_HISTORY PH, PRODUCT P, BRAND B "
					+ "WHERE PH.PRODUCT_ID = P.PNUM AND P.BRANDNO = B.BRANDNO AND B.STORE_ID=? "
					+ "AND TRUNC(PH.CREATED_AT) BETWEEN ? AND ? "
					+ "GROUP BY PH.CREATED_AT, P.PNAME, PH.PRICE "
					+ "ORDER BY TRUNC(PH.CREATED_AT) DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store_id);
			pstmt.setString(2, startDate);
			pstmt.setString(3, endDate);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> dailySales = new HashMap<>();
				dailySales.put("sales_date", rs.getDate("sales_date"));
				dailySales.put("product_name", rs.getString("product_name"));
				dailySales.put("pprice", rs.getInt("pprice"));
				dailySales.put("order_quantity", rs.getInt("order_quantity"));
				dailySales.put("payment_amount", rs.getInt("payment_amount"));
				dailySalesList.add(dailySales);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return dailySalesList;
	}

	//특정 기간 내 해당 점주의 일일 매출 조회
	public List<Map<String, Object>> getDailyStoreSales(String startDate, String endDate, String store_id) {
		List<Map<String, Object>> dailySalesList = new ArrayList<>();
		try {
			conn = getConnection();
			String sql = "SELECT TRUNC(ph.CREATED_AT) AS order_date, "
					+ "COUNT(*) AS daily_order_count, "
					+ "SUM(p.PRICE * ph.QUANTITY) AS daily_sales "
					+ "FROM PAYMENT_HISTORY ph, PRODUCT p, BRAND b "
					+ "WHERE ph.PRODUCT_ID = p.PNUM AND p.BRANDNO=b.BRANDNO AND b.STORE_ID=? "
					+ "AND TRUNC(ph.CREATED_AT) BETWEEN ? AND ? "
					+ "GROUP BY TRUNC(ph.CREATED_AT) "
					+ "ORDER BY TRUNC(ph.CREATED_AT) DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store_id);
			pstmt.setString(2, startDate);
			pstmt.setString(3, endDate);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> dailySales = new HashMap<>();
				dailySales.put("orderDate", rs.getDate("order_date"));
				dailySales.put("dailyOrderCount", rs.getInt("daily_order_count"));
				dailySales.put("dailySales", rs.getInt("daily_sales"));
				dailySalesList.add(dailySales);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return dailySalesList;
	}

	//점주 id(store_id)로 구분해서 해당 점주가 운영하는 브랜드의 상품 매출 목록 출력
	public List<Map<String, Object>> getSalesByProduct(String store_id,String startDate, String endDate, String sort) {
		List<Map<String, Object>> salesProductList = new ArrayList<>();
		String orderBy = sort.equalsIgnoreCase("desc") ? "DESC" : "ASC";
		try{
			conn = getConnection();
			sql = "SELECT pr.pnum, b.BRAND, b.BRANDNO, b.STORE_ID,  \r\n"
					+ "SUM(p.QUANTITY) AS TOTAL_QUANTITY, COUNT(*) AS ORDER_COUNT, \r\n"
					+ "SUM(p.PRICE * p.QUANTITY) AS TOTAL_SALES\r\n"
					+ "FROM PAYMENT_HISTORY p, \r\n"
					+ "(SELECT DISTINCT pnum, BRANDNO FROM product) pr, "
					+ "(SELECT STORE_ID, BRAND, BRANDNO FROM brand) b "
					+ "WHERE pr.pnum = p.product_id AND pr.BRANDNO = b.BRANDNO AND store_id=? "
					+ "AND TRUNC(p.CREATED_AT) BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') "
					+ "GROUP BY pr.pnum, b.BRAND, b.BRANDNO, b.STORE_ID "
					+ "ORDER BY TOTAL_SALES "+orderBy;
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store_id);
			pstmt.setString(2, startDate);
			pstmt.setString(3, endDate);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> sales = new HashMap<>();
				sales.put("pnum", rs.getString("PNUM"));
				sales.put("brand", rs.getString("BRAND"));
				sales.put("brandno", rs.getInt("BRANDNO"));
				sales.put("store_id", rs.getString("STORE_ID"));
				sales.put("total_quantity", rs.getInt("TOTAL_QUANTITY"));
				sales.put("order_count", rs.getInt("ORDER_COUNT"));
				sales.put("total_sales", rs.getInt("TOTAL_SALES"));
				salesProductList.add(sales);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally { oracleClose(); }
		return salesProductList;   
	}

	//상품의 구매순이 많은 순서대로 출력
	public List<Map<String, Object>> getBestProduct() {
		List<Map<String, Object>> bestProductList = new ArrayList<>();
		try {
			conn=getConnection();
			sql = "SELECT pr.category, pr.pnum, pr.color, pr.pname, pr.brandno, pr.brand, pr.psize, pr.stock, pr.price, pr.readnum, pr.pimg, SUM(ph.quantity) AS total_quantity\r\n"
					+ "FROM product pr, payment_history ph\r\n"
					+ "WHERE pr.pnum = ph.product_id\r\n"
					+ "GROUP BY pr.category, pr.pnum, pr.color, pr.pname, pr.brandno, pr.brand, pr.psize, pr.stock, pr.price, pr.readnum, pr.pimg\r\n"
					+ "ORDER BY total_quantity desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> product = new HashMap<>();
				product.put("category", rs.getString("CATEGORY"));
				product.put("pnum", rs.getInt("PNUM"));
				product.put("color", rs.getString("COLOR"));
				product.put("pname", rs.getString("PNAME"));
				product.put("brandno", rs.getInt("BRANDNO"));
				product.put("brand", rs.getString("BRAND"));
				product.put("psize", rs.getString("PSIZE"));
				product.put("stock", rs.getInt("STOCK"));
				product.put("price", rs.getInt("PRICE"));
				product.put("readnum", rs.getInt("READNUM"));
				product.put("pimg", rs.getString("PIMG"));
				product.put("total_quantity", rs.getInt("TOTAL_QUANTITY"));

				bestProductList.add(product);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}finally { oracleClose(); }
		return bestProductList;
	}

	
	// 금일, 전일, 일주일, 한달 매출 및 주문수
	public Map<String, Object> getOrdersAndRevenue(String stoId, String duration) {
		Map<String, Object> result = new HashMap<>();
		try {
			conn = getConnection();
			String sql = "";
			switch (duration) {
			case "today":
				sql = "SELECT COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE "
						+ "FROM payment_history "
						+ "WHERE TRUNC(CREATED_AT) = TRUNC(SYSDATE) "
						+ "AND USER_ID IN (SELECT USER_ID FROM product WHERE BRANDNO IN "
						+ "(SELECT BRANDNO FROM brand WHERE STORE_ID = ?))";
				break;
			case "yesterday":
				sql = "SELECT COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE "
	                    + "FROM payment_history "
	                    + "WHERE TRUNC(CREATED_AT) = TRUNC(SYSDATE - 1) "
	                    + "AND USER_ID IN (SELECT USER_ID FROM product WHERE BRANDNO IN (SELECT BRANDNO FROM brand WHERE STORE_ID = ?))";
				break;
			case "last_week":
				sql = "SELECT COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE "
	                    + "FROM payment_history "
	                    + "WHERE TRUNC(CREATED_AT) BETWEEN TRUNC(SYSDATE) - 7 AND TRUNC(SYSDATE -1) "
	                    + "AND USER_ID IN (SELECT USER_ID FROM product WHERE BRANDNO IN (SELECT BRANDNO FROM brand WHERE STORE_ID = ?))";
				break;
			case "last_month":
				sql = "SELECT COUNT(*) AS ORDER_COUNT, SUM(PRICE * QUANTITY) AS REVENUE "
	                    + "FROM payment_history "
	                    + "WHERE CREATED_AT >= ADD_MONTHS(SYSDATE, -1) AND CREATED_AT < SYSDATE "
	                    + "AND USER_ID IN (SELECT USER_ID FROM product WHERE BRANDNO IN (SELECT BRANDNO FROM brand WHERE STORE_ID = ?))";
				break;
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result.put("order_count", rs.getLong("ORDER_COUNT"));
				result.put("revenue", rs.getLong("REVENUE"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}


}
