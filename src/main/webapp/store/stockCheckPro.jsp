<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="pt1.BrandDAO" %>
<%@ page import ="pt1.BrandDTO" %>
<%@ page import = "pt1.ProductDTO" %>
<%@ page import = "pt1.ProductDAO" %>
<%@ page import= "java.util.List" %>
<!DOCTYPE html>

<jsp:useBean id="dto" class="pt1.ProductDTO" />
<jsp:setProperty name="dto" property="*" />
<head>
<title>재고 간편 관리</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%request.setCharacterEncoding("utf-8"); %>
<%
	try{
	List productList=null;
	String store_id=(String)session.getAttribute("stoId");	//점주 세션
	Integer brandno=Integer.parseInt(request.getParameter("brandno"));	
	ProductDAO pdao=ProductDAO.getInstance();
	productList=pdao.getProductList(brandno);	//hidden값으로 받아온 brandno를 매개변수로 대입하여 해당되는 product 리스트 출력
	
	List BrandnoList  = null; 
	BrandDAO ddao2 =BrandDAO.getInstance();
	BrandnoList = ddao2.getBrandNo(store_id);
%>
<body>
	<%@ include file="../header/listStore.jsp" %>
	<h2>재고관리</h2>
	<table>
			<tr>
				<td>
					<%	
						for(int i=0; i< BrandnoList.size(); i++){
						BrandDTO dto1 = (BrandDTO)BrandnoList.get(i);%>
						<%-- brandno를 hidden 값으로 보냄 --%>
						<form action="/pt1/store/stockCheckPro.jsp" method="post">
							<input type="hidden" name="brandno" value="<%=dto1.getBrandNo()%>">
							<input type="submit" value="[<%=dto1.getBrandNo() %>] 브랜드 번호의 재고 관리">
						</form>
				</td>
			<%} %>
		</tr>
	</table>
	<h3>재고간편관리</h3>
	<table border="1">
		<tr>
			<th>category</th>
			<th>pnum</th>
			<th>color</th>
			<th>pname</th>
			<!-- <th>brandno</th> -->
			<th>brand</th>
			<th>psize</th>
			<th>stock</th>
			<th>price</th>
			<th>reg</th>
			<th>readnum</th>
			<th>pimg</th>
			<th>active</th>
		</tr>
	</tbody>
	<%
		for(int i=0;i<productList.size();i++){
			ProductDTO dto1=(ProductDTO)productList.get(i);%>
			<tr>
				<td><%=dto1.getCategory() %></td>
				<td><%=dto1.getPnum() %></td>
				<td><%=dto1.getColor() %></td>
				<td><%=dto1.getPname() %></td>
				<!-- <td><%=dto1.getBrandNo() %></td> -->
				<td><%=dto1.getBrand() %></td>
				<td><%=dto1.getPsize() %></td>
				<td>
					<form method="post" action="/pt1/store/stockChange.jsp">
						<input type="hidden" name="pnum" value="<%=dto1.getPnum()  %>">	<%-- product 구별하기 위해 pnum을 hidden값으로 보냄 --%>
						<input type="hidden" name="brandNo" value="<%=dto1.getBrandNo()  %>">
						<input type="number" name="stock" value="<%=dto1.getStock() %>"> <%-- 변경할 stock 컬럼의 값을 보냄 --%>
						<input type="submit" value="재고수정">
   					</form>
				</td>
				<td><%=dto1.getPrice() %></td>
				<td><%=dto1.getReg() %></td>
				<td><%=dto1.getReadnum() %></td>
				<td><%=dto1.getPimg() %></td>
				<td><%=dto1.getActive() %></td>
			</tr>
			<%} %>
		<%}catch(Exception e){}%>			
	</table>
</body>