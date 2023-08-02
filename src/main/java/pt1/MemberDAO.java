package pt1;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.sql.*;

import pt1.MemberDTO;

import javax.naming.*;

public class MemberDAO extends OracleServer {

	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
		return instance;
	} // 자기자신을 리턴값으로 가지고있는 메서드 ...객체를 리턴하고있음

	private MemberDAO() {
	} // 생성자

	
	//회원가입 소진 수정 230508
	public void insertMember(MemberDTO member) {  // 회원 정보를 데이터베이스에 삽입
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into MEMBER (id,pw,name,tel,email,address, active) values (?,?,?,?,?,?,1)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getAddress());
			pstmt.executeUpdate(); // 1행이 추가~ 막 이런 리턴 안받았음
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
	}

	
	//로그인 소진 수정 230508
	public int userCheck(String id, String pw) {   // 입력받은 아이디와 비밀번호를 검증
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from MEMBER where id = ? and pw=?"); // 쿼리문작성중. 멤버 태그에 있는 비밀번호만 검색하겠다는거임.
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
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

	public int confirmId(String id) {  //입력한 아이디가 이미 존재하는지 확인
		String dbpasswd = "";
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select id from MEMBER where id = ?");
			pstmt.setString(1, id);
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

	public MemberDTO getMember(String id) {  //입력받은 id를 기준으로 데이터베이스에서 해당하는 회원의 정보를 조회
		MemberDTO member = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from MEMBER where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberDTO(); // DTO에 다 보냄.
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setTel(rs.getString("tel"));
				member.setEmail(rs.getString("email"));
				member.setAddress(rs.getString("address"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return member; // DTO 리턴받음
	}

	public void updateMember(MemberDTO member) { // 회원 정보 수정을 위해 데이터베이스에 접근하여 해당 회원의 정보를 업데이트하는 기능
		try {
		conn = getConnection();

		pstmt = conn.prepareStatement("update MEMBER set pw=?,name=?,email=?,tel=?,address=? where id=? ");
		pstmt.setString(1, member.getPw());
		pstmt.setString(2, member.getName());
		pstmt.setString(3, member.getEmail());
		pstmt.setString(4, member.getTel());
		pstmt.setString(5, member.getAddress());
		pstmt.setString(6, member.getId());


		pstmt.executeUpdate();
		} catch (Exception ex) {
		ex.printStackTrace();
		} finally {
		oracleClose();
		}
		}

	public int deleteMember(String id, String pw) {  // id와 pw를 매개변수로 받아서, MEMBER 테이블에서 해당 id의 비밀번호를 조회한 후, 매개변수로 받은 pw와 비교하여 일치하면 해당 id의 회원 정보를 삭제하고, 삭제 성공 여부를 반환하는 메서드
		String dbpasswd = "";
		int x = -1;  //x = 1이면 삭제 성공, x = 0이면 비밀번호 불일치, x = -1이면 예외 발생 등의 이유로 삭제 실패
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select pw from MEMBER where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("pw"); // 비밀번호 같아야 탈퇴진행해줌
				if (dbpasswd.equals(pw)) {  //매개변수로 받은 pw와 조회한 비밀번호를 비교
					pstmt = conn.prepareStatement("delete from MEMBER where id=?");
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					x = 1;
				} else
					x = 0;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

	public String idFind(MemberDTO dto) {   //입력으로 받은 MemberDTO 객체의 name, email, tel 정보를 이용하여 데이터베이스에서 id를 찾아서 반환
		String result = null;
		try {
			conn = getConnection();
			String sql = "SELECT id FROM member WHERE name=? and email=? and tel=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getTel());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	public String pwFind(MemberDTO dto) {  // 주어진 MemberDTO 객체의 정보(id, email, tel)를 이용해 DB에서 해당 사용자의 비밀번호(pw)를 조회하는 메서드
		String result = null;
		try {
			conn = getConnection();
			String sql = "select pw from member where id=? and email=? and tel=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getTel());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("pw");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	public boolean loginCheck(MemberDTO dto) {  // 로그인 시 아이디와 비밀번호를 입력받아 해당 정보가 데이터베이스에 있는지 확인하는 메소드
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement("select * from MEMBER where id=? and pw=?"); // 쿼리문 실행
			pstmt.setString(1, dto.getId()); // 물음표 채우기
			pstmt.setString(2, dto.getPw());

			rs = pstmt.executeQuery(); // 쿼리문 실행결과는 resultset에 넣음
			if (rs.next()) {
				result = true;
			}

		} catch (Exception e) {
			e.printStackTrace(); // 예외내용이 콘솔창에 들여쓰기돼서 나오게 함

		} finally {
			oracleClose();
		}
		return result;

	}

	public MemberDTO getMemberAddress(String id) {  // 입력받은 id에 해당하는 회원의 주소 정보를 가져옴
		MemberDTO member = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select address from MEMBER where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new MemberDTO(); // DTO에 다 보냄.

				member.setAddress(rs.getString("address"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return member; // DTO 리턴받음
	}

	public List getMemberlist(String id) {  //해당 ID에 대한 회원 정보를 데이터베이스에서 조회하여 MemberDTO 객체에 저장하고, 이들 객체들을 List로 묶어서 반환
		List mmylist = new ArrayList();
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from MEMBER where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberDTO ddto = new MemberDTO();
				// DTO에 다 보냄.
				ddto.setId(rs.getString("id"));
				ddto.setPw(rs.getString("pw"));
				ddto.setName(rs.getString("name"));
				ddto.setTel(rs.getString("tel"));
				ddto.setEmail(rs.getString("email"));
				ddto.setAddress(rs.getString("address"));
				mmylist.add(ddto);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return mmylist;  // 조회된 MemberDTO 객체들을 담은 List를 반환
	}

	public List getMemberinfo(String user_id) {  // 입력받은 user_id에 해당하는 회원 정보를 가져오는 메소드
		List mylist = new ArrayList();
		try {
			conn = getConnection();
			String sql = "select address, tel, name from MEMBER where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {  // 결과값이 존재하는 경우, MemberDTO 객체를 생성하여 정보를 담고, mylist에 추가
				MemberDTO dto = new MemberDTO();
				dto.setAddress(rs.getString("address"));
				dto.setTel(rs.getString("tel"));
				dto.setName(rs.getString("name"));
				mylist.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return mylist;  // 회원 정보를 담은 리스트 반환
	}

}
