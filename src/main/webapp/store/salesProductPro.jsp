<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="pt1.Sales" %>

<!DOCTYPE html>

<%
	String store_id=(String)session.getAttribute("stoId");
	
	request.setCharacterEncoding("utf-8");
	
	String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String sort = request.getParameter("sort");
    
    Sales sales = Sales.getInstance();    
    List<Map<String, Object>> salesProductList = sales.getSalesByProduct(store_id, startDate, endDate, sort);
       
  	//조회 결과 전달
    request.setAttribute("salesProductList", salesProductList);
    //response.sendRedirect("form.jsp");
    request.getRequestDispatcher("salesProduct.jsp").forward(request, response);
    
%>
