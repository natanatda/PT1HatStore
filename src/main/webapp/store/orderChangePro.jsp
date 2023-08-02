<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Order_ChangeDAO" %>
<%@ page import="pt1.Order_HistoryDAO" %>
<!DOCTYPE html>
<%
	// 취소, 환불 사유 작성 후 상태 변경하는 페이지
	
	request.setCharacterEncoding("utf-8");
	
	String content = request.getParameter("change");	
	
	int order_history_id = Integer.parseInt(request.getParameter("order_history_id"));
	int status = Integer.parseInt(request.getParameter("status"));
	
	Order_ChangeDAO change = Order_ChangeDAO.getInstance();
	Order_HistoryDAO history = Order_HistoryDAO.getInstance();
	
	int result = change.sendContent(order_history_id,content);
	
	if(result == 1){ // 정상적으로 보냈다면 상태 업데이트
		history.updateStatus(status, order_history_id);
%>
	<script>
		alert("요청이 처리되었습니다.");
		location="orderList.jsp";
	</script>
<%} %>
