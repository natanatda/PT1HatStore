<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.CartDAO" %>
<!DOCTYPE html>
<%
	CartDAO dao = CartDAO.getInstance();
	
	String user_id = (String)session.getAttribute("memId"); // 회원 세션 불러옴
	
	int quantity = Integer.parseInt(request.getParameter("quantity")); // form에서 링크로 넘겨받은 값 변수에 대입
	int cart_id = Integer.parseInt(request.getParameter("cart_id"));
	
	int result = 0; // 결과 여부를 나타내기 위한 변수 (1 => 성공)
	
	if(user_id != null){
		result = dao.updateQuantity(quantity, cart_id, user_id);
	}else{%>
		<script>
		alert("잘못된 접근입니다.");
		location="/pt1/member/logintForm.jsp";
	</script>
	<%}%>
	<%if(result == 1){
%>
	  <script>
		alert("수정되었습니다.");
		location="/pt1/cart/cartForm.jsp";
	</script>
	 
	<%}%>