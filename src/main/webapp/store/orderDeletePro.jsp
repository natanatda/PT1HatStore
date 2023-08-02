<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Order_HistoryDAO" %>
<!DOCTYPE html>

<%
	Order_HistoryDAO dao = Order_HistoryDAO.getInstance();
	int order_history_id = Integer.parseInt(request.getParameter("order_history_id"));
	String store = (String)session.getAttribute("stoId");
	
	if(store != null){
		dao.deleteOrder(order_history_id);
%>
	<script>
		alert("삭제되었습니다.");
		location="/pt1/store/orderList.jsp";
	</script>
	<%}else{%>
	<script>
		alert("잘못된 접근입니다.");
		location="/pt1/main/main.jsp";
	</script>

<%} %>
