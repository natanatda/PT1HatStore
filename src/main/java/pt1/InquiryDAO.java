package pt1;

import java.util.ArrayList;
import java.util.List;

public class InquiryDAO extends OracleServer {
	private static InquiryDAO instance = new InquiryDAO();

	public static InquiryDAO getInstance() {
		return instance;
	}

	private InquiryDAO() {
	}

	// 글 작성하는 메서드
	public void insertInquiry(InquiryDTO dto) {
		int num = dto.getNum(); // 글 번호
		int ref = dto.getRef(); // 글 그룹 (글 번호가 달라도 그룹끼리 묶여있음)
		int re_step = dto.getRe_step(); // 답글 (최근 답글이 1번~)
		int re_level = dto.getRe_level(); // 답글 : 1 / 답글의 답글 : 2 / 답글의 답글의 답글 : 3 ...
		int number = 0; // 글 그룹을 지정하기 위한 변수
		try {
			conn = getConnection();
			sql = "select max(num) from inquiry"; // 지금까지 생성된 글 번호 조회하는 쿼리
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				number = rs.getInt(1) + 1; 
			} else { 
				number = 1;
			}
			if (num != 0) { 
				sql = "update inquiry set re_step = re_step+1 where ref = ? and re_step > ?"; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
				sql = "update inquiry set status = 1 where ref = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.executeUpdate();
			} else {
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			sql = "insert into inquiry (num,writer,subject,reg_date,ref,re_step,re_level,content,category,ip) values(inquiry_seq.NEXTVAL,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setTimestamp(3, dto.getReg_date());
			pstmt.setInt(4, ref);
			pstmt.setInt(5, re_step);
			pstmt.setInt(6, re_level);
			pstmt.setString(7, dto.getContent());
			pstmt.setString(8, dto.getCategory());
			pstmt.setString(9, dto.getIp());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

	// 모든 게시글 갯수 확인하는 메서드
	public int getArticleCount() {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from inquiry");
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

	// 미처리 게시글 갯수 확인하는 메서드
	public int s_inquiryCount() {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from inquiry where status = 0 and re_step = 0");
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

	// 카테고리별 미처리 게시글 갯수 확인하는 메서드
	public int c_s_inquiryCount(String category) {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn
					.prepareStatement("select count(*) from inquiry where status = 0 and re_step = 0 and category=?");
			pstmt.setString(1, category);
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

	// 모든 게시글 갯수 확인하는 메서드
	public int cateCount(String category) {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from inquiry where category=?");
			pstmt.setString(1, category);
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

	// 내 게시글 갯수 확인하는 메서드
	public int getMyArticleCount(String id) {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from inquiry where writer=?");
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

	// 모든 문의글을 불러오는 메서드 ( 10개씩 )
	public List getArticles(int start, int end) {
		List articleList = null;
		try {
			conn = getConnection();
			sql = "select num,writer,subject,reg_date,ref,re_step,re_level,content,readcount,status,category, r "
					+ "from (select num,writer,subject,reg_date,ref,re_step,re_level,content,readcount, status,category, rownum r "
					+ "from (select * from inquiry order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				articleList = new ArrayList(end);
				do {
					InquiryDTO dto = new InquiryDTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
					dto.setContent(rs.getString("content"));
					dto.setStatus(rs.getInt("status"));
					dto.setCategory(rs.getString("category"));
					articleList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}

		return articleList;
	}

	// 모든 문의글 불러오는 메서드 (50개씩, 관리 페이지에서 사용)
	public ArrayList<InquiryDTO> getAllP_inquiry(int pageNum) {
		ArrayList<InquiryDTO> p_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select num,writer,subject,reg_date,readcount,ref,re_step,re_level, content,status,category, ip, r "
					+ "from (select num,writer,subject,reg_date,readcount,ref,re_step,re_level,content,status,category,ip, rownum r "
					+ "from (select * from inquiry order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				InquiryDTO dto = new InquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setContent(rs.getString("content"));
				dto.setStatus(rs.getInt("status"));
				dto.setCategory(rs.getString("category"));
				dto.setIp(rs.getString("ip"));
				p_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return p_list;
	}

	// 모든 문의글 불러오는 메서드 (50개씩, 관리 페이지에서 사용)
	public ArrayList<InquiryDTO> getCateinquiry(int pageNum, String category) {
		ArrayList<InquiryDTO> p_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select num,writer,subject,reg_date,readcount,ref,re_step,re_level, content,status,category, ip, r "
					+ "from (select num,writer,subject,reg_date,readcount,ref,re_step,re_level,content,status,category,ip, rownum r "
					+ "from (select * from inquiry where category=? order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				InquiryDTO dto = new InquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setContent(rs.getString("content"));
				dto.setStatus(rs.getInt("status"));
				dto.setCategory(rs.getString("category"));
				dto.setIp(rs.getString("ip"));
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
	public ArrayList<InquiryDTO> getSta_inquiry(int pageNum) {
		ArrayList<InquiryDTO> p_list = new ArrayList<>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "select num,writer,subject,reg_date,readcount,ref,re_step,re_level, content,status,category, ip, r "
					+ "from (select num,writer,subject,reg_date,readcount,ref,re_step,re_level,content,status,category,ip, rownum r "
					+ "from (select * from inquiry where status=0 order by ref desc, re_step asc) order by ref desc, re_step asc) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				InquiryDTO dto = new InquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setContent(rs.getString("content"));
				dto.setStatus(rs.getInt("status"));
				dto.setCategory(rs.getString("category"));
				dto.setIp(rs.getString("ip"));
				p_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return p_list;
	}

	// 드롭다운 메뉴에 현재 있는 카테고리만 보여주기 위한 메서드
	public ArrayList<InquiryDTO> getCategory() {
		ArrayList<InquiryDTO> cateList = new ArrayList<>();
		try {
			conn = getConnection();
			sql = "select distinct category from inquiry";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				InquiryDTO dto = new InquiryDTO();
				dto.setCategory(rs.getString("category"));
				cateList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return cateList;
	}


	// 내 문의글을 불러오는 메서드
	public List getMyInquiry(String id, int start, int end) {
		List articleList = new ArrayList();
		try {
			conn = getConnection();
			sql = "SELECT num, subject, writer, reg_date, status, r "
					+ "FROM (select num, subject, writer, reg_date, status, rownum r "
					+ "from (SELECT num, subject, writer, reg_date, status FROM inquiry WHERE writer=? UNION SELECT num, subject, writer, reg, status FROM p_inquiry WHERE writer=? order by reg_date desc ) ORDER BY reg_date DESC ) where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			pstmt.setInt(3, start); 
			pstmt.setInt(4, end);
			rs = pstmt.executeQuery(); 
			while (rs.next()) {
				InquiryDTO dto = new InquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setWriter(rs.getString("writer"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setStatus(rs.getInt("status"));
				articleList.add(dto);
			}
		} catch (

		Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}

		return articleList;
	}

	// 글 번호로 게시글을 불러오는 메서드 (조회수 +1)
	public InquiryDTO getArticle(int num) {
		InquiryDTO dto = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update inquiry set readcount=readcount+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select * from inquiry where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new InquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				dto.setContent(rs.getString("content"));
				dto.setCategory(rs.getString("category"));
				dto.setStatus(rs.getInt("status"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}

		return dto;
	}

	// 글 삭제하는 메서드
	public void deleteArticle(int num,int ref) {
		int result = 0;
		try {
			conn = getConnection();
			sql = "delete from inquiry where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			if (result == 1) {
				sql = "update inquiry set status = 0 where ref = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.executeUpdate();
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

	// 유저가 삭제하면 답변까지 같이 삭제 (글 그룹별로 삭제)
	public void user_d_inquiry(int ref) {
		try {
			conn = getConnection();
			sql = "delete from inquiry where ref=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
	}

	// 답변 불러오는 메서드
	public List answerArticle(int ref) {
		List list = new ArrayList();
		InquiryDTO dto = null;
		try {
			conn = getConnection();
			sql = "select * from inquiry where re_step > 0 and ref = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dto = new InquiryDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
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

}
//	// 같은 그룹인 게시글 중에 admin이라는 작성자가 있는 게시글1개를 불러오는 메서드(안 쓰는 중)
//	public InquiryDTO getAnswerArticle(int ref) {
//		InquiryDTO dto = null;
//		try {
//			conn = getConnection();
//			sql = "select * from inquiry where writer like '%admin%' and ref = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, ref);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				dto = new InquiryDTO();
//				dto.setNum(rs.getInt("num"));
//				dto.setWriter(rs.getString("writer"));
//				dto.setSubject(rs.getString("subject"));
//				dto.setReg_date(rs.getTimestamp("reg_date"));
//				dto.setReadcount(rs.getInt("readcount"));
//				dto.setRef(rs.getInt("ref"));
//				dto.setRe_step(rs.getInt("re_step"));
//				dto.setRe_level(rs.getInt("re_level"));
//				dto.setContent(rs.getString("content"));
//			}
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		} finally {
//			oracleClose();
//		}
//
//		return dto;
//	}

//	// 수정하기 전에 수정할 값들을 불러오는 메서드 (안 쓰는 중!)
//	public InquiryDTO updateGetArticle(int num) {
//		InquiryDTO article = null;
//		try {
//			conn = getConnection();
//			pstmt = conn.prepareStatement("select * from inquiry where num = ?");
//			pstmt.setInt(1, num);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				article = new InquiryDTO();
//				article.setNum(rs.getInt("num"));
//				article.setWriter(rs.getString("writer"));
//				article.setSubject(rs.getString("subject"));
//				article.setReg_date(rs.getTimestamp("reg_date"));
//				article.setReadcount(rs.getInt("readcount"));
//				article.setRef(rs.getInt("ref"));
//				article.setRe_step(rs.getInt("re_step"));
//				article.setRe_level(rs.getInt("re_level"));
//				article.setContent(rs.getString("content"));
//			}
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		} finally {
//			oracleClose();
//		}
//
//		return article;
//	}

//	// 글 수정하는 메서드 (안 쓰는 중!)
//	public void updateArticle(InquiryDTO dto) {
//		try {
//			conn = getConnection();
//			sql = "update inquiry set subject=?, content=? where num = ?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, dto.getSubject());
//			pstmt.setString(2, dto.getContent());
//			pstmt.setInt(3, dto.getNum());
//			pstmt.executeUpdate();
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		} finally {
//			oracleClose();
//		}
//	}
//	// 내 문의글을 불러오는 메서드
//	public List getMyArticles(String id, int start, int end) {
//		List articleList = null;
//		try {
//			conn = getConnection();
//			sql = "select num,writer,subject,reg_date,ref,re_step,re_level,content,readcount,status,category, r "
//					+ "from (select num,writer,subject,reg_date,ref,re_step,re_level,content,readcount,status,category,rownum r "
//					+ "from (select * from inquiry where writer=? order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ? ";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, id);
//			pstmt.setInt(2, start);
//			pstmt.setInt(3, end);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				articleList = new ArrayList(end);
//				do {
//					InquiryDTO dto = new InquiryDTO();
//					dto.setNum(rs.getInt("num"));
//					dto.setWriter(rs.getString("writer"));
//					dto.setSubject(rs.getString("subject"));
//					dto.setReg_date(rs.getTimestamp("reg_date"));
//					dto.setReadcount(rs.getInt("readcount"));
//					dto.setRef(rs.getInt("ref"));
//					dto.setRe_step(rs.getInt("re_step"));
//					dto.setRe_level(rs.getInt("re_level"));
//					dto.setContent(rs.getString("content"));
//					dto.setStatus(rs.getInt("status"));
//					dto.setCategory(rs.getString("category"));
//					articleList.add(dto);
//				} while (rs.next());
//			}
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		} finally {
//			oracleClose();
//		}
//
//		return articleList;
//	}