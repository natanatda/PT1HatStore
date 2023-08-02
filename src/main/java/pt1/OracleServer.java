package pt1;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class OracleServer {
	protected Connection conn=null; //연결
	protected PreparedStatement pstmt = null; //query 작성 및 실행
	protected ResultSet rs= null; // 결과 추출
	protected String sql = null; //sql문 작성
	
	protected Connection getConnection() {
		try {
			//1. DB 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//2. DB 로그인
			String user="team03";
			String pass="team";
			String dburl="jdbc:oracle:thin:@192.168.219.123:1521:orcl"; //jdbc:oracle:thin:는 드라이버 이름
			conn = DriverManager.getConnection(dburl, user, pass);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	protected void oracleClose() { //6. 연결 종료(close)
		if(rs != null) {try {rs.close();}catch(Exception se) {}}
		if(pstmt != null) {try {pstmt.close();}catch(Exception se) {}}
		if(conn != null) {try {conn.close();}catch(Exception se) {}}
	}
}
