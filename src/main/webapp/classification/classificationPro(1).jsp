<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"  %>
<%@ page import="pt1.ProductDAO" %>
<%@ page import="pt1.ProductDTO" %>
<%@ page import="pt1.MemberDAO"  %>
<%@ page import="java.text.NumberFormat"  %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dto" class="pt1.ProductDTO" />
<jsp:setProperty name="dto" property="*" />
<%
	List categoryList = null; 
	ProductDAO pdao = ProductDAO.getInstance(); 
	categoryList = pdao.selectCategory(dto.getCategory());
%>

<body>
	<table>
	<%--카테고리가 선택되지 않은 경우 --%>
	<%if(categoryList==null){%>
	<h1>카테고리를 선택해주세요.</h1>
	<%}else{ %>
			<h1>[<%=dto.getCategory() %>]</h1>
			<tr>
				<td>
					<%	
						int row = 0;	//열 나타내는 변수 row
						//상품 목록만큼 반복
						for(int i=0; i< categoryList.size(); i++){
						ProductDTO dto1 = (ProductDTO)categoryList.get(i);
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
							<%--상품 상세 페이지에서 pnum으로 상품을 구분 --%>
							<input type="hidden" name="pnum" value="<%=dto1.getPnum()%>">
							<input type="image" src="<%= request.getContextPath() %>/uploadpimg/<%= dto1.getPimg() %>" alt="Product" height="200" width="100">
							<%--<%= request.getContextPath() %>는 서버 경로--%>
                     </form>
                  </td>
      <%}
      }%>
      </tr>
   </table>
</body>