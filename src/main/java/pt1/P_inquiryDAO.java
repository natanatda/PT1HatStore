package pt1;

import java.util.ArrayList;
import java.util.List;

public class P_inquiryDAO extends OracleServer {
	private static P_inquiryDAO instance = new P_inquiryDAO();

	public static P_inquiryDAO getInstance() {
		return instance;
	}

	private P_inquiryDAO() {
	}

	// 상품 문의글 올리는 메서드
	public void productInquiry(String user_id, int pnum, P_inquiryDTO dto) {
		int num = dto.getNum();
		int ref = dto.getRef();
		int ref_step = dto.getRef_step();
		int number = 0;
		try {
			conn = getConnection();
			sql = "select max(num) from p_inquiry";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = rs.getInt(1) + 1;
			} else {
				number = 1;
			}
			if (num != 0) {
				sql = "update p_inquiry set ref_step=ref_step+1 where ref = ? and ref_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, ref_step);
				pstmt.executeUpdate();
				ref_step = ref_step + 1;
				sql = "update p_inquiry set status = 1 where ref = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.executeUpdate();
			} else {
				ref = number;
				ref_step = 0;
			}
			sql = "select * from product where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				sql = "insert into p_inquiry (num, pnum, writer, subject, content, reg, ref, ref_step, brand, pname) "
						+ "values(p_inquiry_seq.NEXTVAL,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				pstmt.setString(2, user_id);
				pstmt.setString(3, dto.getSubject());
				pstmt.setString(4, dto.getContent());
				pstmt.setTimestamp(5, dto.getReg());
				pstmt.setInt(6, ref);
				pstmt.setInt(7, ref_step);
				pstmt.setString(8, rs.getString("brand"));
				pstmt.setString(9, rs.getString("pname"));
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

	// 상품 번호별로 문의글을 불러오는 메서드
	public List getP_inquiry(int pnum, int start, int end) {
		List inquiryList = null;
		try {
			conn = getConnection();
			sql = "select num,writer,subject,reg,ref,ref_step, content,status,brand,pname, r "
					+ "from (select num,writer,subject,reg,ref,ref_step,content,status,brand,pname, rownum r "
					+ "from (select * from p_inquiry where pnum=? order by ref desc, ref_step asc) order by ref desc, ref_step asc) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				inquiryList = new ArrayList(end);
				do {
					P_inquiryDTO dto = new P_inquiryDTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setRef(rs.getInt("ref"));
					dto.setRef_step(rs.getInt("ref_step"));
					dto.setContent(rs.getString("content"));
					dto.setStatus(rs.getInt("status"));
					dto.setBrand(rs.getString("brand"));
					dto.setPname(rs.getString("pname"));
					inquiryList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return inquiryList;
	}

	// 모든 상품 문의 내역 불러오는 메서드
	public ArrayList<P_inquiryDTO> getAllP_inquiry(int pageNum) {
		ArrayList<P_inquiryDTO> p_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select num,pnum,writer,subject,reg,ref,ref_step, content,status,brand,pname, r "
					+ "from (select num,pnum,writer,subject,reg,ref,ref_step,content,status,brand,pname, rownum r "
					+ "from (select * from p_inquiry order by ref desc, ref_step asc) order by ref desc, ref_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				P_inquiryDTO dto = new P_inquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRef(rs.getInt("ref"));
				dto.setRef_step(rs.getInt("ref_step"));
				dto.setContent(rs.getString("content"));
				dto.setStatus(rs.getInt("status"));
				dto.setBrand(rs.getString("brand"));
				dto.setPname(rs.getString("pname"));
				p_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return p_list;
	}

	// 브랜드별 문의내역 불러오는 메서드
	public ArrayList<P_inquiryDTO> getBran_inquiry(int pageNum, String brand) {
		ArrayList<P_inquiryDTO> p_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select num,pnum,writer,subject,reg,ref,ref_step, content,status,brand,pname, r "
					+ "from (select num,pnum,writer,subject,reg,ref,ref_step,content,status,brand,pname, rownum r "
					+ "from (select * from p_inquiry where brand=? order by ref desc, ref_step asc) order by ref desc, ref_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				P_inquiryDTO dto = new P_inquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRef(rs.getInt("ref"));
				dto.setRef_step(rs.getInt("ref_step"));
				dto.setContent(rs.getString("content"));
				dto.setStatus(rs.getInt("status"));
				dto.setBrand(rs.getString("brand"));
				dto.setPname(rs.getString("pname"));
				p_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return p_list;
	}

	// 상품별 문의내역 불러오는 메서드
	public ArrayList<P_inquiryDTO> getPro_inquiry(int pageNum, String pname) {
		ArrayList<P_inquiryDTO> p_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select num,pnum,writer,subject,reg,ref,ref_step, content,status,brand,pname, r "
					+ "from (select num,pnum,writer,subject,reg,ref,ref_step,content,status,brand,pname, rownum r "
					+ "from (select * from p_inquiry where pname=? order by ref desc, ref_step asc) order by ref desc, ref_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				P_inquiryDTO dto = new P_inquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRef(rs.getInt("ref"));
				dto.setRef_step(rs.getInt("ref_step"));
				dto.setContent(rs.getString("content"));
				dto.setStatus(rs.getInt("status"));
				dto.setBrand(rs.getString("brand"));
				dto.setPname(rs.getString("pname"));
				p_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return p_list;
	}
	// 처리상태가 미처리인 문의내역 불러오는 메서드
	public ArrayList<P_inquiryDTO> getSta_inquiry(int pageNum) {
		ArrayList<P_inquiryDTO> p_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select num,pnum,writer,subject,reg,ref,ref_step, content,status,brand,pname, r "
					+ "from (select num,pnum,writer,subject,reg,ref,ref_step,content,status,brand,pname, rownum r "
					+ "from (select * from p_inquiry where status=0 order by ref desc, ref_step asc) order by ref desc, ref_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				P_inquiryDTO dto = new P_inquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRef(rs.getInt("ref"));
				dto.setRef_step(rs.getInt("ref_step"));
				dto.setContent(rs.getString("content"));
				dto.setStatus(rs.getInt("status"));
				dto.setBrand(rs.getString("brand"));
				dto.setPname(rs.getString("pname"));
				p_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return p_list;
	}

	// 드롭다운 메뉴에 현재 있는 브랜드명만 보이게 하기위한 메서드
	public ArrayList<P_inquiryDTO> selectBran() {
		ArrayList<P_inquiryDTO> p_list = new ArrayList<>();
		try {
			conn = getConnection();
			sql = "select distinct brand from p_inquiry"; // 중복제거하고 검색
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				P_inquiryDTO dto = new P_inquiryDTO();
				dto.setBrand(rs.getString("brand"));
				p_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return p_list;
	}

	// 드롭다운 메뉴에 현재 있는 상품명만 보이게 하기위한 메서드
	public ArrayList<P_inquiryDTO> selectPro() {
		ArrayList<P_inquiryDTO> p_list = new ArrayList<>();
		try {
			conn = getConnection();
			sql = "select distinct pname from p_inquiry"; // 중복제거하고 검색
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				P_inquiryDTO dto = new P_inquiryDTO();
				dto.setPname(rs.getString("pname"));
				p_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return p_list;
	}

	// 문의 글 갯수 확인하는 메서드
	public int getP_inquiryCount(int pnum) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from p_inquiry where pnum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
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

	// 문의 글 내용 불러오는 메서드
	public P_inquiryDTO getContent(int num) {
		P_inquiryDTO dto = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from p_inquiry where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new P_inquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRef(rs.getInt("ref"));
				dto.setRef_step(rs.getInt("ref_step"));
				dto.setContent(rs.getString("content"));
				dto.setStatus(rs.getInt("status"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}

	// 모든 문의 글 갯수 확인하는 메서드
	public int allCount() {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from p_inquiry";
			pstmt = conn.prepareStatement(sql);
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

	// 브랜드 문의 글 갯수 확인하는 메서드
	public int brandCount(String brand) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from p_inquiry where brand=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
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

	// 상품명 문의 글 갯수 확인하는 메서드
	public int pnameCount(String pname) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from p_inquiry where pname =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
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

	// 상태별 문의 글 갯수 확인하는 메서드
	public int statusCount() {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from p_inquiry where status=0 and ref_step = 0";
			pstmt = conn.prepareStatement(sql);
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
	// 상태별 문의 글 갯수 확인하는 메서드
	public int b_statusCount(String brand) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from p_inquiry where status=0 and ref_step = 0 and brand=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, brand);
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
	// 상태별 문의 글 갯수 확인하는 메서드
	public int p_statusCount(String pname) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select count(*) from p_inquiry where status=0 and ref_step = 0 and pname=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
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

	// 글 삭제하는 메서드
	public void deleteInquiry(int num, int ref) {
		int result = -1;
		try {
			conn = getConnection();
			sql = "delete from p_inquiry where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			if (result == 1) {
				sql = "select count(*) from p_inquiry where ref=?"; // 글 번호로 삭제했는데 그룹이 남아있으면
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					sql = "update p_inquiry set status = 0 where ref=?"; // 그 글 그룹은 다시 미처리(0)로 변경
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, ref);
					pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

	// 답변만 불러오는 메서드
	public List answerInquiry(int ref) {
		List list = new ArrayList();
		P_inquiryDTO dto = null;
		try {
			conn = getConnection();
			sql = "select * from p_inquiry where ref = ? and ref_step > 0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto = new P_inquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setPnum(rs.getInt("pnum"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRef(rs.getInt("ref"));
				dto.setRef_step(rs.getInt("ref_step"));
				dto.setContent(rs.getString("content"));
				dto.setStatus(rs.getInt("status"));
				list.add(dto);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}

		return list;
	}

	// 유저가 삭제하면 답글도 같이 삭제
	public void user_d_inquiry(int ref) {
		try {
			conn = getConnection();
			sql = "delete from p_inquiry where ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

	// 내 문의글을 불러오는 메서드
	public List getMyp_Inquiry(String id, int start, int end) {
		List myInquiryList = null;
		try {
			conn = getConnection();
			sql = "select num,pnum,writer,subject,reg,ref,ref_step, content,status,brand,pname, r "
					+ "from (select num,pnum,writer,subject,reg,ref,ref_step,content,status,brand,pname, rownum r "
					+ "from (select * from p_inquiry where writer=? order by ref desc, ref_step asc) order by ref desc, ref_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				myInquiryList = new ArrayList(end);
				do {
					P_inquiryDTO dto = new P_inquiryDTO();
					dto.setNum(rs.getInt("num"));
					dto.setPnum(rs.getInt("pnum"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setRef(rs.getInt("ref"));
					dto.setRef_step(rs.getInt("ref_step"));
					dto.setContent(rs.getString("content"));
					dto.setStatus(rs.getInt("status"));
					dto.setBrand(rs.getString("brand"));
					dto.setPname(rs.getString("pname"));
					myInquiryList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}

		return myInquiryList;
	}

	// 내 게시글 갯수 확인하는 메서드
	public int getMyp_InquiryCount(String id) {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from p_inquiry where writer=?");
			pstmt.setString(1, id);
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

}
