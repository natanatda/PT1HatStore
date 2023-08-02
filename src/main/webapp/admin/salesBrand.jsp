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
<title>브랜드 매출</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>

<%
	//관리자 여부 체크
	String admId = (String)session.getAttribute("admId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("3"))){
	%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%
}
	String sort=request.getParameter("sort");
	request.setCharacterEncoding("utf-8");
	NumberFormat nf = NumberFormat.getInstance(Locale.getDefault());

	Sales sales = Sales.getInstance();
	if (sort == null || sort.isEmpty()) {
        sort = "desc"; // 기본값
    } else {
        //sort = sort.equalsIgnoreCase("desc") ? "asc" : "desc"; // asc와 desc 반전
    }
	String arrow = sort.equalsIgnoreCase("desc") ? "▼" : "▲";

%>
	<script>
		function sortSales() {
			var sortInput = document.getElementsByName("sort")[0];
			var sort = sortInput.value;
			if (sort == "asc") {
				sortInput.value = "desc";
			} else {
				sortInput.value = "asc";
			}
			document.forms[0].submit(); //첫번째 폼태그 제출
			return true;
		}
	</script>
	
<body>
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
	<h3>브랜드별 매출</h3>
	<div>
		<form method="get" action="salesBrandPro.jsp">
			<label for="startDate">시작일자:</label> <input type="date" id="startDate" name="startDate" value="<%=request.getParameter("startDate")%>" required>
			<label for="endDate">종료일자:</label> <input type="date" id="endDate" name="endDate" value="<%=request.getParameter("endDate")%>" required>
			<input type="hidden" value="<%=sort %>" name="sort">
			<button type="submit">조회</button>
		</form>
	</div>

	<%
	//조회 결과 출력
		if (request.getAttribute("brandSalesList") != null) {
			List<Map<String, Object>> brandSalesList = (List<Map<String, Object>>) request.getAttribute("brandSalesList");
			if (brandSalesList.size() == 0) {%>
			<h3>조회할 기간을 입력해 주세요.</h3>
	<%} else {%>
	<table border='1'>
	<tr>
			<th>점주ID</th>
			<th>브랜드번호</th>
			<th>브랜드명</th>
			<th>
				<a href="#" id="salesSort" onclick="sortSales()">
				매출<%=arrow%></a>
			</th>
			<th>주문수</th>
			<th>일별 매출</th>
			<th>매출 경고</th>
		</tr>
		<%
			for (Map<String, Object> brandSales : brandSalesList) {%>
			<tr>
				<td><%=brandSales.get("store_id")%></td>
				<td><%=brandSales.get("brandno")%></td>
				<td><%=brandSales.get("brand")%></td>
				<td><%=nf.format(brandSales.get("total_sales"))%></td>
				<td><%=nf.format(brandSales.get("order_count"))%></td>
				<td>
					<form method="post" action="salesBrandDaily.jsp">
						<input type="submit" value="해당 브랜드의 일별 매출 확인하기">
						<input type="hidden" name="brandno" value="<%=brandSales.get("brandno")%>">
						<input type="hidden" name="brand" value="<%=brandSales.get("brand")%>">
					</form>
				</td>
				<td>
					<%
						int brandno = ((int)brandSales.get("brandno"));
						int countWarning = sales.getWarningCount(brandno);
					%>
					<form method="get" action="/pt1/message/admin_MessageWarning.jsp">
						<input type="submit" name="warning" value="경고하기" >
						<input type="hidden" name="brandno" value="<%=brandSales.get("brandno")%>">
					</form>
					
					현재 <%=countWarning %>회
				</td>
			<tr>
		<% } %>
			<tr>
				<td>총계</td>
				<%
				    	int totalOrderCount = 0;
						int totalSales = 0;
						
						for (Map<String, Object> brandSales: brandSalesList) {
					        int orderQuantity = (int) brandSales.get("order_count");
					        int paymentAmount = (int) brandSales.get("total_sales");

					        totalOrderCount += orderQuantity;
					        totalSales += paymentAmount;
						}
				%>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>총 매출 : <%= nf.format(totalSales) %></td>
				<td>총 주문수 : <%= nf.format(totalOrderCount) %></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
	</table>
	<% }
    }
    %>
</body>
</html>