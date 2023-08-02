<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.ReplyDAO" %>
<%@ page import="pt1.ReplyDTO" %>
<%@ page import="pt1.BrandDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	//점주 여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))||stoId==null){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}
//페이지 구성
	int pageSize = 50;
	int count=0; //글 개수
	int currentPage=0;
    int number=0;//행 번호 출력
    ArrayList<Map<String, Object>> reviewList=null; //리뷰 정보 저장
	ReplyDAO dao = ReplyDAO.getInstance();
	
	int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
	
	String selectBrand = request.getParameter("selectBrand");
    if(selectBrand == null || selectBrand.isEmpty()){
		reviewList = dao.getReviewList(pageNum, stoId); 
		count = dao.getReviewCount(stoId);
    }else{
    	reviewList = dao.getReviewList(pageNum, Integer.parseInt(selectBrand));
		count = dao.getReviewCount(Integer.parseInt(selectBrand));
    }
    
	number=count-(pageNum-1)*pageSize;
%>
<body>
	<%@ include file="../header/listStore.jsp" %>

	<!--  리뷰 출력  -->
	<h1>리뷰 관리(<%=count %>건)</h1>
	<select name="selectBrand"
		onchange="if(this.value==''){location.href='/pt1/store/reviewList.jsp';}else{location.href='/pt1/store/reviewList.jsp?selectBrand='+this.value;}">
		<option>브랜드 선택</option>
		<%
		ArrayList<BrandDTO> brandList = dao.getBrandList(stoId);
		for(int i=0; i<brandList.size(); i++){
			BrandDTO brand = (BrandDTO)brandList.get(i);%>
		<option value="<%=brand.getBrandNo()%>"><%=brand.getBrand()%></option>
		<%} %>
	</select>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>리뷰넘버</th>
			<th>상품번호</th>
			<th>상품명</th>
			<th>내용</th>
			<th>별점</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<tbody>
			<%
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for (Map<String, Object> review : reviewList) {
				int replyNum = (Integer) review.get("replyNum");
				int productNum = (Integer) review.get("productNum");
				String memberId = (String) review.get("memberId");
				Date regDate = (Date) review.get("regDate");
				String subject = (String) review.get("subject");
				String content = (String) review.get("content");
				double rating = (double) review.get("rating");
				String rimg = (String) review.get("rimg");
				int ref = (Integer) review.get("ref");
				int re_step = (Integer) review.get("re_step");
				int re_level = (Integer) review.get("re_level");
				int recommend = (Integer) review.get("recommend");
				String pname = (String) review.get("pname");
			%>
			<tr>
				<td><%=number-- %></td>
				<td><%= replyNum %></td>
				<td><%= productNum %></td>
				<td><%= pname %></td>
				<td><%= content %></td>
				<td><%= rating %></td>
				<td><%= memberId %></td>
				<td><%= regDate %></td>
			</tr>
			<% } %>
		</tbody>
	</table>
	
	
	<div>
      <%
      	//하단에 페이지 처리
         int totalPage = (int)(count / 100)+1; //총 페이지 수. 100개씩 끊어서 보여줌
         if(totalPage >= 0) {
            if(pageNum > 1) { %>
               <a href="reviewList.jsp?pageNum=<%= pageNum - 1 %>">[이전]</a>
            <% }
            for(int i = 1; i <= totalPage; i++) { %>
               <% if(i == pageNum) { %>
					<a href="reviewList.jsp?pageNum=<%= i %>"><%= i %></a>
					<!-- <strong><%= i %></strong> -->
               <% } else { %>
                  <a href="reviewList.jsp?pageNum=<%= i %>"><%= i %></a>
               <% } %>
            <% }
            if(pageNum < totalPage) { %>
               <a href="reviewList.jsp?pageNum=<%= pageNum + 1 %>">[다음]</a>
            <% }
         } %>
   </div>
   
</body>
</html>