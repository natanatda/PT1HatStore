<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import ="pt1.DeliveryDTO" %>
<%@ page import ="pt1.DeliveryDAO" %>
<%@ page import="java.util.List"  %>
<%@ page import="java.text.NumberFormat"  %>
<jsp:useBean id="dto" class="pt1.DeliveryDTO" />
<jsp:setProperty name="dto" property="*" />

<head>
<title>배송관리</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%request.setCharacterEncoding("utf-8"); %>
<%	
	 try{
	 List deliveryList  = null; 
	 String store_id=(String)session.getAttribute("stoId");	//점주 session	
	 Integer brandno=Integer.parseInt(request.getParameter("brandno"));     //deliveryCheck.jsp에서 넘겨받은 brandno를 brandno 변수에 대입
	 DeliveryDAO ddao=DeliveryDAO.getInstance();
	 deliveryList = ddao.deliveryListCheck(brandno);	//넘겨받은 brandno를 해당 메소드에 대입하여 일치하는 brandno의 데이터를 deliveryList에 대입
%> 
<body>
	<%@ include file="../header/listStore.jsp" %>
	<h2>배송관리</h2>
	<table border="1">
		<tr>
			<th>배송번호</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>수령인</th>
			<th>송장입력날짜</th>
			<th>배송 상태</th>
			<th>브랜드번호</th>
			<th>배송완료된 날짜</th>
		</tr>
	</tbody>
	<%	//
		for(int i=0; i< deliveryList.size(); i++){
			DeliveryDTO dto1 = (DeliveryDTO)deliveryList.get(i);%>
			<tr>
				<td><%=dto1.getDelivery_id() %></td>
				<td><%=dto1.getAddress() %></td>
				<td><%=dto1.getTel() %></td>
				<td><%=dto1.getRecipient_name() %></td>
				<td><%=dto1.getCreated_at()%></td>
				<td>
						<%-- if(배송준비 상태) --%>
						<% if(dto1.getStatus().equals("1")){%>
						배송상태 : 배송준비
						<%-- if(배송중 상태) --%>
						<%}else if(dto1.getStatus().equals("2")){ %>
						배송상태 : 배송중
						<%-- if(배송완료 상태) --%>
						<%}else if(dto1.getStatus().equals("3")){ %>
						배송상태 : 배송완료
						<%} %>
						<%-- 해당 배송 목록을 배송 준비 상태로 update함 --%>
						<form method="post" action="deliveryCheckPro_1.jsp">
							<input type="hidden" name="status" value="<%=dto1.getStatus()  %>">
							<input type="hidden" name="delivery_id" value="<%=dto1.getDelivery_id()  %>">
							<input type="hidden" name="brandno" value="<%=brandno  %>">
								<input type="submit" value="배송준비">
   						</form>
   						<%-- 해당 배송 목록을 배송 중 상태로 update함 --%>
   						<form method="post" action="deliveryCheckPro_2.jsp">
							<input type="hidden" name="status" value="<%=dto1.getStatus()  %>">
							<input type="hidden" name="delivery_id" value="<%=dto1.getDelivery_id()%>">
							<input type="hidden" name="brandno" value="<%=brandno  %>">
								<input type="submit" value="배송중">
   						</form>
   						<%-- 해당 배송 목록을 배송 완료 상태로 update함 --%>
   						<form method="post" action="deliveryCheckPro_3.jsp">
							<input type="hidden" name="status" value="<%=dto1.getStatus()  %>">
							<input type="hidden" name="delivery_id" value="<%=dto1.getDelivery_id()  %>">
							<input type="hidden" name="brandno" value="<%=brandno  %>">
								<input type="submit" value="배송완료">
   						</form>
				</td>
				<td><%=dto1.getBrandno()%></td>
				<td><%=dto1.getEnd_at()%></td>
			</tr>
		<%} %>
		<%} catch(Exception e){} %>
	</table>
</body>