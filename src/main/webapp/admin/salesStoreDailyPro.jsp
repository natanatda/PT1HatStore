<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="pt1.Sales" %>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");
	//관리자 여부 체크
	String admId = (String)session.getAttribute("admId");
	String level_num = (String)session.getAttribute("level_num");
	
	String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String store_id = request.getParameter("stoId");

	if(!(level_num.equals("3"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<% }
	
    
    Sales sales = Sales.getInstance();    
    List<Map<String, Object>> dailySalesList = sales.getDailySales(startDate, endDate, store_id);
    
    //조회 결과 전달
    request.setAttribute("stoId", store_id);
    request.setAttribute("dailySalesList", dailySalesList);
    //response.sendRedirect("form.jsp");
    request.getRequestDispatcher("salesStoreDaily.jsp").forward(request, response);
    
    
%>