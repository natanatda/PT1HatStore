<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="pt1.PaymentDTO" %>
<%@ page import="pt1.PaymentDAO" %>
<%@ page import="pt1.MemberDAO" %>
<%@ page import="pt1.MemberDTO" %>
<%@ page import="pt1.Payment_HistoryDTO" %>
<%@ page import="pt1.Payment_HistoryDAO" %>
<%@ page import="java.util.*" %>

<% String tel = request.getParameter("tel"); %>

<%
String paymentMethod = request.getParameter("paymentMethod");

if(paymentMethod != null && paymentMethod.equals("credit_card")){
	
    session.setAttribute("paymentMethod", "credit_card");
    response.sendRedirect("kakaoPayForm.jsp");
} else if(paymentMethod != null && paymentMethod.equals("bank_transfer")){
    // 다른 결제 방법 선택 처리
    session.setAttribute("paymentMethod", "bank_transfer");
    response.sendRedirect("kakaoPayForm.jsp");
} else{
	session.setAttribute("paymentMethod", "PayPal");
    response.sendRedirect("kakaoPayForm.jsp");
	
}%>
