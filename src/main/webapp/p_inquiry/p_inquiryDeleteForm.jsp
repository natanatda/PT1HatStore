<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pnum = Integer.parseInt(request.getParameter("pnum")); 
	// 삭제하고 상품 설명 페이지로 돌아가기 위해 상품 번호 불러왔습니다.
	int ref = Integer.parseInt(request.getParameter("ref"));
	
	// 각 세션 불러옴
	String level_num = (String)session.getAttribute("level_num");
	String member  = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admId");
	String store = (String)session.getAttribute("stoId");
	
	if(member == null && admin == null && store == null && level_num == null){
%>
	<script>
		alert("잘못된 접근입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%} %>
<h2>삭제하시겠습니까?</h2>
   <form action="p_inquiryDeletePro.jsp">
   <input type="hidden" name="num" value="<%=num%>" />
   <input type="hidden" name="pnum" value="<%=pnum%>" />
   <input type="hidden" name="ref" value="<%=ref%>" />
   		<input type="submit" value="삭제" /> 
   		<input type="button" value="취소" onclick="history.go(-1)"/>   
   </form>

