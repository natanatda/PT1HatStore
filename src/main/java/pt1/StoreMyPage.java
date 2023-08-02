package pt1;

import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

public class StoreMyPage extends OracleServer{
	private static StoreMyPage instance = new StoreMyPage();
	public static StoreMyPage getInstance() {
		return instance;
	}
	private StoreMyPage() {}
	
	// 특정 브랜드 조회
	public ArrayList<Map<String, Object>> getBrandList(String stoId) {
		ArrayList<Map<String, Object>> brandList = new ArrayList<Map<String, Object>>();
		try {
			conn = getConnection();
			sql = "SELECT brand, brandno FROM brand WHERE store_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Map<String, Object> brand = new HashMap<String, Object>();
				brand.put("brand", rs.getString("brand"));
				brand.put("brandno", rs.getString("brandno"));
				brandList.add(brand);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return brandList;
	}
	
	
}
