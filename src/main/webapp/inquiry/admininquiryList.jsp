<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.InquiryDAO" %>
<%@ page import="pt1.InquiryDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>문의 관리</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	// 문의 관리페이지 (전체 목록 조회)

	String admin = (String)session.getAttribute("admId"); // 관리자 세션 불러옴
	String level_num = (String)session.getAttribute("level_num"); // 로그인할때 지정한 레벨 세션 불러옴
	if(!(level_num.equals("3")) || admin == null){ // 레벨이 3이 아니거나 관리자 세션이 null이면 동작%>
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
	int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
	
	List inquiryList = null; // 결과 값 출력을 위한 리스트
	List cate = null; // 드롭다운 메뉴에 현재 있는 카테고리만 보여주기 위한 리스트
    InquiryDAO dao = InquiryDAO.getInstance();
   
	String category = request.getParameter("category");
	
	if(category == null || category == ""){ // 전체보기나 처음 페이지 들어왔을 때 실행되는 부분
		inquiryList = dao.getAllP_inquiry(pageNum);
    	count = dao.getArticleCount();
	}
	if(category != null && category != ""){ // 유형 검색하면 실행되는 부분
		inquiryList = dao.getCateinquiry(pageNum, category);
		count = dao.cateCount(category);
	}
	
	cate = dao.getCategory();
    number = count - (pageNum - 1) * pageSize;
		
%>
<body>
	<%@ include file="../header/listAdmin.jsp" %>
	<h2>문의관리</h2>
	<h3>
		문의 목록 (<%=count %>개)
	</h3>
	<b>문의유형 검색</b>
	<form action="admininquiryList.jsp?category=<%=category%>">
	<select name="category">
		<option value="">전체보기</option>
	<%for(int i = 0; i < cate.size(); i++){  
		InquiryDTO dto = (InquiryDTO)cate.get(i); // 리스트에 있는 값들 dto에 저장
		%>	
		<option value="<%=dto.getCategory()%>"><%=dto.getCategory()%></option>
	<%} %>
	</select>
		<input type="submit" value="검색" />
		<input type="button" value="미처리 문의보기" onclick="location='/pt1/inquiry/admin_s_inquiryList.jsp'" />
	</form>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>문의유형</th>
			<th>제목</th>
			<th>작성일자</th>
			<th>IP</th>
			<th>처리상태</th>
			<th>비고</th>
		</tr>
		<tbody>
			<%
	            // 문의 정보 반복문으로 출력
	            for(int i=0; i < inquiryList.size();i++){
	            	InquiryDTO inquiry = (InquiryDTO)inquiryList.get(i);
	         %>
			<tr>
				<td align="center"><%=number-- %></td>
				<td align="center"><%= inquiry.getWriter() %></td>
				<%-- 글 작성자가 관리자가 아니면 문의유형 출력 --%>
				<%if(!(inquiry.getWriter().equals(admin)) ){ %>
				<td align="center"><%= inquiry.getCategory() %></td>
				<%}else{ %>
				<td align="center">답변</td>
				<%} %>
				
				<td align="center">
				<a href="/pt1/inquiry/inquiryContent.jsp?num=<%=inquiry.getNum()%>&pageNum=<%=currentPage%>">
           <%=inquiry.getSubject()%></a></td>
				<td align="center"><%= inquiry.getReg_date() %></td>
				<td align="center"><%= inquiry.getIp() %></td>
				<td align="center">
				<%if(inquiry.getRe_step() == 1){ %>
				-
				<%}else if(inquiry.getStatus() == 0){ %>
				미처리
				<%}else{ %>
				처리됨
				<%} %>
				</td>
				<td>
					<input type="button" value="삭제" onclick="location='/pt1/inquiry/inquiryDelete.jsp?num=<%=inquiry.getNum()%>&ref=<%=inquiry.getRef()%>'"/>
				</td>
			</tr>
			<% } %>
		</tbody>
	</table>
	<br>
	
	<div>
		<%
      	//하단에 페이지 처리
         int totalPage = (int)(dao.getArticleCount() / 50)+1; //총 페이지 수. 50개씩 끊어서 보여줌
         if(totalPage >= 0) {
            if(pageNum > 1) { %>
		<a href="admininquiryList.jsp?pageNum=<%= pageNum - 1 %>">[이전]</a>
		<% }
            for(int i = 1; i <= totalPage; i++) { %>
		<% if(i == pageNum) { %>
		<a href="admininquiryList.jsp?pageNum=<%= i %>"><%= i %></a>
		<!-- <strong><%= i %></strong> -->
		<% } else { %>
		<a href="admininquiryList.jsp?pageNum=<%= i %>"><%= i %></a>
		<% } %>
		<% }
            if(pageNum < totalPage) { %>
		<a href="admininquiryList.jsp?pageNum=<%= pageNum + 1 %>">[다음]</a>
		<% }
         } %>

	</div>
</body>
</html>