<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"  %>
<%@ page import="pt1.ProductDAO" %>
<%@ page import="pt1.ProductDTO" %>
<%@ page import="pt1.MemberDAO"  %>
<%@ page import="java.text.NumberFormat"  %>
<%@ page import="java.util.Locale" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dto" class="pt1.ProductDTO" />
<jsp:setProperty name="dto" property="*" />
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/product.css">
<%
	List categoryList = null; 
	ProductDAO pdao = ProductDAO.getInstance(); 
	categoryList = pdao.selectCategory(dto.getCategory());
	NumberFormat nf = NumberFormat.getInstance(Locale.getDefault());
%>

<body>
   <table class="productTable">
	<%--카테고리가 선택되지 않은 경우 --%>
	<%if(categoryList==null){%>
	<h1>카테고리를 선택해주세요.</h1>
	<%}else{ %>
			<h1>[<%=dto.getCategory() %>]</h1>
			<tr>
					<%	
						int row = 0;	//열 나타내는 변수 row
						//상품 목록만큼 반복
						for(int i=0; i< categoryList.size(); i++){
						ProductDTO dto1 = (ProductDTO)categoryList.get(i);
						if(i % 5 == 0) {	// (i가 1부터)4번 반복할때마다 row ++
			            	if(i != 0) {
			               	%>
			               	<%}
			               	   row++;
			               	%>
			               	    <tr>
			               	<%}%>
			               	       <td>
						<form action="/pt1/productDetail/pdMainForm.jsp">
							<%--상품 상세 페이지에서 pnum으로 상품을 구분 --%>
							<input type="hidden" name="pnum" value="<%=dto1.getPnum()%>">
							<%--<%= request.getContextPath() %>는 서버 경로--%>
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
      <%}
      }%>
      </tr>
   </table>
</body>