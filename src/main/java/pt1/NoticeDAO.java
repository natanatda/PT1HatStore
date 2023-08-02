package pt1;

import java.util.ArrayList;
import java.util.List;


public class NoticeDAO extends OracleServer{
	private static NoticeDAO instance = new NoticeDAO();
	public static NoticeDAO getInstance() {
		return instance;
	}
	private NoticeDAO() {}
	
	//전체 글의 개수를 불러오는 메서드
	public int getNoticeCount(){	
		int x=0;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select count(*) from notice");	//
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x; 
	}
	//List만들어서 특정 게시글 넣어두기
	public List getNotices(int start, int end){
		List noticeList=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select num,writer, subject, category, content, reg, r from"+
					"(select num,writer, subject, category, content, reg,rownum r from "
					+ "(select * from notice order by reg desc)) where r >= ? and r <= ?");
			pstmt.setInt(1, start); 
			pstmt.setInt(2, end); 
			rs = pstmt.executeQuery();
			if (rs.next()) {
				noticeList = new ArrayList(end); 
				do{ 
					NoticeDTO dto= new NoticeDTO();
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setCategory(rs.getString("category"));
					dto.setContent(rs.getString("content"));
					dto.setReg(rs.getTimestamp("reg"));
					noticeList.add(dto); 
				}while(rs.next());
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return noticeList;
	}
	
	
	//특정 글에 대한 정보를 불러옴
	public NoticeDTO getNotice(int num){
		NoticeDTO dto=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from notice where num = ?"); 
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new NoticeDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setCategory(rs.getString("category"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return dto;
	}
	
	
	
	//새로운 글 작성하는 메서드
	public void insertNotice(NoticeDTO dto){
		try {
			conn = getConnection(); //서버 연결
			sql="insert into notice values(notice_seq.nextval,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getCategory());
			pstmt.setString(4, dto.getContent());
			pstmt.setTimestamp(5, dto.getReg());
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
	}
	
	//수정할 게시글 불러오기
	public NoticeDTO updateGetNotice(int num){
		NoticeDTO dto=null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from notice where num = ?"); //notice에서 num에 맞는 모든 값부르기
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();	//쿼리 실행
			if (rs.next()) {	//
				dto = new NoticeDTO();	//dto객체 생성
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setCategory(rs.getString("category"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}

		return dto;
	}
	//게시글 업데이트(수정)하는 메서드
	public void updateNotice(NoticeDTO dto,int num) {
		try {
			conn = getConnection();
			pstmt =conn.prepareStatement("update notice set writer=?, subject=?, category=?, content=? where num=?");
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getCategory());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5,num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			oracleClose();
		}
	}
	//게시글 삭제 메서드
	public int deleteNotice(int num, String writer){
		String dbwriter="";
		int x=-1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
			"select writer from notice where num = ?");	//글번호에 맞는 작성자 부르기
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbwriter= rs.getString("writer");	//게시글 작성자를 dbwriter에 대입
				if(dbwriter.equals("admin01") || dbwriter.equals("admin02") || dbwriter.equals("admin03")){	//게시글 작성자가 admin일때
					pstmt = conn.prepareStatement("delete from notice where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x= 1; 
				}else
					x= 0; 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			oracleClose();
		}
		return x;
	}
}