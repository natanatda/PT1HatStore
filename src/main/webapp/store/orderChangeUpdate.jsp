<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Order_HistoryDAO" %>
<!DOCTYPE html>
<%
	
	int status = Integer.parseInt(request.getParameter("status")); // orderChangeContent.jsp 승인 링크에 있는 값들 불러오기
	int order_history_id = Integer.parseInt(request.getParameter("order_history_id"));
	
	String store = (String)session.getAttribute("stoId");
	
	Order_HistoryDAO dao = Order_HistoryDAO.getInstance();
	
	if(store != null){
		dao.updateFinal(status, order_history_id); %>
		<script>
			alert("승인되었습니다.");
			location="/pt1/store/orderList.jsp";
		</script>	
	<%}else{
%>
	<script>
		alert("잘못된 접근입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%} %>

