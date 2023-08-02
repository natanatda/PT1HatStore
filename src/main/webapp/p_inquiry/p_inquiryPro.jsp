<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.P_inquiryDAO" %>
<%@ page import="pt1.P_inquiryDTO" %>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
	<jsp:useBean id="dto" class="pt1.P_inquiryDTO" />
	<jsp:setProperty name="dto" property="*" /> 

<%
	dto.setReg(new Timestamp(System.currentTimeMillis()));
	
	P_inquiryDAO dao = P_inquiryDAO.getInstance();
	
	// 각 세션 불러옴
	String user_id = (String)session.getAttribute("memId");
	String store = (String)session.getAttribute("stoId");
	
	int pnum = Integer.parseInt(request.getParameter("pnum")); // 문의글 올리고 디테일 페이지로 돌아가기 위해 상품번호 불러옴
	
	if(user_id != null){ // 로그인 한 세션아이디값으로 글 작성 (writer 대입해주기 위해서)
		dao.productInquiry(user_id, pnum, dto);%>
		<script>
			alert("문의글을 올렸습니다.");
		 	location="/pt1/productDetail/pdMainForm.jsp?pnum=<%=pnum%>";
		</script>
<%
	}else if(store != null){ // 점주는 답변 올리고 상품 문의 내역 페이지로 이동
		dao.productInquiry(store, pnum, dto); %>
		<script>
			alert("답변을 올렸습니다.");
		 	location="/pt1/p_inquiry/storeinquiryList.jsp";
		</script>
<%
	}else{
%>
	<script>
		alert("잘못된 접근입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%} %>