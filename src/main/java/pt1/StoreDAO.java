package pt1;

public class StoreDAO extends OracleServer {

	private static StoreDAO instance = new StoreDAO();
	public static StoreDAO getInstance() {
		return instance;
	} // 자기자신을 리턴값으로 가지고있는 메서드 ...객체를 리턴하고있음
	private StoreDAO() {} // 생성자

	public void insertStore(StoreDTO store) {  // StoreDTO를 인자로 받아 STORE 테이블에 새로운 레코드를 추가하는 메소드
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("insert into STORE values (?,?,?,?,?,?)");
			pstmt.setString(1, store.getStore_id());
			pstmt.setString(2, store.getStore_pw());
			pstmt.setString(3, store.getStore_name());
			pstmt.setString(4, store.getStore_tel());
			pstmt.setString(5, store.getStore_email());
			pstmt.setInt(6, store.getActive());

			pstmt.executeUpdate(); // 1행이 추가~ 막 이런 리턴 안받았음
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
	}

	public int confirmId(String store_id, String store_pw){  //입력한 아이디와 비밀번호를 확인하여 일치하면 1, 비밀번호가 틀리면 0, 아이디가 틀리면 -1을 반환
		String dbpasswd = "";
		int x = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select store_pw from STORE where store_id = ?");
			pstmt.setString(1, store_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("store_pw");
				if (dbpasswd.equals(store_pw))
					x = 1; // 아이디 비번 모두 맞음
				else
					x = 0; // 비번 틀림
			} else // 펄스면 이거 실행. (아이디 잘못 입력했을때-아이디 틀림)
				x = -1;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

	public StoreDTO getStore(String store_id) {  //입력한 아이디와 일치하는 가게 정보를 데이터베이스에서 가져와 StoreDTO 객체에 저장하여 반환
		StoreDTO store = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from STORE where store_id = ?");
			pstmt.setString(1, store_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				store = new StoreDTO(); // DTO에 다 보냄.
				store.setStore_id(rs.getString("store_id"));
				store.setStore_pw(rs.getString("store_pw"));
				store.setStore_name(rs.getString("store_name"));
				store.setStore_tel(rs.getString("store_tel"));
				store.setStore_email(rs.getString("store_email"));

			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return store; // DTO 리턴받음
	}

	public void updateStore(StoreDTO store) {  // StoreDTO를 인자로 받아 STORE 테이블에서 레코드를 수정하는 메소드
		try {
			conn = getConnection();
			pstmt = conn
					.prepareStatement("update STORE set store_pw=?,store_name=?, store_tel=?,store_email=?" + "where store_id=?");
			pstmt.setString(1, store.getStore_pw());
			pstmt.setString(2, store.getStore_name());
			pstmt.setString(3, store.getStore_tel());
			pstmt.setString(4, store.getStore_email());
			pstmt.setString(5, store.getStore_id());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
	}
	
	public int confirmId(String store_id) {  //입력한 아이디가 이미 존재하는지 확인
		String dbpasswd = "";
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select store_id from STORE where store_id = ?");
			pstmt.setString(1, store_id);
			rs = pstmt.executeQuery();

			if (rs.next())
				x = 1;
			else
				x = -1;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

	// 230503 소진 수정	230509 석현 수정
	public int userCheck(String store_id, String store_pw) {  // 입력된 아이디와 비밀번호를 검사하여 일치하는지 확인하는 메소드
		int result = -1;
		try {
			conn = getConnection();
			sql = "select * from STORE where store_id = ? AND store_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store_id);
			pstmt.setString(2, store_pw);
			rs = pstmt.executeQuery();
			if (rs.next()) { // 얘가 트루일때..
				if(rs.getInt("active") == 1) { // active가 1인 경우에만 result를 2로 변경합니다.
					result = 1;
				} else {
					result = 2;
				}
			} else {// 펄스면 이거 실행. (아이디 잘못 입력했을때-아이디 틀림)
				result = 0;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}
	
	public String idFind(StoreDTO dto) {   //입력으로 받은 MemberDTO 객체의 name, email, tel 정보를 이용하여 데이터베이스에서 id를 찾아서 반환
		String result = null;
		try {
			conn = getConnection();
			String sql = "select store_id from store where store_name=? and store_email=? and store_tel=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getStore_name());
			pstmt.setString(2, dto.getStore_email());
			pstmt.setString(3, dto.getStore_tel());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("store_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}

		return result;
	}

	public String pwFind(StoreDTO dto) {  // 주어진 MemberDTO 객체의 정보(id, email, tel)를 이용해 DB에서 해당 사용자의 비밀번호(pw)를 조회하는 메서드
		String result = null;
		try {
			conn = getConnection();
			String sql = "select store_pw from store where store_id=? and store_email=? and store_tel=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getStore_id());
			pstmt.setString(2, dto.getStore_email());
			pstmt.setString(3, dto.getStore_tel());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("store_pw");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}


}
