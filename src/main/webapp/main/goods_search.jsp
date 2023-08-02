<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.List"  %>
<%@ page import="pt1.ProductDAO" %>
<%@ page import="pt1.ProductDTO" %>
<%@ page import="pt1.MemberDAO"  %>
<%@ page import="java.text.NumberFormat"  %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dto" class="pt1.ProductDTO" />
<jsp:setProperty name="dto" property="*" />

<style>
	img{
		width:200px;
		height: 200px;
	}
</style>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/pt1/resources/css/list.css">
</head>
<%	
	String level_num=(String)session.getAttribute("level_num");   //level세션(관리자/점주/회원 구분 위함)  
%>
<h1><a href="/pt1/main/main.jsp">PT1 STORE</a></h1>
<div class="menuBar">
	<%if(level_num!=null){
		// level_num이 3일 경우 (레벨 3 =>관리자)
		if(level_num.equals("3")){%>
			<ul>
				<%-- 상품 페이지로 이동 --%>
        	    <li><a href="/pt1/classification/classification.jsp">상품</a></li>
				<%-- 브랜드 페이지로 이동 --%>
				<li><a href="/pt1/brand/brandMain.jsp">브랜드</a></li>
				<li><a href="/pt1/admin/sales.jsp">매출관리</a>
				<ul>
					<li><a href="/pt1/admin/salesBrand.jsp">브랜드별 매출</a></li>
					<li><a href="/pt1/admin/salesStore.jsp">점주별 매출</a></li>
					<li><a href="/pt1/admin/salesProduct.jsp">상품별 매출</a></li>
				</ul></li>
				<li><a href="/pt1/admin/memList.jsp">회원관리</a></li>
				<li><a href="/pt1/admin/adminOrderList.jsp">주문관리</a></li>
				<li><a href="/pt1/admin/storeList.jsp">점주관리</a></li>
				<li><a href="/pt1/admin/brandList.jsp">브랜드관리</a></li>
				<li><a href="/pt1/admin/productList.jsp">상품관리</a></li>
				<li><a href="/pt1/board/noticeMain.jsp">게시판</a></li>
				<li><a href="/pt1/message/messageMain.jsp">메시지 관리</a>
				<ul>
					<li><a href="/pt1/message/adminMs.jsp">메시지보내기</a></li>
					<li><a href="/pt1/message/adminMsList.jsp">보낸 메시지함</a></li>
				</ul></li>
				<li><a href="/pt1/inquiry/admininquiryList.jsp">문의관리</a></li>
			</ul>
		<%
		//level_num이 2일 경우 (레벨 2 =>점주)
		} else if(level_num.equals("2")){ %>
			<ul>
				<%-- 상품 페이지로 이동 --%>
				<li><a href="/pt1/classification/classification.jsp">상품</a></li>
				<%-- 브랜드 페이지로 이동 --%>
				<li><a href="/pt1/brand/brandMain.jsp">브랜드</a></li>
				<li><a href="/pt1/store/salesAll.jsp">매출 조회</a>
                  <ul>
                     <li><a href="/pt1/store/salesAll.jsp">매출 상세</a></li>
                     <li><a href="/pt1/store/salesDaily.jsp">일별 매출</a></li>
                     <li><a href="/pt1/store/salesProduct.jsp">상품 매출</a></li>
                  </ul></li>
               <li><a href="/pt1/store/productList.jsp">상품관리</a></li>
               <li><a href="/pt1/store/orderList.jsp">주문관리</a></li>
               <li><a href="/pt1/delivery/deliveryCheck.jsp">배송관리</a></li>
               <li><a href="/pt1/store/stockCheck.jsp">재고관리</a></li>
               <li><a href="/pt1/store/brandList.jsp">브랜드관리</a></li>
               <li><a href="/pt1/inquiry/inquiryList.jsp">문의</a>
               	<ul>
	               <li><a href="/pt1/inquiry/inquiryForm.jsp">문의하기</a></li>
	               <li><a href="/pt1/inquiry/inquiryMyList.jsp">내 문의</a></li>
               	</ul>
               </li>
               <li><a href="/pt1/board/noticeMain.jsp">게시판</a>
               	<ul>
               		<li><a href="/pt1/inquiry/inquiryList.jsp">공지사항</a></li>
               		<li><a href="/pt1/board/eventMain.jsp">이벤트</a></li>
               	</ul></li>
            </ul>
		<%
		//level_num이 1일 경우 (레벨 1 =>회원)
		} else if(level_num.equals("1")){%>
            <ul>
               <%-- 상품 페이지로 이동 --%>
               <li><a href="/pt1/classification/classification.jsp">상품</a></li>
               <%-- 브랜드 페이지로 이동 --%>
               <li><a href="/pt1/brand/brandMain.jsp">브랜드</a></li>
               <li><a href="/pt1/board/noticeMain.jsp">게시판</a></li>
               <li><a href="/pt1/inquiry/inquiryList.jsp">문의</a></li>
            </ul>
		<%}
	}else{%>
		<ul>
			<%-- 상품 페이지로 이동 --%>
			<li><a href="/pt1/classification/classification.jsp">상품</a></li>
			<%-- 브랜드 페이지로 이동 --%>
			<li><a href="/pt1/brand/brandMain.jsp">브랜드</a></li>
			<li><a href="/pt1/board/noticeMain.jsp">게시판</a></li>
		</ul>
	<%} %>
</div>
<%
	//로그인 한 아이디 확인
	String admid=(String)session.getAttribute("admId");	//관리자
	String store_id=(String)session.getAttribute("stoId");	//점주
	String memid=(String)session.getAttribute("memId");	//고객
	//상품에 대한 데이터 가져오기
	List productList = null; 
	ProductDAO pdao = ProductDAO.getInstance(); 
	productList = pdao.searchProduct(dto.getPname());
	%>
	<body>
		<table>
		<%
		//상품 목록이 없는 경우
		if(productList==null){%>
		<h1>상품을 다시 검색해주세요.</h1>
		<%}else{ %>
			<tr>
				<td>
					<%	
						int row = 0;	//열 나타내는 변수 row
						//상품 목록만큼 반복
						for(int i=0; i< productList.size(); i++){
						ProductDTO dto1 = (ProductDTO)productList.get(i);
						if(i % 4 == 0) {	// (i가 1부터)4번 반복할때마다 row ++
			            	if(i != 0) {
			               	%>
			               	<%}
			               	   row++;
			               	%>
			               	    <tr>
			               	<%}%>
			               	       <td>
						<form action="/pt1/productDetail/pdMainForm.jsp">
							<input type="hidden" name="pnum" value="<%=dto1.getPnum()%>">
							<input type="image" src="<%= request.getContextPath() %>/uploadpimg/<%= dto1.getPimg() %>" alt="Product" height="200" width="100">
							<%--<%= request.getContextPath() %>는 서버 경로--%>
							<h1>
								<h3>카테고리 : <%=dto1.getCategory() %></h3>
								<h3>색상 : <%=dto1.getColor() %></h3>
								<h3>상품명 : <%=dto1.getPname() %></h3>
								<%
									NumberFormat nf = NumberFormat.getCurrencyInstance();
								%>
								<h3>가격: <%=nf.format(dto1.getPrice()) %>원</h3>
							</h1>
                     </form>
                  </td>
			<%}
		}%>
      </tr>
   </table>
</body>