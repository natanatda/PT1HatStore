<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Locale" %>
<%@ page import="pt1.ProductDAO"%>
<%@ page import="pt1.ProductDTO"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dto" class="pt1.ProductDTO" />
<jsp:setProperty name="dto" property="*" />
<%
   List bestList=null;
   ProductDAO pdao=ProductDAO.getInstance();
   bestList=pdao.bestProduct();
   NumberFormat nf = NumberFormat.getInstance(Locale.getDefault());
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/product.css">
</head>
<body>
   <table class="productTable">
      <%
         int row = 0;	//열 나타내는 변수 row
         for(int i = 0; i < Math.min(10, bestList.size()); i++) {
        	 ////bestList의 크기와 10 중 작은 값을 반복 조건으로 지정
            ProductDTO dto1 = (ProductDTO)bestList.get(i);
            if(i % 5 == 0) {	// (i가 1부터)5번 반복할때마다 row ++
               if(i != 0) {
      			%>
      			<%}
                  row++;
     			 %>
                  <tr>
      			<%} %>
                  <td>
                     <form action="/pt1/productDetail/pdMainForm.jsp">
                        <input type="hidden" name="pnum" value="<%=dto1.getPnum()%>">
                        <div>
                           <input type="image" src="<%= request.getContextPath() %>/uploadpimg/<%= dto1.getPimg() %>" alt="Product" height="200" width="100"><br />
                           종류 : <%=dto1.getCategory() %><br />
                           상품명 : <%=dto1.getPname() %><br />
                           색상 : <%=dto1.getColor() %><br />
                           브랜드 : <%=dto1.getBrand() %><br />
                           사이즈 : <%=dto1.getPsize() %><br />
                           가격 : <%=nf.format(dto1.getPrice())%>원
                        </div>
                     </form>
                  </td>
      <%}%>
      </tr>
   </table>
</body>
</html>