<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.ProductListDAO" %>
<%@ page import="pt1.ProductListDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	//점주 여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))||stoId==null){%>
<script>
	alert("잘못된 경로입니다.");
	location = "/pt1/main/main.jsp";
</script>
<%}
	

	//페이지 구성
	int pageSize = 50;
	int count=0; //글 개수
	int currentPage=0;
    int number=0;//행 번호 출력
	List proList=null; //상품 정보 저장
	List brandList=null; //상품의 브랜드 정보 저장
	ProductListDAO dao = ProductListDAO.getInstance();
	
	int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
	
	//proList = dao.getProList(pageNum, stoId); 
    //상품 정보 리스트에 저장
	brandList = dao.getBrandList(stoId);

	
    String selectedBrand = request.getParameter("brand"); // 선택한 브랜드

	if(selectedBrand == null || selectedBrand.isEmpty()||selectedBrand.equals("all") ){
	    proList = dao.getProList(pageNum, stoId); 
		count = dao.getProCount(stoId); //상품수 세는 메소드의 결과 값 대입
	    // 전체 브랜드 상품 정보 리스트에 저장
	} else {
	    proList = dao.getProListByBrand(pageNum, stoId, selectedBrand); 
		count = dao.getProCount(stoId, selectedBrand); //상품수 세는 메소드의 결과 값 대입
	    // 선택한 브랜드의 상품 정보 리스트에 저장
	}
    number=count-(pageNum-1)*pageSize;
	brandList = dao.getBrandList(stoId); 

%>
<body>
	<%@ include file="../header/listStore.jsp" %>
	<h2>상품관리</h2>
	<h3>
		상품 목록 (<%=count %>개)
	</h3>
	<select name="brand"
		onchange="if(this.value==''){location.href='/pt1/store/productList.jsp';}else{location.href='/pt1/store/productList.jsp?brand='+this.value;}">
		<!-- onchange="location.href='/pt1/store/productList.jsp?brand='+this.value;"> -->
		<option>브랜드 선택</option>
		<option value="">전체</option>
		<%for(int i=0; i<brandList.size();i++){
           	ProductListDTO brand = (ProductListDTO)brandList.get(i);%>
		<option value="<%= brand.getBrand() %>"><%= brand.getBrand() %></option>
		<%} %>
	</select>
	<input type="button" value="상품등록"
		OnClick="window.location='/pt1/product/pUploadForm.jsp'">
	<table border="1">
		<tr>
			<th>번호</th>
			<th>카테고리</th>
			<th>상품번호</th>
			<th>색상</th>
			<th>상품명</th>
			<th>브랜드</th>
			<th>사이즈</th>
			<th>재고</th>
			<th>가격</th>
			<th>등록시간</th>
			<th>조회수</th>
			<th>판매여부</th>
			<th>기타</th>
			<th>상품수정</th>
			<th>상품삭제</th>
		</tr>
		<tbody>

			<%
	            //상품 정보 반복문으로 출력
	            for(int i=0; i<proList.size();i++){
	            	ProductListDTO product = (ProductListDTO)proList.get(i);        	
	            //for(MemListDTO member : memList) { %>
			<tr>
				<td><%=number-- %></td>
				<td><%= product.getCategory() %></td>
				<td><%= product.getPnum() %></td>
				<td><%= product.getColor() %></td>
				<td><%= product.getPname() %></td>
				<td><%= product.getBrand() %></td>
				<td><%= product.getPsize() %></td>
				<td><%= product.getStock() %></td>
				<td><%= product.getPrice() %></td>
				<td><%= product.getReg() %></td>
				<td><%= product.getReadnum() %></td>
				<td>
					<%if(product.getActive() != 1){ %> 위반 상품으로 판매 정지 <%}else{ %>
					<form method="post" action="productListPro.jsp">
						<input type="hidden" name="pnum" value="<%=product.getPnum() %>">
						<input type="hidden" name="onsale"
							value="<%=product.getOnsale() %>"> <input type="hidden"
							name="pageNum" value="<%=pageNum %>">
						<% if( product.getOnsale() ==1){%>
						판매 <input type="submit" value="판매 중단">
						<%}else{ %>
						판매 중단 <input type="submit" value="판매 재개">
						<% }%>
						<% }%>
					</form>
				</td>
				<td>
					<%if(product.getActive() != 1){ %> 위반 상품으로 판매 정지 <%} %>
				</td>
				<td>
					<%if(product.getActive()==1){ %>
					<form action="/pt1/product/productModifyForm.jsp" method="post">
						<input type="hidden" name="pnum" value="<%=product.getPnum()%>">
						<input type="hidden" name="pageNum" value="<%=pageNum%>">
						<input type="submit" value="수정하기">
					</form> <%} %>
				</td>
				<td>
					<%if(product.getActive() != 1){ %> 위반 상품으로 판매 정지 <%}else{ %> <%if(product.getOnsale() ==0){ %>
					<form action="/pt1/product/productDeletePro.jsp" method="post">
						<input type="hidden" name="pnum" value="<%=product.getPnum()%>">
						<input type="hidden" name="pageNum" value="<%=pageNum%>">
						<input type="submit" value="삭제하기">
					</form> <%}else{ %> 판매 중단 후 상품을 삭제할 수 있습니다 <%} %> <%} %>
				</td>
			</tr>
			<% } %>
		</tbody>
	</table>
	<br>
	<!-- 
	<div>
		<form action="/pt1/product/search.jsp" method="post">
			<input type="text" name="pname" placeholder="상품 이름">
			<input type="submit" name="searchProduct" value="검색">
		</form>
	</div>
	 -->
	<div>
		<%
      	//하단에 페이지 처리
         int totalPage = (int)(dao.getProCount() / 50)+1; //총 페이지 수. 50개씩 끊어서 보여줌
         if(totalPage >= 0) {
            if(pageNum > 1) { %>
		<a href="productList.jsp?pageNum=<%= pageNum - 1 %>">[이전]</a>
		<% }
            for(int i = 1; i <= totalPage; i++) { %>
		<% if(i == pageNum) { %>
		<a href="productList.jsp?pageNum=<%= i %>"><%= i %></a>
		<!-- <strong><%= i %></strong> -->
		<% } else { %>
		<a href="productList.jsp?pageNum=<%= i %>"><%= i %></a>
		<% } %>
		<% }
            if(pageNum < totalPage) { %>
		<a href="productList.jsp?pageNum=<%= pageNum + 1 %>">[다음]</a>
		<% }
         } %>

	</div>
</body>
</html>



