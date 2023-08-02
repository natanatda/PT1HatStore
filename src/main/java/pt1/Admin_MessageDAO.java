package pt1;

import java.util.ArrayList;
import java.util.List;

public class Admin_MessageDAO extends OracleServer {
	private static Admin_MessageDAO instance = new Admin_MessageDAO();

	public static Admin_MessageDAO getInstance() {
		return instance;
	}

	private Admin_MessageDAO() {
	}

	// 브랜드 번호에 맞는 전체 메시지의 개수를 불러오는 메서드
	public int getAdmin_MessageCount(int brandno) {
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from admin_message where brandno=?"); //
			pstmt.setInt(1, brandno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	// List만들어서 브랜드 번호별 메시지 넣어두기
	public List getAdmin_Messages(int brandno, int start, int end) {
		List admin_MessageList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select message_num,writer,store_id,brandno,brandname,subject,content,regDate,mimg,status,ref,re_step,re_level, r from"
							+ "(select message_num,writer,store_id,brandno,brandname,subject,content,regDate,mimg,status,ref,re_step,re_level,rownum r from "
							+ "(select * from admin_message order by regDate desc)) where brandno=? and r >= ? and r <= ?");
			pstmt.setInt(1, brandno);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				admin_MessageList = new ArrayList(end);
				do {
					Admin_MessageDTO dto = new Admin_MessageDTO();
					dto.setMessage_num(rs.getInt("message_num"));
					dto.setWriter(rs.getString("writer"));
					dto.setStore_id(rs.getString("store_id"));
					dto.setBrandno(rs.getInt("brandno"));
					dto.setBrandname(rs.getString("brandname"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setRegDate(rs.getTimestamp("regDate"));
					dto.setMimg(rs.getString("mimg"));
					dto.setStatus(rs.getInt("status"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
					admin_MessageList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return admin_MessageList;
	}

	// 브랜드 번호별 메시지에 대한 정보를 불러옴
	public Admin_MessageDTO getAdmin_Message(int brandno) {
		Admin_MessageDTO dto = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from admin_massage where brandno = ?");
			pstmt.setInt(1, brandno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new Admin_MessageDTO();
				dto.setMessage_num(rs.getInt("message_num"));
				dto.setWriter(rs.getString("writer"));
				dto.setStore_id(rs.getString("store_id"));
				dto.setBrandno(rs.getInt("brandno"));
				dto.setBrandname(rs.getString("brandname"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRegDate(rs.getTimestamp("regDate"));
				dto.setMimg(rs.getString("mimg"));
				dto.setStatus(rs.getInt("status"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}

	// 해당 브랜드 경고 메시지 보내기 (관리자가 salesBrand에서 경고버튼 누르면)
	public int insertWarning(String writer, String store_id, int brandno, String brandname) {
		Admin_MessageDTO dto = new Admin_MessageDTO();
		int result = 0;
		try {
			conn = getConnection(); // 서버 연결
			sql = "insert into admin_message values(admin_message_seq.nextval,?,?,?,?,'경고',?||' 매출이 저조하여 안내드립니다.\r\n"
					+ "해당 메시지를 3회 이상 받는 경우, 퇴점 조치를 취할 수 있으니 이용에 참고바랍니다.',sysdate,?,0,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setString(2, store_id);
			pstmt.setInt(3, brandno);
			pstmt.setString(4, brandname);
			pstmt.setString(5, brandname);
			pstmt.setString(6, dto.getMimg());
			pstmt.setInt(7, dto.getRef());
			pstmt.setInt(8, dto.getRe_step());
			pstmt.setInt(9, dto.getRe_level());
			pstmt.executeUpdate();
			result = 1;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	// 브랜드 번호에 맞는 점주 id불러오기
	/*
	 * public List<String> getStore_id(int brandno) { List<String> stID = new
	 * ArrayList<>(); try { conn = getConnection(); String sql =
	 * "select store_id from brand where brandno=?"; pstmt =
	 * conn.prepareStatement(sql); pstmt.setInt(1, brandno); rs =
	 * pstmt.executeQuery(); while (rs.next()) { } } catch (Exception e) {
	 * e.printStackTrace(); } finally { oracleClose(); }
	 * 
	 * return stID; }
	 */
	// 브랜드 번호에 맞는 점주 아이디 불러오기(brand테이블에서)
	public BrandDTO getStore_id(int brandno) {
		BrandDTO dto = new BrandDTO();
		try {
			conn = getConnection();
			String sql = "select store_id from brand where brandno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brandno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setStore_id(rs.getString("store_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}

	// 브랜드 번호에 맞는 브랜드 이름 불러오기(brand테이블에서)
	public BrandDTO getBrandname(int brnadno) {
		BrandDTO dto = new BrandDTO();
		try {
			conn = getConnection();
			String sql = "select brand from brand where brandno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brnadno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setBrand(rs.getString("brand"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}

	/*
	 * public void insertAdminMs(Admin_MessageDTO dto){ try { conn =
	 * getConnection(); //서버 연결
	 * sql="insert into notice values(admin_message_seq.nextval,?,?,?,?,?)"; pstmt =
	 * conn.prepareStatement(sql); pstmt.setString(1, dto.getStore_id());
	 * pstmt.setInt(2, dto.getBrandno()); pstmt.setString(3, dto.getSubject());
	 * pstmt.setString(4, dto.getContent()); pstmt.setTimestamp(5,
	 * dto.getRegDate()); pstmt.setString(6, dto.getMimg()); pstmt.setInt(7,
	 * dto.getActive()); pstmt.setString(4, dto.getContent()); pstmt.setString(4,
	 * dto.getContent()); pstmt.setString(4, dto.getContent());
	 * pstmt.executeUpdate(); } catch(Exception ex) { ex.printStackTrace(); }
	 * finally { oracleClose(); } }
	 */
	// 관리자가 메시지 작성
	public int insertAdminMs(Admin_MessageDTO dto, int brandno, String admid) {
//			int message_num = dto.getMessage_num(); // 글 번호
//			int ref = dto.getRef(); // 글 그룹 (글 번호가 달라도 그룹끼리 묶여있음)
//			int re_step = dto.getRe_step(); // 답글 (최근 답글이 1번~)
//			int re_level = dto.getRe_level(); // 답글 : 1 / 답글의 답글 : 2 / 답글의 답글의 답글 : 3 ...
//			int number = 0;
//			String brandname="";
		int result = 0;
		try {
			conn = getConnection();
			/*
			 * sql = "select max(message_num) from admin_message"; // 지금까지 생성된 글 번호 조회하는 쿼리
			 * pstmt = conn.prepareStatement(sql); rs = pstmt.executeQuery(); if (rs.next())
			 * { number = rs.getInt(1) + 1; } else { number = 1; } if (message_num != 0) {
			 * sql =
			 * "update admin_message set re_step = re_step+1 where ref = ? and re_step > ?";
			 * pstmt = conn.prepareStatement(sql); pstmt.setInt(1, ref); pstmt.setInt(2,
			 * re_step); pstmt.executeUpdate(); re_step = re_step + 1; re_level = re_level +
			 * 1; sql = "update admin_message set status = 1 where ref = ?"; pstmt =
			 * conn.prepareStatement(sql); pstmt.setInt(1, ref); pstmt.executeUpdate(); }
			 * else { ref = number; re_step = 0; re_level = 0; }
			 */ pstmt = conn.prepareStatement("select brand from brand where brandno=?");
			pstmt.setInt(1, brandno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "insert into admin_message (message_num,writer,store_id,brandno,brandname,subject,content,regDate,mimg,status,ref,re_step,re_level) values(admin_message_seq.NEXTVAL,?,?,?,?,?,?,sysdate,?,?,0,0,0)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, admid);
				pstmt.setString(2, dto.getStore_id());
				pstmt.setInt(3, dto.getBrandno());
				pstmt.setString(4, rs.getString("brand"));
				pstmt.setString(5, dto.getSubject());
				pstmt.setString(6, dto.getContent());
//				pstmt.setTimestamp(7, dto.getRegDate());
				pstmt.setString(7, dto.getMimg());
				pstmt.setInt(8, dto.getStatus());
//				pstmt.setInt(10, ref);
//				pstmt.setInt(11, re_step);
//				pstmt.setInt(12, re_level);
				pstmt.executeUpdate();
				result = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	// 관리자가 보낸 메시지 불러오기
	public Admin_MessageDTO getMessage_fromAdm(String writer) {
		Admin_MessageDTO dto = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from admin_massage where writer = ?");
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new Admin_MessageDTO();
				dto.setMessage_num(rs.getInt("message_num"));
				dto.setWriter(rs.getString("writer"));
				dto.setStore_id(rs.getString("store_id"));
				dto.setBrandno(rs.getInt("brandno"));
				dto.setBrandname(rs.getString("brandname"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRegDate(rs.getTimestamp("regDate"));
				dto.setMimg(rs.getString("mimg"));
				dto.setStatus(rs.getInt("status"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}

	// 점주 아이디에 맞는 전체 메시지의 개수를 불러오는 메서드
	public int getAdmin_MessageCount2(String store_id) {
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from admin_message where store_id=?"); //
			pstmt.setString(1, store_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	// List만들어서 점주 별 메시지 넣어두기
	public List getAdmin_Messages2(String store_id, int start, int end) {
		List admin_MessageList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select message_num,writer,store_id,brandno,brandname,subject,content,regDate,mimg,status,ref,re_step,re_level, r from"
							+ "(select message_num,writer,store_id,brandno,brandname,subject,content,regDate,mimg,status,ref,re_step,re_level,rownum r from "
							+ "(select * from admin_message order by regDate desc)) where store_id=? and r >= ? and r <= ?");
			pstmt.setString(1, store_id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				admin_MessageList = new ArrayList(end);
				do {
					Admin_MessageDTO dto = new Admin_MessageDTO();
					dto.setMessage_num(rs.getInt("message_num"));
					dto.setWriter(rs.getString("writer"));
					dto.setStore_id(rs.getString("store_id"));
					dto.setBrandno(rs.getInt("brandno"));
					dto.setBrandname(rs.getString("brandname"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setRegDate(rs.getTimestamp("regDate"));
					dto.setMimg(rs.getString("mimg"));
					dto.setStatus(rs.getInt("status"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
					admin_MessageList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return admin_MessageList;
	}

	// 관리자에 맞는 전체 메시지의 개수를 불러오는 메서드
	public int getAdmin_MessageCount(String admid) {
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from admin_message where writer=?"); //
			pstmt.setString(1, admid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	// List만들어서 관리자 별 메시지 넣어두기
	public List getAdmin_Messages(String admid, int start, int end) {
		List admin_MessageList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select message_num,writer,store_id,brandno,brandname,subject,content,regDate,mimg,status,ref,re_step,re_level, r from"
							+ "(select message_num,writer,store_id,brandno,brandname,subject,content,regDate,mimg,status,ref,re_step,re_level,rownum r from "
							+ "(select * from admin_message order by regDate desc)) where writer=? and r >= ? and r <= ?");
			pstmt.setString(1, admid);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				admin_MessageList = new ArrayList(end);
				do {
					Admin_MessageDTO dto = new Admin_MessageDTO();
					dto.setMessage_num(rs.getInt("message_num"));
					dto.setWriter(rs.getString("writer"));
					dto.setStore_id(rs.getString("store_id"));
					dto.setBrandno(rs.getInt("brandno"));
					dto.setBrandname(rs.getString("brandname"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setRegDate(rs.getTimestamp("regDate"));
					dto.setMimg(rs.getString("mimg"));
					dto.setStatus(rs.getInt("status"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
					admin_MessageList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return admin_MessageList;
	}

	// 관리자별 보낸 메시지 목록 소진 작성
	public List getAdminMessages(int start, int end) {
		List admin_MessageList = null;
		try {
			conn = getConnection();
			sql = "SELECT message_num, writer, store_id, brandno, brandname, subject, content, regDate, mimg, status, ref, re_step, re_level, r FROM "
					+ "( SELECT message_num, writer, store_id, brandno, brandname, subject, content, regDate, mimg, status, ref, re_step, re_level, rownum r "
					+ "FROM (SELECT * FROM admin_message ORDER BY regDate DESC )"
					+ ") WHERE r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				admin_MessageList = new ArrayList(end);
				do {
					Admin_MessageDTO dto = new Admin_MessageDTO();
					dto.setMessage_num(rs.getInt("message_num"));
					dto.setWriter(rs.getString("writer"));
					dto.setStore_id(rs.getString("store_id"));
					dto.setBrandno(rs.getInt("brandno"));
					dto.setBrandname(rs.getString("brandname"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setRegDate(rs.getTimestamp("regDate"));
					dto.setMimg(rs.getString("mimg"));
					dto.setStatus(rs.getInt("status"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
					admin_MessageList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) { ex.printStackTrace();
		} finally {	 oracleClose();	}
		return admin_MessageList;
	}

	// 관리자의 모든 보낸 메시지 개수 카운트 소진 작성
	public int getAdminMessageCount() {
		int result = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from admin_message"); //
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception ex) { ex.printStackTrace();
		} finally {	oracleClose();	}
		return result;
	}
}
