<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.Order_HistoryDAO" %>
<%@ page import="pt1.Order_HistoryDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat"  %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	//점주 여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	NumberFormat nf = NumberFormat.getCurrencyInstance();
	// copy = productList.jsp	

	//페이지 구성
	int pageSize = 50;
	int count=0; //글 개수
	int currentPage=0;
    int number=0;//행 번호 출력
	List o_list=null; 
	List bran = null; // 드롭다운 메뉴에 현재 있는 브랜드만 출력하기 위한 리스트
	List sta = null; // 드롭다운 메뉴에 현재 있는 처리상태만 출력하기 위한 리스트
	Order_HistoryDAO dao = Order_HistoryDAO.getInstance();
	
	ArrayList<Order_HistoryDTO> list = null;
	
	int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
   	int s_status = (request.getParameter("s_status") == null) ? 11 : Integer.parseInt(request.getParameter("s_status"));
  	//s_staatus의 값을 가져오는데 null이면 10, null이 아니면 s_status 가져오기 (null이면 오류 발생..)
    String brand = request.getParameter("brand");
	
    // 브랜드가 null이거나 ""일 때 모든 주문 정보 리스트에 저장 s_status는 기본값 10
    if(brand == null || brand == "" && s_status == 11){
    	o_list = dao.getList(pageNum ,stoId);
    	count = dao.allCount(stoId);
    // 브랜드 선택했을 때 선택한 브랜드 기준으로 검색한 결과 리스트에 저장
    }else if(brand != null && s_status == 11){ 
    	o_list = dao.getBrandHistory(pageNum, brand, stoId);
    	count = dao.allCount(stoId, brand);
    // 처리상태별로 검색했을 때 선택한 처리상태 기준으로 검색한 결과 리스트에 저장
    }if(s_status != 11 && brand == null){
		o_list = dao.getStatusHistory(pageNum, s_status, stoId);
		count = dao.allCount(stoId, s_status);
	}
	bran = dao.selectBran(stoId);
	sta = dao.selectSta(stoId);
    number = count - (pageNum - 1) * pageSize;
	if(stoId == null && !(level_num.equals("2"))){
%>

	<script>
		alert("잘못된 접근입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%} %>
<body>
	<%@ include file="../header/listStore.jsp" %>
	<h2>주문관리</h2>
	<h3>
		주문 목록 (<%=count %>개)
	</h3>
	
	<b>브랜드로 검색</b>
	<form action="orderList.jsp?brand=<%=brand%>">
	<select name="brand">
		<option value="">전체보기</option>
	<%for(int i = 0; i < bran.size(); i++){
		Order_HistoryDTO dto = (Order_HistoryDTO)bran.get(i); %>
		<option value="<%=dto.getBrand()%>"><%=dto.getBrand() %> </option>
	<%}%>
	</select>
		<input type="submit" value="검색" />
	</form>
	<b>처리상태로 검색</b>
	<form action="orderList.jsp?s_status=<%=s_status%>">
	<select name="s_status">
		<option value="11">전체보기</option>
		<%for(int i = 0; i < sta.size(); i++){
			Order_HistoryDTO dto = (Order_HistoryDTO)sta.get(i); 
			int status = dto.getStatus();
			%>
		<option value=<%=status%>>
		<%if(status == 0){%>결제완료</option><%} %>
		<%if(status == 1){%>상품준비중</option><%} %>
		<%if(status == 2){%>주문취소</option><%} %>
		<%if(status == 3){%>배송중</option><%} %>
		<%if(status == 4){%>배송완료</option><%} %>
		<%if(status == 5){%>환불요청</option><%} %>
		<%if(status == 6){%>환불중</option><%} %>
		<%if(status == 7){%>환불실패</option><%} %>
		<%if(status == 8){%>환불완료</option><%} %>
		<%if(status == 9){%>구매확정</option><%} %>
		<%if(status == 10){%>완료</option><%} %>
		<%} %>
	</select>
		<input type="submit" value="검색" />
	</form>
	
	
	<table border="1" width="1200">
		<tr>
			<th width="50">번호</th>
			<th width="100">주문ID</th>
			<th width="100">상품번호</th>
			<th width="100">브랜드</th>
			<th width="50">수량</th>
			<th width="100">결제가격</th>
			<th width="200">배송지</th>
			<th width="100">전화번호</th>
			<th width="100">처리상태</th>
			<th width="200">주문일시</th>
			<th width="100">비고</th>
		</tr>
<%
	if(o_list != null){ // 브랜드를 선택해서 검색했을 때 실행
		//상품 정보 반복문으로 출력
		for(int i=0; i<o_list.size();i++){
			Order_HistoryDTO history = (Order_HistoryDTO)o_list.get(i); 
			int status = history.getStatus(); // status를 자주 사용하는데 너무 길어서 변수에 대입했습니다
%>
		<tbody>
			<tr>
				<td width="50" align="center"><%=number-- %></td>
				<td width="100" align="center"><%= history.getOrder_id() %>
				<br/><a href="orderContent.jsp?order_history_id=<%=history.getOrder_history_id()%>">주문내역</a>
				</td>
				<td width="100" align="center"><%= history.getProduct_id() %></td>
				<td width="100" align="center"><%= history.getBrand() %></td>
				<td width="50" align="center"><%= history.getQuantity() %></td>
				<td width="100" align="center">
				<%=nf.format(history.getPrice() * history.getQuantity()).replace("₩", "") + "원" %>
				</td>
				<td width="200" align="center"><%= history.getAddress() %></td>
				<td width="100" align="center"><%= history.getTel() %></td>
				<td width="100" align="center">
				<form action="o_historyUpdate.jsp">
				<select name="status">
					<option value="0" <%if(status == 0) {%>selected="selected"<%}%>>결제완료</option>
					<option value="1" <%if(status == 1) {%>selected="selected"<%}%>>상품준비중</option>
					<option value="2" <%if(status == 2) {%>selected="selected"<%}%>>주문취소</option>
					<option value="3" <%if(status == 3) {%>selected="selected"<%}%>>배송중</option>
					<option value="4" <%if(status == 4) {%>selected="selected"<%}%>>배송완료</option>
					
					<option value="5" <%if(status == 5) {%>selected="selected"<%}%>>환불요청</option>
					<option value="6" <%if(status == 6) {%>selected="selected"<%}%>>환불중</option>
					<option value="7" <%if(status == 7) {%>selected="selected"<%}%>>환불실패</option>
					<option value="8" <%if(status == 8) {%>selected="selected"<%}%>>환불완료</option>
					
					<option value="9" <%if(status == 9) {%>selected="selected"<%}%>>구매확정</option>
					<option value="10" <%if(status == 10) {%>selected="selected"<%}%>>완료</option>
				</select>
					<%if(status == 2){%>									<%-- 링크 안에 주문번호, 상태값 같이 보냄 --%>
						<br/><a href="/pt1/store/orderChangeContent.jsp?c_num=<%=history.getOrder_history_id()%>&status=<%=status%>">취소사유</a>
					<%}if(status == 5){ %>
						<br/><a href="/pt1/cart/repayContent.jsp?c_num=<%=history.getOrder_history_id()%>&status=<%=status%>">환불사유</a>
					<%} %>
					<%if(status != 2){ %>
					<input type="hidden" name="order_history_id" value="<%=history.getOrder_history_id()%>"/>
					<input type="submit" value="변경" />
					<%} %>
				</td>
				</form>
				<td width="200" align="center"><%= sdf.format(history.getCreated_at()) %></td>
				<td width="100" align="center">
				<input type="button" value="삭제" onclick="location='orderDeletePro.jsp?order_history_id=<%=history.getOrder_history_id()%>'"/></td>
			</tr></tbody>
			<%} %>			
			<%}%>
			</table>
	<div>
		<%
      	//하단에 페이지 처리
         int totalPage = (int)(dao.countHistory() / 50)+1; 
         if(totalPage >= 0) {
            if(pageNum > 1) { %>
		<a href="orderList.jsp?pageNum=<%= pageNum - 1 %>">[이전]</a>
		<% }
            for(int i = 1; i <= totalPage; i++) { %>
		<% if(i == pageNum) { %>
		<a href="orderList.jsp?pageNum=<%= i %>"><%= i %></a>
		<!-- <strong><%= i %></strong> -->
		<% } else { %>
		<a href="orderList.jsp?pageNum=<%= i %>"><%= i %></a>
		<% } %>
		<% }
            if(pageNum < totalPage) { %>
		<a href="orderList.jsp?pageNum=<%= pageNum + 1 %>">[다음]</a>
		<% }
         } %>

	</div>
</body>
</html>