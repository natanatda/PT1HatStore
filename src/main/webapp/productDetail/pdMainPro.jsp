<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.ProductDAO"  %>
<%@ page import="pt1.ProductDTO"  %>
<%@ page import="pt1.MemberDAO"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="java.text.NumberFormat"  %>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dto" class="pt1.ProductDTO" />
<jsp:setProperty name="dto" property="*" />
<html>
<%
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String memid=(String)session.getAttribute("memId");      //회원 session
	ProductDAO pdao = ProductDAO.getInstance(); 
	ArrayList<ProductDTO> list=pdao.checkProduct(dto.getPnum());
    
	int total_price = (int)dto.getPrice() * quantity;
%>
	
		
		


</html>