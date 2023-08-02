<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Order_ChangeDAO" %>
<%@ page import="pt1.Order_ChangeDTO" %>
<!DOCTYPE html>
<%
	// 취소사유 보여주는 페이지
	String store = (String)session.getAttribute("stoId");
	
	int c_num = Integer.parseInt(request.getParameter("c_num"));
	int status = Integer.parseInt(request.getParameter("status"));
	
	Order_ChangeDAO dao = Order_ChangeDAO.getInstance();
	Order_ChangeDTO dto = dao.getContent(c_num); // 사유 보여주는 메서드 dto에 넣음
%>
<table border="1">
	<tr>
		<td>주문 번호</td>
		<td><%=dto.getC_num()%></td>
	</tr>
	<tr>
		<%if(status == 2){ %>
		<td>취소 사유</td>
		<%}%>
		<td><%=dto.getContent()%></td>
	</tr>
	 <br/>
	 <%if(store != null){ %>
	 <tr>
	 	<td colspan="2" align="right">
	 		<input type="button" value="승인" onclick="location='orderChangeUpdate.jsp?status=<%=status%>&order_history_id=<%=c_num%>'"/>
	 		<input type="button" value="취소" onclick="location='orderList.jsp'"/>
	 	</td> 
	 </tr>
	 <%} %>
</table>