<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.PaymentDAO" %>

<%
	int payment_id = Integer.parseInt(request.getParameter("payment_id"));	
	PaymentDAO dao = PaymentDAO.getInstance();
	
	dao.deletePay(payment_id);
%>
	<script>
		alert("삭제되었습니다.");
		location="payForm.jsp";
	</script>
	
	
	