<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "pt1.ProductDTO" %>
<%@ page import = "pt1.ProductDAO" %>
<%@ page import= "java.util.List" %>
<!DOCTYPE html>

<jsp:useBean id="dto" class="pt1.ProductDTO" />
<jsp:setProperty name="dto" property="*" />

<%request.setCharacterEncoding("utf-8"); %>
<%
	try{
		String store_id=(String)session.getAttribute("stoId");	//점주 세션
		
		Integer pnum=Integer.parseInt(request.getParameter("pnum")); 
		Integer brandNo=Integer.parseInt(request.getParameter("brandNo")); 
		dto.setPnum(pnum);
		ProductDAO pdao=ProductDAO.getInstance();
		pdao.updateStock(dto);
%>
<h1>재고가 수정되었습니다.</h1>
<form action="/pt1/store/stockCheck.jsp" method="post">
	<input type="hidden" name="brandNo" value="<%=brandNo %>">
	<input type="submit" value="이동">
</form>
<%}catch(Exception e){}%>