<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.DeliveryDAO" %>
<%@ page import="pt1.DeliveryDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<%
	String memid=(String)session.getAttribute("memId");		//회원 session
	List delivery_historyList=null;
	DeliveryDAO ddao =DeliveryDAO.getInstance();
	int payment_id = Integer.parseInt(request.getParameter("payment_id"));
	delivery_historyList = ddao.delivery_history(memid, payment_id);
%>
<head>
<title>배송 정보</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<% if(delivery_historyList ==null){ %>
<body>
<%@ include file="../header/listMember.jsp" %>
<h2>배송정보가 없습니다.</h2>
<%} else{ %>
<%@ include file="../header/listMember.jsp" %>
<h2>배송정보</h2>
	<table border="1">
		<tr>
			<%
			for (int i = 0; i < delivery_historyList.size(); i++) {
				DeliveryDTO dto = (DeliveryDTO) delivery_historyList.get(i);
			%>
			<td>
				수령인 :
				<%=dto.getRecipient_name()%></td>
			<td>
				배송번호 :
				<%=dto.getDelivery_id()%></td>
			<td>
				상품명 :
				<%=dto.getPname()%></td>
			<%
			if (dto.getStatus().equals("1")) {
			%>
			<td>배송상태 : 배송 준비중</td>
			<%
			} else if (dto.getStatus().equals("2")) {
			%>
			<td>배송상태 : 배송 중</td>
			<%
			} else if (dto.getStatus().equals("3")) {
			%>
			<td>배송상태 : 배송 완료</td>
			<%}%>
		</tr>
	</table>
	<%}%>
<%}%>
</body>
</html>