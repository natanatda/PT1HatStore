<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="pt1.Sales" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/product.css">
</head>
<%
   request.setCharacterEncoding("UTF-8");
      Sales sales = Sales.getInstance();    
      List<Map<String, Object>> bestProductList = sales.getBestProduct();
      NumberFormat nf = NumberFormat.getInstance(Locale.getDefault());
%>
<body>
   <table class="productTable">
   <%
   		int row = 0;	//열 나타내는 변수 row
      	for (int i = 0; i < Math.min(10, bestProductList.size()); i++) {
      		//bestProductList의 크기와 10 중 작은 값을 반복 조건으로 지정
        	Map<String, Object> productSales = bestProductList.get(i);
          	////readnum(조회수) 높은 상품 목록 10개 이미지 출력 (hidden 값으로 pnum 보냄) => 상품 상세 페이지에서 상품 구별하기 위한 목적
			if(i % 5 == 0) {	// (i가 1부터)5번 반복할때마다 row ++
            	if(i != 0) {
               	%>
               	<%}
               	   row++;
               	%>
               	    <tr>
               	<%}%>
               	       <td>
		<form action="/pt1/productDetail/pdMainForm.jsp">
			<input type="hidden" name="pnum" value="<%=productSales.get("pnum")%>">
			<div>
				<input type="image" src="<%= request.getContextPath() %>/uploadpimg/<%=productSales.get("pimg")%>" alt="Product" height ="200" width="100"><br />
				<%--<%= request.getContextPath() %>는 서버 경로--%>
				종류 : <%=productSales.get("category") %><br />
				상품명 : <%=productSales.get("pname") %><br />
				색상 : <%=productSales.get("color") %><br />
				브랜드 : <%=productSales.get("brand") %><br />
				사이즈 : <%=productSales.get("psize") %><br />
				가격 : <%=nf.format(productSales.get("price"))%>원
                        </div>
                     </form>
                  </td>
      <%}%>
      </tr>
   </table>
</body>