<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.PaymentDAO" %>

<%
	String memid=(String)session.getAttribute("memId");   //고객
	PaymentDAO dao = PaymentDAO.getInstance();
	dao.deleteLastProduct(memid);
%>
<script>
	location="/pt1/main/main.jsp";
</script>