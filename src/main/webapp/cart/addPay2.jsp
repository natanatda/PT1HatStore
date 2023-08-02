<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.PaymentDAO" %>
<%@ page import="pt1.PaymentDTO" %>
<%@ page import="pt1.Payment_HistoryDTO" %>
<%@ page import="pt1.Payment_HistoryDAO" %>

<%
	PaymentDAO dao = PaymentDAO.getInstance();
	//Payment_HistoryDAO ddao = Payment_HistoryDAO.getInstance();
	
	String user_id = (String)session.getAttribute("memId");
	int product_id = Integer.parseInt(request.getParameter("pnum"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	if(quantity > 0){
		dao.addPayment2(user_id, product_id, quantity);
%>
	<script>
		location="/pt1/cart/payForm.jsp";
	</script>
<%} %>
	