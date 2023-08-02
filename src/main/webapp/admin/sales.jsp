<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Locale" %>
<%@ page import="pt1.Sales" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출관리</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	//관리자 여부 체크
	String admId = (String)session.getAttribute("admId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("3"))){ %>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<% }
	request.setCharacterEncoding("utf-8");
	Sales sales = Sales.getInstance();
    //List<Map<String, Object>> orders = sales.getDailyOrdersAndRevenue();
	
	//int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
   	NumberFormat nf = NumberFormat.getInstance(Locale.getDefault());
	
%>
<%@ include file="../header/listAdmin.jsp" %>
	<h2>매출관리</h2>

	<!-- 매출 정보 요약 -->
	<table border="1">
		<tr>
			<td>금일 총 매출</td>
			<td>전일 총 매출</td>
			<td>일주일 총 매출</td>
			<td>한달 총 매출</td>
		</tr>
		<tr>
			<td>
				<%
					Map<String, Object> todayResult = sales.getOrdersAndRevenue("today");
				 	long todayOrderCount = (todayResult.get("order_count") != null) ? ((Number)todayResult.get("order_count")).longValue() : 0;
	                long todayRevenue = (todayResult.get("revenue") != null) ? ((Number)todayResult.get("revenue")).longValue() : 0;
				%> <%= nf.format(todayRevenue) %>원 <br> (<%=  nf.format(todayOrderCount) %>건)
			</td>
			<td>
				<%
					Map<String, Object> yesterdayResult  = sales.getOrdersAndRevenue("yesterday");
					long yesterdayOrderCount = (yesterdayResult.get("order_count") != null) ? ((Number)yesterdayResult.get("order_count")).longValue() : 0;
	                long yesterdayRevenue = (yesterdayResult.get("revenue") != null) ? ((Number)yesterdayResult.get("revenue")).longValue() : 0;
				%> <%= nf.format(yesterdayRevenue) %>원 <br> (<%= nf.format(yesterdayOrderCount) %>건)
			</td>
			<td>
				<%
					Map<String, Object> last_weekResult = sales.getOrdersAndRevenue("last_week");
					long last_weekResultOrderCount = (last_weekResult.get("order_count") != null) ? ((Number)last_weekResult.get("order_count")).longValue() : 0;
	                long last_weekResultRevenue = (last_weekResult.get("revenue") != null) ? ((Number)last_weekResult.get("revenue")).longValue() : 0;
				%> <%= nf.format(last_weekResultRevenue) %>원 <br> (<%= nf.format(last_weekResultOrderCount) %>건)
			</td>
			<td>
				<%
					Map<String, Object> last_monthResult = sales.getOrdersAndRevenue("last_month");
					long last_monthOrderCount = (last_monthResult.get("order_count") != null) ? ((Number)last_monthResult.get("order_count")).longValue() : 0;
	                long last_monthRevenue = (last_monthResult.get("revenue") != null) ? ((Number)last_monthResult.get("revenue")).longValue() : 0;
				%> <%= nf.format(last_monthRevenue) %>원 <br> (<%= nf.format(last_monthOrderCount) %>건)
			</td>
		</tr>
	</table>

	<h3>일별 매출</h3>
	<!-- 기간 입력 -->
	<div>
		<form method="get" action="salesPro.jsp">
			<label for="startDate">시작일자:</label> <input type="date" id="startDate" name="startDate" value="<%=request.getParameter("startDate")%>" required>
			<label for="endDate">종료일자:</label> <input type="date" id="endDate" name="endDate" value="<%=request.getParameter("endDate")%>" required>
			<button type="submit">조회</button>
		</form>
	</div>


	<%
	//조회 결과 출력
		if (request.getAttribute("dailySalesList") != null) {
			List<Map<String, Object>> dailySalesList = (List<Map<String, Object>>) request.getAttribute("dailySalesList");
			if (dailySalesList.size() == 0) {%>
			<h3>조회할 기간을 입력해 주세요.</h3>
		<%} else {%>
		<table border='1'>
			<tr>
				<th>날짜</th>
				<th>주문수</th>
				<th>매출</th>
			</tr>
			<%
				for (Map<String, Object> dailySales : dailySalesList) {%>
			<tr>
				<td><%=dailySales.get("orderDate")%></td>
				<td><%=nf.format(dailySales.get("dailyOrderCount"))%></td>
				<td><%=nf.format(dailySales.get("dailySales"))%></td>
			<tr>
				<% } %>
			<tr>
				<td> 총계</td>
				<%
				    	int totalOrderCount = 0;
						int totalSales = 0;
						
						for (Map<String, Object> dailySales : dailySalesList) {
					        int dailyOrderCount = (int) dailySales.get("dailyOrderCount");
					        int dailySalesTotal = (int) dailySales.get("dailySales");

					        totalOrderCount += dailyOrderCount;
					        totalSales += dailySalesTotal;
						}
				%>
				<td>총 주문수 : <%=nf.format(totalOrderCount) %></td>
				<td>총 판매액 : <%=nf.format(totalSales) %></td>
			</tr>
		</table>
		<% }
	    }
    %>


</body>
</html>