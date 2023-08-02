<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.InquiryDAO" %>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<%
	int num = Integer.parseInt(request.getParameter("num")); // deleteForm에서 hidden으로 보낸 값이나 링크에 포함되어있는 값을 불러옴
	int ref = Integer.parseInt(request.getParameter("ref"));
	
	String admin = (String)session.getAttribute("admId"); // 관리자 세션 불러옴
	String member = (String)session.getAttribute("memId"); // 회원 세션 불러옴
	String store = (String)session.getAttribute("stoId"); // 점주 세션 불러옴
	
	InquiryDAO dao = InquiryDAO.getInstance();
	
	if(member != null || store != null){ // 회원이나 점주가 삭제하면 글 그룹별로 삭제 (답글만 남겨놓을 순 없어서)
		dao.user_d_inquiry(ref); %>
	<script>
	 	alert("삭제되었습니다.");
	 	location="/pt1/inquiry/inquiryList.jsp"; // 회원이나 점주는 삭제하고 문의 리스트로 이동
	</script>
		
	<%}else if(admin != null){	// 관리자가 삭제하면 그 글만 삭제 (모든 글 삭제 가능하니까..)
		dao.deleteArticle(num,ref);%>
	<script>
	 	alert("삭제되었습니다."); 
	 	location="/pt1/inquiry/admininquiryList.jsp"; // 관리자는 삭제하면 문의 관리 페이지로 이동
	</script>
	<%}
%>
