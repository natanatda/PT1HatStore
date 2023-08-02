<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.P_inquiryDAO" %>
<%@ page import="pt1.P_inquiryDTO" %>
<!DOCTYPE html>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pnum = Integer.parseInt(request.getParameter("pnum")); 
	// 삭제하고 상품 설명 페이지로 돌아가기 위해 상품 번호 불러왔습니다.
	
	int ref = Integer.parseInt(request.getParameter("ref"));
	
	// 각 세션 불러옴
	String member = (String)session.getAttribute("memId");
	String store = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	
	P_inquiryDAO dao = P_inquiryDAO.getInstance();

	if(member != null && level_num.equals("1")){ // 글 그룹으로 모두 삭제
		dao.user_d_inquiry(ref);%>
	<script>
		alert("삭제되었습니다.");
		location="/pt1/productDetail/pdMainForm.jsp?pnum=<%=pnum%>"
	</script>
	<% }else if(store != null && level_num.equals("2")){
		dao.deleteInquiry(num, ref); %>
	<script> 
		alert("삭제되었습니다.");
		location="/pt1/p_inquiry/storeinquiryList.jsp";
	</script>	 
<%}else{%>
	<script>
		alert("잘못된 접근입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}%>

