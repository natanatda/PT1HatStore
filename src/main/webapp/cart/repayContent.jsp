<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.RefundDAO" %>
<%@ page import="pt1.RefundDTO" %>
<%@ page import="java.text.NumberFormat"  %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	</head>
<%
	// 환불사유 보여주는 페이지
	String level_num = (String)session.getAttribute("level_num");
	String member = (String)session.getAttribute("memId");
	
	NumberFormat nf = NumberFormat.getCurrencyInstance();
	
	int c_num = Integer.parseInt(request.getParameter("c_num"));
	int status = Integer.parseInt(request.getParameter("status"));
	
	RefundDAO dao = RefundDAO.getInstance();
	RefundDTO dto = dao.findRefund(c_num);
	
	int price = dto.getPrice() * dto.getQuantity(); 
	
	if(!(level_num.equals("2")) && !(member.equals(dto.getUser_id())) ){ // 점주가 아니면서 주문 ID도 아닐때 동작 
%>
	<script>
		alert("잘못된 접근");
		location="/pt1/main/main.jsp";
	</script>
<%} %>
<body>
	<%if(level_num!=null){
		// level_num이 3일 경우 (레벨 3 =>관리자)
		if(level_num.equals("3")){%>
			<%@ include file="../header/listAdmin.jsp" %>
		<%
		//level_num이 2일 경우 (레벨 2 =>점주)
		} else if(level_num.equals("2")){ %>
			<%@ include file="../header/listStore.jsp" %>
		<%
		//level_num이 1일 경우 (레벨 1 =>회원)
		} else if(level_num.equals("1")){%>
            <%@ include file="../header/listMember.jsp" %>
		<%}
	}else{%>
		<%@ include file="../header/listGuest.jsp" %>
	<%} %>
<table border="1">
<h2>환불 신청 내역</h2>
	<tr>
		<td>주문 번호</td>
		<td><%=dto.getRefund_id()%></td>
	</tr>
	<tr>
		<td>주문 ID</td>
		<td><%=dto.getUser_id()%></td>
	</tr>
	<tr>
		<td>상품명</td>
		<td><%=dto.getPname() %></td>
	</tr>
	<tr>
		<td>수량</td>
		<td><%=dto.getQuantity() %></td>
	</tr>
	<tr>
		<td>가격</td>
		<td><%=nf.format(price).replace("₩", "") + "원"%></td>
	</tr>
	<tr>
		<td>환불사유</td>
		<td><%=dto.getRefundwhy() %></td>
	</tr>	
</table>
	<%if(level_num.equals("2")){ %>
	<input type="button" value="승인" onclick="location='/pt1/cart/refundUpdatePro.jsp?order_history_id=<%=c_num%>&status=true'" /> 
	<input type="button" value="취소" onclick="location='/pt1/cart/refundUpdatePro.jsp?order_history_id=<%=c_num%>&status=false'" />
	<%} %>
	<input type="button" value="돌아가기" onclick="history.back()" />
	</body>
</html>