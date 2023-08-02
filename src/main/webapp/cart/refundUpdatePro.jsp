<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Order_HistoryDAO" %>
<!DOCTYPE html>
<meta charset="UTF-8">

<%
	String status = request.getParameter("status");
	String level_num = (String)session.getAttribute("level_num");
	
	int order_history_id = Integer.parseInt(request.getParameter("order_history_id"));
	
	Order_HistoryDAO dao = Order_HistoryDAO.getInstance();
	if(!(level_num.equals("2"))){%>
		<script>
			alert("잘못되 접근입니다.");
			location="/pt1/main/main.jsp";
		</script>
	<%}
	if(status.equals("true")){
		dao.updateRefund(order_history_id);
		%>
		<script>
			alert("승인되었습니다.");
			location="/pt1/store/orderList.jsp";
		</script>
	<%}else if(status.equals("false")){
		dao.cancelRefund(order_history_id); %>
		<script>
			alert("취소되었습니다.");
			location="/pt1/store/orderList.jsp";
		</script>
	<%}

%>