<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.CartDAO" %>
<!DOCTYPE html>
<%
	CartDAO dao = CartDAO.getInstance();
	String user_id = (String)session.getAttribute("memId");
	dao.deleteAll(user_id);
	if(user_id == null){
%>
	<script>
		alert("잘못된 접근입니다.");
		history.go(-1);
	</script>
<%}else{%>
	<script>
		alert("삭제되었습니다.");
		location="/pt1/cart/cartForm.jsp";
	</script>
<%}%>