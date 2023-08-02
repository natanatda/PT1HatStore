<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Order_HistoryDAO" %>
<!DOCTYPE html>
<%
	int status = Integer.parseInt(request.getParameter("status"));
	int order_history_id = Integer.parseInt(request.getParameter("order_history_id"));
	
	// 점주 세션 불러옴
	String store = (String)session.getAttribute("stoId");
	
	Order_HistoryDAO dao = Order_HistoryDAO.getInstance();
	
	// 점주 세션 이 있고 처리상태가 주문취소가 아니면 메서드 동작
	if(store != null && !(status == 2)){
		dao.updateStatus(status, order_history_id);
%>
	<script>
		alert("변경되었습니다.");
		location="/pt1/store/orderList.jsp";
	</script>
		
	<%}else if(status == 2){ // 주문취소 사유 작성하는 페이지로 이동
%>
	<script>		
		location="/pt1/store/orderChange.jsp?order_history_id=<%=order_history_id%>&status=<%=status%>";
	</script>
<%} else{%>
	<script>
		alert("잘못된 접근입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%} %>
