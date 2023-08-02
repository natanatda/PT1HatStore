<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="pt1.Sales" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 일일 매출</title>
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
	
    String store_id = request.getParameter("stoId");
    NumberFormat nf = NumberFormat.getInstance(Locale.getDefault());
	
	//int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
	
%>
<body>
	<%@ include file="../header/listAdmin.jsp" %>
	<h2><%=store_id%> 일별 매출</h2>
	<h2><a href="salesStore.jsp">점주별 매출로 돌아가기</a></h2>
	<!-- 기간 입력 -->
	<div>
		<form method="get" action="salesStoreDailyPro.jsp">
			<label for="startDate">시작일자:</label> <input type="date" id="startDate" name="startDate" value="<%=request.getParameter("startDate")%>" required>
			<label for="endDate">종료일자:</label> <input type="date" id="endDate" name="endDate" value="<%=request.getParameter("endDate")%>" required>
			<input type="hidden" name="stoId" value="<%=store_id %>">
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