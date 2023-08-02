package pt1;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReplyDAO extends OracleServer {
	private static ReplyDAO instance = new ReplyDAO();

	public static ReplyDAO getInstance() {
		return instance;
	}

	private ReplyDAO() {
	}

	// 리뷰 입력
	public int insertReply(ReplyDTO dto) {
		int result = 0;
		try {
			conn = getConnection(); // 서버 연결
			sql = "insert into reply values(reply_seq.nextval,?,?,?,?,?,?,?,0,0,0,0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getProductNum());
			pstmt.setString(2, dto.getMemberId());
			pstmt.setTimestamp(3, dto.getRegDate());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setDouble(6, dto.getRating());
			pstmt.setString(7, dto.getRimg()); // 사용자가 업로드한 이미지를 서버에 등록한 이름

			pstmt.executeUpdate();
			result = 1;
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	// 상품번호에 맞는 리뷰 개수를 불러오는 메서드
	public int getReplyCount(int productNum) {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from reply where productNum=?"); //
			pstmt.setInt(1, productNum);
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

	// 내리뷰 개수
	public int getMyReplyCount(String memberId) {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from reply where memberId=?"); //
			pstmt.setString(1, memberId);
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

	// 상품번호에 맞는 리뷰목록
	public List getReplys(int productNum, int start, int end) {
		List replyList = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select replyNum,productNum,memberId,regDate,subject,content,rating,rimg,recommend, r from"
							+ "(select replyNum,productNum,memberId,regDate,subject,content,rating,rimg,recommend, rownum r from "
							+ "(select * from reply order by regDate desc )) where productNum=? and r >= ? and r <= ?");
			pstmt.setInt(1, productNum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				replyList = new ArrayList(end);
				do {
					ReplyDTO dto = new ReplyDTO();
					dto.setReplyNum(rs.getInt("replyNum"));
					dto.setProductNum(rs.getInt("productNum"));
					dto.setMemberId(rs.getString("memberId"));
					dto.setRegDate(rs.getTimestamp("regDate"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setRating(rs.getDouble("rating"));
					dto.setRimg(rs.getString("rimg"));
					dto.setRecommend(rs.getInt("recommend"));
					replyList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return replyList;
	}

	// 내 리뷰 넣은 리스트
	public List getMyReplys(String memberId, int start, int end) {
		List replyList = null;
		try {
			conn = getConnection();
			pstmt = conn
					.prepareStatement("select replyNum,productNum,memberId,regDate,subject,content,rating,rimg,recommend, r from"
							+ "(select replyNum,productNum,memberId,regDate,subject,content,rating,rimg,recommend, rownum r from "
							+ "(select * from reply order by regDate desc )) where memberId=? and r >= ? and r <= ?");
			pstmt.setString(1, memberId);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				replyList = new ArrayList(end);
				do {
					ReplyDTO dto = new ReplyDTO();
					dto.setReplyNum(rs.getInt("replyNum"));
					dto.setProductNum(rs.getInt("productNum"));
					dto.setMemberId(rs.getString("memberId"));
					dto.setRegDate(rs.getTimestamp("regDate"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setRating(rs.getDouble("rating"));
					dto.setRimg(rs.getString("rimg"));
					dto.setRecommend(rs.getInt("recommend"));
					replyList.add(dto);
				} while (rs.next());
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return replyList;
	}

	// 특정 리뷰에 대한 정보를 불러옴
	public ReplyDTO getReply(int replyNum) {
		ReplyDTO dto = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select replyNum,productNum,memberId,regDate,subject,content,rating,rimg,recommend from reply where replyNum = ?");
			pstmt.setInt(1, replyNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new ReplyDTO();
				dto.setReplyNum(rs.getInt("replyNum"));
				dto.setProductNum(rs.getInt("productNum"));
				dto.setMemberId(rs.getString("memberId"));
				dto.setRegDate(rs.getTimestamp("regDate"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRating(rs.getDouble("rating"));
				dto.setRimg(rs.getString("rimg"));
				dto.setRecommend(rs.getInt("recommend"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}
	//내가쓴 리뷰 불러오기
	public ReplyDTO getMyReply(int replyNum) {
		ReplyDTO dto = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select replyNum,productNum,memberId,regDate,subject,content,rating,rimg,recommend from reply where replyNum = ?");
			pstmt.setInt(1, replyNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new ReplyDTO();
				dto.setReplyNum(rs.getInt("replyNum"));
				dto.setProductNum(rs.getInt("productNum"));
				dto.setMemberId(rs.getString("memberId"));
				dto.setRegDate(rs.getTimestamp("regDate"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRating(rs.getDouble("rating"));
				dto.setRimg(rs.getString("rimg"));
				dto.setRecommend(rs.getInt("recommend"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}

	// 수정할 게시글 불러오기
	/*
	 * public ReplyDTO updateGetReply(int replyNum){ ReplyDTO dto=null; try { conn =
	 * getConnection(); pstmt =
	 * conn.prepareStatement("select * from reply where replyNum = ?"); //reply에서
	 * replyNum에 맞는 모든 값부르기 pstmt.setInt(1, replyNum); rs = pstmt.executeQuery();
	 * //쿼리 실행 if (rs.next()) { // dto = new ReplyDTO(); //dto객체 생성
	 * dto.setReplyNum(rs.getInt("replyNum"));
	 * dto.setProductNum(rs.getInt("productNum"));
	 * dto.setMemberId(rs.getString("memberId"));
	 * dto.setRegDate(rs.getTimestamp("regDate"));
	 * dto.setSubject(rs.getString("subject"));
	 * dto.setContent(rs.getString("content"));
	 * dto.setRating(rs.getDouble("rating")); dto.setRimg(rs.getString("rimg")); } }
	 * catch(Exception ex) { ex.printStackTrace(); } finally { oracleClose(); }
	 * return dto; }
	 */
	// 리뷰 업데이트(수정)하는 메서드
	/*
	 * public void updateReply(ReplyDTO dto) { try { conn = getConnection(); pstmt
	 * =conn.
	 * prepareStatement("update reply set productNum=?, content=?,  Rating=? , rimg=? where replyNum=?"
	 * ); pstmt.setInt(1, dto.getProductNum()); pstmt.setString(2,
	 * dto.getContent()); pstmt.setDouble(3, dto.getRating()); pstmt.setString(4,
	 * dto.getRimg()); pstmt.setInt(5, dto.getReplyNum()); pstmt.executeUpdate();
	 * }catch(Exception e) { e.printStackTrace(); }finally { oracleClose(); } }
	 */
	// 내가 쓴 글삭제
	public int deleteReply(int replyNum, String memberId) {
		String dbId = "";
		int x = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select memberId from reply where replyNum = ?"); // 글번호에 맞는 작성자 부르기
			pstmt.setInt(1, replyNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbId = rs.getString("memberId"); // 게시글 작성자를 dbId에 대입
				if (dbId.equals(memberId)) { // 게시글 작성자가 본인일 경우
					pstmt = conn.prepareStatement("delete from reply where replyNum=?");
					pstmt.setInt(1, replyNum);
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

	// 관리자가 게시글 삭제
	public int admDeleteReply(String admid, int replyNum) {
		int x = -1;
		try {
			if (admid != null) {
				conn = getConnection();
				pstmt = conn.prepareStatement("delete from reply where replyNum=?");
				pstmt.setInt(1, replyNum);
				pstmt.executeUpdate();
				x = 1;
			} else {
				x = 0;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}

	// 게시물 추천
	public int like(int replyNum) {
		int result = 0;
		try {
			conn = getConnection();
			sql = "UPDATE reply SET recommend = recommend + 1 WHERE replyNum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyNum);
			pstmt.executeUpdate();
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	// 게시물 추천취소
	public int unlike(int replyNum) {
		int result = 0;
		try {
			conn = getConnection();
			String SQL = "UPDATE reply SET recommend = recommend - 1 WHERE replyNum = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyNum);
			pstmt.executeUpdate();
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			oracleClose();
		}
		return result;
	}

	/*
	 * //store테이블 점주id에 맞는 store_name 꺼내고 public String getStore_name(String
	 * store_id){ System.out.println("메소드 getStore_name"+store_id); String
	 * store_name = null; try { conn = getConnection(); pstmt =
	 * conn.prepareStatement("select brandno from brand where store_id=?");
	 * pstmt.setString(1, store_id); rs = pstmt.executeQuery(); if (rs.next()) {
	 * store_name = rs.getString("store_name"); } } catch(Exception ex) {
	 * ex.printStackTrace(); } finally { oracleClose(); } return store_name; }
	 * //product테이블에서 brand(store_name)에 맞는 pnum 꺼내고 public int getPnum(String
	 * store_name){ System.out.println("메소드 getPnum"+store_name); int pnum = 0; try
	 * { conn = getConnection(); pstmt =
	 * conn.prepareStatement("select pnum from product where brand=?");
	 * pstmt.setString(1, store_name); rs = pstmt.executeQuery(); if (rs.next()) {
	 * pnum = rs.getInt("pnum"); } } catch(Exception ex) { ex.printStackTrace(); }
	 * finally { oracleClose(); } return pnum; } //reply테이블에서 productNum(pnum)에 맞는
	 * reply다꺼내기 public ReplyDTO getBrandReply(int pnum){ ReplyDTO dto=null; try {
	 * conn = getConnection(); pstmt = conn.
	 * prepareStatement("select replyNum,productNum,memberId,regDate,subject,content,rating,rimg,recommend from reply where productNum = ?"
	 * ); pstmt.setInt(1, pnum); rs = pstmt.executeQuery(); if (rs.next()) { dto =
	 * new ReplyDTO(); dto.setReplyNum(rs.getInt("replyNum"));
	 * dto.setProductNum(rs.getInt("productNum"));
	 * dto.setMemberId(rs.getString("memberId"));
	 * dto.setRegDate(rs.getTimestamp("regDate"));
	 * dto.setSubject(rs.getString("subject"));
	 * dto.setContent(rs.getString("content"));
	 * dto.setRating(rs.getDouble("rating")); dto.setRimg(rs.getString("rimg"));
	 * dto.setRecommend(rs.getInt("recommend")); } } catch(Exception ex) {
	 * ex.printStackTrace(); } finally { oracleClose(); } return dto; }
	 */
	
	//브랜드별 리뷰 리스트
	public List getBrandReply(String startDate, String endDate, String store_id) {
		List BrandReplyList = new ArrayList();
		try {
			conn = getConnection();
			String sql = "SELECT R.REPLYNUM AS REPLYNUM," + "R.MEMBERID AS MEMBERID ," + "R.REGDATE AS REGDATE,"
					+ "R.CONTENT AS CONTENT," + "R.RATING AS RATING," + "R.RECOMMEND AS RECOMMEND"
					+ "FROM REPLY R, PRODUCT P, BRAND B"
					+ "WHERE R.PRODUCT_ID = P.PNUM AND P.BRANDNO = B.BRANDNO AND B.STORE_ID=? \""
					+ "GROUP BY R.REPLYNUM, R.MEMBERID, R.REGDATE, R.CONTENT, R.RATING, R.RECOMMEND \""
					+ "ORDER BY TRUNC(R.REGDATE) DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, store_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReplyDTO BrandReply = new ReplyDTO();
				BrandReply.setReplyNum(rs.getInt("replyNum"));
				BrandReply.setMemberId(rs.getString("memberId"));
				BrandReply.setRegDate(rs.getTimestamp("regDate"));
				BrandReply.setContent(rs.getString("content"));
				BrandReply.setRating(rs.getInt("rating"));
				BrandReply.setRecommend(rs.getInt("recommend"));
				BrandReplyList.add(BrandReply);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return BrandReplyList;
	}

	// 특정 점주의 모든 상품 리뷰 보기
	// reviewList.jsp 에서 사용
	public ArrayList<Map<String, Object>> getReviewList(int pageNum, String stoId) {
		ArrayList<Map<String, Object>> reviewList = new ArrayList<Map<String, Object>>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "SELECT * FROM " + "(SELECT ROWNUM AS rnum, r.* FROM " + "(SELECT * FROM reply r, product p "
					+ "WHERE r.PRODUCTNUM = p.PNUM AND p.BRANDNO IN "
					+ "(SELECT b.BRANDNO FROM brand b WHERE b.STORE_ID = ?) " + "ORDER BY r.REGDATE DESC) r) "
					+ "WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> review = new HashMap<String, Object>();
				review.put("replyNum", rs.getInt("REPLYNUM"));
				review.put("productNum", rs.getInt("PRODUCTNUM"));
				review.put("memberId", rs.getString("MEMBERID"));
				review.put("regDate", rs.getTimestamp("REGDATE"));
				review.put("subject", rs.getString("SUBJECT"));
				review.put("content", rs.getString("CONTENT"));
				review.put("rating", rs.getDouble("RATING"));
				review.put("rimg", rs.getString("RIMG"));
				review.put("ref", rs.getInt("REF"));
				review.put("re_step", rs.getInt("RE_STEP"));
				review.put("re_level", rs.getInt("RE_LEVEL"));
				review.put("recommend", rs.getInt("RECOMMEND"));
				review.put("pname", rs.getString("PNAME"));

				reviewList.add(review);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return reviewList;
	}

	// 특정 점주의 리뷰 수
	// reviewList.jsp 에서 사용
	public int getReviewCount(String stoId) {
		int count = 0;
		try {
			conn = getConnection();
			sql = "SELECT count(*) FROM reply r, product p, brand b " + "WHERE r.PRODUCTNUM = p.PNUM "
					+ "AND p.BRANDNO = b.BRANDNO " + "AND b.STORE_ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return count;
	}

	// 특정 점주의 모든 브랜드명
	// reviewList.jsp 에서 사용
	/*
	 * public List<String> getBrandListByStoreId(String stoId){ List<String>
	 * brandList = new ArrayList<>(); try { conn=getConnection();
	 * sql="SELECT BRAND FROM BRAND WHERE STORE_ID = ?"; pstmt =
	 * conn.prepareStatement(sql); pstmt.setString(1,stoId);
	 * rs=pstmt.executeQuery(); while(rs.next()) { String brand =
	 * rs.getString("BRAND"); brandList.add(brand); } }catch(Exception ex) {
	 * ex.printStackTrace(); }finally{ oracleClose(); } return brandList; }
	 */
	public ArrayList<BrandDTO> getBrandList(String stoId) {
		ArrayList<BrandDTO> list = new ArrayList<>();
		try {
			conn = getConnection();
			sql = "SELECT BRANDNO, BRAND FROM BRAND WHERE STORE_ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stoId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BrandDTO dto = new BrandDTO();
				dto.setBrandNo(rs.getInt("brandNo"));
				dto.setBrand(rs.getString("brand"));
				list.add(dto);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return list;
	}

	// 특정 점주 브랜드번호에 따른 리뷰 목록
	// reviewList.jsp 에서 사용
	public ArrayList<Map<String, Object>> getReviewList(int pageNum, int brandno) {
		ArrayList<Map<String, Object>> reviewList = new ArrayList<Map<String, Object>>();
		int start = (pageNum - 1) * 50 + 1;
		int end = pageNum * 50;
		try {
			conn = getConnection();
			sql = "SELECT * FROM " + "(SELECT ROWNUM AS rnum, r.* FROM " + "(SELECT * FROM reply r, product p "
					+ "WHERE r.PRODUCTNUM = p.PNUM AND p.BRANDNO IN "
					+ "(SELECT b.BRANDNO FROM brand b WHERE b.BRANDNO = ?) " + "ORDER BY r.REGDATE DESC) r) "
					+ "WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brandno);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				Map<String, Object> review = new HashMap<String, Object>();
				review.put("replyNum", rs.getInt("REPLYNUM"));
				review.put("productNum", rs.getInt("PRODUCTNUM"));
				review.put("memberId", rs.getString("MEMBERID"));
				review.put("regDate", rs.getTimestamp("REGDATE"));
				review.put("subject", rs.getString("SUBJECT"));
				review.put("content", rs.getString("CONTENT"));
				review.put("rating", rs.getDouble("RATING"));
				review.put("rimg", rs.getString("RIMG"));
				review.put("ref", rs.getInt("REF"));
				review.put("re_step", rs.getInt("RE_STEP"));
				review.put("re_level", rs.getInt("RE_LEVEL"));
				review.put("recommend", rs.getInt("RECOMMEND"));
				review.put("pname", rs.getString("PNAME"));
				reviewList.add(review);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return reviewList;
	}

	// 특정 점주의 특정 브랜드 리뷰 수
	// reviewList.jsp 에서 사용
	public int getReviewCount(int brandno) {
		int count = 0;
		try {
			conn = getConnection();
			sql = "SELECT count(*) FROM reply r, product p, brand b " + "WHERE r.PRODUCTNUM = p.PNUM "
					+ "AND p.BRANDNO = b.BRANDNO " + "AND b.brandno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brandno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return count;
	}

	// 모든 리뷰보기
	public List getAllReplys(int start, int end) {
	    List replyList = new ArrayList();
	    try {
	        conn = getConnection();
	        pstmt = conn.prepareStatement("select replyNum,productNum,memberId,regDate,subject,content,rating,rimg, r from"
	                + "(select replyNum,productNum,memberId,regDate,subject,content,rating,rimg, rownum r from "
	                + "(select * from reply order by regDate desc, productNum asc)) where r >= ? and r <= ?");
	        pstmt.setInt(1, start);
	        pstmt.setInt(2, end);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            ReplyDTO dto = new ReplyDTO();
	            dto.setReplyNum(rs.getInt("replyNum"));
	            dto.setProductNum(rs.getInt("productNum"));
	            dto.setMemberId(rs.getString("memberId"));
	            dto.setRegDate(rs.getTimestamp("regDate"));
	            dto.setSubject(rs.getString("subject"));
	            dto.setContent(rs.getString("content"));
	            dto.setRating(rs.getDouble("rating"));
	            dto.setRimg(rs.getString("rimg"));
	            replyList.add(dto);
	        }
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    } finally {
	        oracleClose();
	    }
	    return replyList;
	}

	// 모든 글 개수
	public int getAllReplyCount() {
		int x = 0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from reply"); //
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