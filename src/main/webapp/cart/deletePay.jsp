<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.PaymentDAO" %>

<%
	String memid=(String)session.getAttribute("memId");      //회원 session
	PaymentDAO dao = PaymentDAO.getInstance();
	
	dao.deletePayAll(memid);
%>
	<script>
		alert("전체삭제되었습니다.");
		location="payForm.jsp";
	</script>