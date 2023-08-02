<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="pt1.InquiryDAO" %>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dto" class="pt1.InquiryDTO"/>
<jsp:setProperty property="*" name="dto"/>
<!DOCTYPE html>
<%

	dto.setReg_date(new Timestamp(System.currentTimeMillis()));
	dto.setIp(request.getRemoteAddr()); // 자바 코드로 아이피 넣음(정확한 아이피는 아님!)
	
	// 각 세션 불러옴
	String member = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admId");
	String store = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	
	InquiryDAO dao = InquiryDAO.getInstance();
	
	if(level_num.equals("1")){ // 레벨 1 => 회원
		dto.setWriter(member); // 작성자에 회원 아이디 대입
		dao.insertInquiry(dto);
		
	}else if(level_num.equals("3")){ // 레벨 3 => 관리자
		dto.setWriter(admin); // 작성자에 관리자 아이디 대입
		dto.setCategory("답변"); // 문의유형 답변으로 대입
		dao.insertInquiry(dto);
		
	}else if(level_num.equals("2")){ // 레벨 2 => 점주
		dto.setWriter(store); // 작성자에 점주 아이디 대입
		dao.insertInquiry(dto);
	}else{%>
		<script>
			alert("잘못된 접근");
			location="inquiryList.jsp";
		</script>
<% 	}
	if(admin == null){
%>
	<script>
		alert("문의글을 올렸습니다.");
		location="/pt1/inquiry/inquiryList.jsp"; // 관리자가 아니면 문의글 올리고 일반 라스트로 이동
	</script>
<%}else{ %>
	<script>
		alert("답변을 올렸습니다.")
		location="/pt1/inquiry/admininquiryList.jsp"; // 관리자는 관리 리스트로 이동
	</script>
	<%} %>