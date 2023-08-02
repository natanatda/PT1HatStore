<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.CartDAO"%>
<%@ page import="pt1.CartDTO"%>

<%
	int cart_id = Integer.parseInt(request.getParameter("cart_id"));
	CartDAO dao = CartDAO.getInstance();
	dao.deleteCart(cart_id);
%>


<script>
	alert("삭제되었습니다.");
	location="cartForm.jsp";
</script>