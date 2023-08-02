<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
	// 취소, 환불사유 선택하는 페이지
	int order_history_id = Integer.parseInt(request.getParameter("order_history_id"));
	int status = Integer.parseInt(request.getParameter("status"));
	String store = (String)session.getAttribute("stoId");
%>
	<h2>취소 사유를 선택해주세요</h2>	
	<form action="/pt1/store/orderChangePro.jsp">
		<%if(store == null){ %>
		<h2>단순 변심</h2>
			<input type="radio" name="change" value="상품이 마음에 들지 않음" />상품이 마음에 들지 않음 <br/>
			<input type="radio" name="change" value="더 저렴한 상품을 발견함" />더 저렴한 상품을 발견함
		<hr/><h2>상품 문제</h2>
			<input type="radio" name="change" value="상품의 구성품/부속품이 들어있지 않음" />상품의 구성품/부속품이 들어있지 않음<br/>
			<input type="radio" name="change" value="상품이 설명과 다름" />상품이 설명과 다름<br/>
			<input type="radio" name="change" value="상품이 파손되어 배송됨" />상품이 파손되어 배송됨<br/>
			<input type="radio" name="change" value="상품 결함/기능에 이상이 있음" />상품 결함/기능에 이상이 있음
		<hr/><h2>배송문제</h2>
			<input type="radio" name="change" value="다른 상품이 배송됨" />다른 상품이 배송됨<br/>
			<input type="radio" name="change" value="배송된 장소에 박스가 분실됨" />배송된 장소에 박스가 분실됨<br/>
			<input type="radio" name="change" value="다른 주소로 배송됨" />다른 주소로 배송됨<br/>
		<%}else{%> 
			<input type="radio" name="change" value="재고부족" />재고부족<br/>
			<input type="radio" name="change" value="판매중단" />판매중단<br/>
			<input type="radio" name="change" value="고객 요청" />고객 요청<br/>
			<%} %>
			<input type="hidden" name="order_history_id" value="<%=order_history_id%>"/>
			<input type="hidden" name="status" value="<%=status%>"/>
		<input type="submit" vlaue="제출" />
		<input type="button" value="취소" onclick="history.back()" />
		
	</form>
