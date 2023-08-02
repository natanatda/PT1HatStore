<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import ="pt1.BrandDAO" %>
<%@ page import ="pt1.BrandDTO" %>
<%@ page import="java.util.List"  %>
<%@ page import="java.text.NumberFormat"  %>
<jsp:useBean id="dto" class="pt1.DeliveryDTO" />
<jsp:setProperty name="dto" property="*" />

<head>
<title>재고관리</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>

<%request.setCharacterEncoding("utf-8"); %>
<%	
	List BrandnoList  = null; 
	String store_id=(String)session.getAttribute("stoId");	//점주 session	
	BrandDAO ddao=BrandDAO.getInstance();
	BrandnoList = ddao.getBrandNo(store_id); 	//store_id(점주 아이디)로 점주가 가지고 있는 브랜드의 brandno를 BrandnoList에 저장
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
</body>
