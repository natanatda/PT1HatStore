<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.Order_HistoryDAO" %>
<%@ page import="pt1.Order_HistoryDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문조회</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	//점주 여부 체크
	String admin = (String)session.getAttribute("admId");
	String level_num = (String)session.getAttribute("level_num");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	// copy = productList.jsp	

	//페이지 구성
	int pageSize = 50;
	int count=0; //글 개수
	int currentPage=0;
    int number=0;//행 번호 출력
	List o_list=null; 
	List bran = null;
	List sta = null;
	Order_HistoryDAO dao = Order_HistoryDAO.getInstance();
	
	int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
   	int s_status = (request.getParameter("s_status") == null) ? 10 : Integer.parseInt(request.getParameter("s_status"));
  	//s_staatus의 값을 가져오는데 null이면 10, null이 아니면 s_status 가져오기 (null이면 오류 발생..)
    String brand = request.getParameter("brand");
	
    // 브랜드가 null이거나 ""일 때 모든 주문 정보 리스트에 저장 s_status는 기본값 10
    if(brand == null || brand == "" && s_status == 10){
    	o_list = dao.getHistory(pageNum);
    	count = dao.countHistory();
    // 브랜드 선택했을 때 선택한 브랜드 기준으로 검색한 결과 리스트에 저장
    }else if(brand != null && s_status == 10){ 
    	o_list = dao.getBrandHistory(pageNum, brand);
    	count = dao.countBrandHistory(brand);
    // 처리상태별로 검색했을 때 선택한 처리상태 기준으로 검색한 결과 리스트에 젖아
    }if(s_status != 10 && brand == null){
		o_list = dao.getStatusHistory(pageNum, s_status);
		count = dao.countStatusHistory(s_status);
	}
			
    number = count - (pageNum - 1) * pageSize;
    bran = dao.selectBran();
    sta = dao.selectStatus();
	if(admin == null && !(level_num.equals("3"))){
%>

	<script>
		alert("잘못된 접근입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%} %>
<body>
	<%@ include file="../header/listAdmin.jsp" %>
	<h3>
		주문 목록 (<%=count %>개)
	</h3>
	<b>브랜드로 검색</b>
	<form action="adminOrderList.jsp?brand=<%=brand%>">
	<select name="brand">
		<option value="">전체보기</option>
		<%for(int i = 0; i < bran.size(); i++){
			Order_HistoryDTO dto = (Order_HistoryDTO)bran.get(i);%>
		<option value="<%=dto.getBrand()%>"><%=dto.getBrand()%></option>
		<%}%>
	</select>
		<input type="submit" value="검색" />
	</form>
	
	<b>처리상태로 검색</b>
	<form action="adminOrderList.jsp?s_status=<%=s_status%>">
	<select name="s_status">
		<option value="10">전체보기</option>
		<%for(int i = 0; i < sta.size(); i++){
			Order_HistoryDTO dto = (Order_HistoryDTO)sta.get(i);
			int status = dto.getStatus();%>
		<option value="<%=status%>">
		<%if(status == 0){%>결제완료</option><%} %>
		<%if(status == 1){%>상품준비중</option><%} %>
		<%if(status == 2){%>주문취소</option><%} %>
		<%if(status == 3){%>배송중</option><%} %>
		<%if(status == 4){%>배송완료</option><%} %>
		<%if(status == 5){%>환불요청</option><%} %>
		<%if(status == 6){%>환불완료</option><%} %>
		<%if(status == 7){%>구매확정</option><%} %>
		<%if(status == 8){%>완료</option><%} %>
		<%} %>
		
	</select>
		<input type="submit" value="검색" />
	</form>
	
	
	<table border="1">
		<tr>
			<th >번호</th>
			<th >주문ID</th>
			<th >상품번호</th>
			<th >브랜드</th>
			<th >수량</th>
			<th >결제가격</th>
			<th >배송지</th>
			<th >전화번호</th>
			<th >처리상태</th>
			<th >주문일시</th>
			
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
				<td ><%=number-- %></td>
				<td ><%= history.getOrder_id() %>
				<br/><a href="/pt1/store/orderContent.jsp?order_history_id=<%=history.getOrder_history_id()%>">주문내역</a>
				</td>
				<td ><%= history.getProduct_id() %></td>
				<td ><%= history.getBrand() %></td>
				<td ><%= history.getQuantity() %></td>
				<td >
				<%= history.getPrice() * history.getQuantity()%>원
				</td>
				<td ><%= history.getAddress() %></td>
				<td ><%= history.getTel() %></td>
				<td >
					<%if(status == 0) {%>결제완료<%}%>
					<%if(status == 1) {%>상품준비중<%}%>
					<%if(status == 2) {%>주문취소<%}%>
					<%if(status == 3) {%>배송중<%}%>
					<%if(status == 4) {%>배송완료<%}%>
					<%if(status == 5) {%>환불요청<%}%>
					<%if(status == 6) {%>환불완료<%}%>
					<%if(status == 7) {%>구매확정<%}%>
					<%if(status == 8) {%>완료<%}%>					
				</td>
				</form>
				<td ><%= sdf.format(history.getCreated_at()) %></td>
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
		<a href="adminOrderList.jsp?pageNum=<%= pageNum - 1 %>">[이전]</a>
		<% }
            for(int i = 1; i <= totalPage; i++) { %>
		<% if(i == pageNum) { %>
		<a href="adminOrderList.jsp?pageNum=<%= i %>"><%= i %></a>
		<!-- <strong><%= i %></strong> -->
		<% } else { %>
		<a href="adminOrderList.jsp?pageNum=<%= i %>"><%= i %></a>
		<% } %>
		<% }
            if(pageNum < totalPage) { %>
		<a href="adminOrderList.jsp?pageNum=<%= pageNum + 1 %>">[다음]</a>
		<% }
         } %>

	</div>
</body>
</html>