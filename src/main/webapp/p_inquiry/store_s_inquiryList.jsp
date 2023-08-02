<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.P_inquiryDAO" %>
<%@ page import="pt1.P_inquiryDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>상품 문의 관리</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
// 상품 문의 관리페이지 (미처리 목록만 출력되는 페이지)

	// 각 세션 불러옴
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	//점주 여부 체크
	if(!(level_num.equals("2")) || stoId == null){%>
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
	
	List p_list=null; // 결과 값 출력을 위한 리스트
    List bran = null; // 브랜드 검색을 위한 리스트
    List pro = null; // 상품명 검색을 위한 리스트
	P_inquiryDAO dao = P_inquiryDAO.getInstance();
	
	int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
	
    String brand = request.getParameter("brand");
    String pname = request.getParameter("pname");
    
    if(brand == null && pname == null || brand == "" || pname == ""){ 
    // 둘 다 null (초기화면) , 전체보기 선택하면 모든 결과를 list에 넣음
		p_list = dao.getSta_inquiry(pageNum); 	
	    count = dao.statusCount();
    }
    if(brand != null && brand != ""){
    // 	브랜드 검색을 하면 검색한 브랜드를 list에 넣음
    	p_list = dao.getBran_inquiry(pageNum, brand);
    	count = dao.b_statusCount(brand);
    }
    if(pname != null && pname != ""){
    //	상품명 검색하면 검색한 상품을 list에 넣음
    	p_list = dao.getPro_inquiry(pageNum, pname);
    	count = dao.p_statusCount(pname);
    }
   
    
    bran = dao.selectBran();// 현재 있는 브랜드만 검색하려고 list에 브랜드를 넣음
    pro = dao.selectPro(); // 현재 있는 상품이름만 검색하려고 list에 상품이름을 넣음
    
    number=count-(pageNum-1)*pageSize;
		
%>
<body>
	<%@ include file="../header/listStore.jsp" %>
	<h2>
		미처리된 상품 문의 목록 (<%=count %>개)
	</h2>
	<b>브랜드 검색</b>
	<form action="store_s_inquiryList.jsp?brand=<%=brand%>">
	<select name="brand">
		<option value="">전체보기</option>
		<%for(int i = 0; i < bran.size(); i++){
		P_inquiryDTO dto = (P_inquiryDTO)bran.get(i); // 현재 있는 브랜드 목록을 dto에 넣음
	%>					<%-- 반복문으로 리스트 크기만큼 출력 --%>
		<option value="<%=dto.getBrand()%>"><%=dto.getBrand()%></option>
		<%} %>
	</select>
		<input type="submit" value="검색" />
	</form>
	
	<b>상품별 검색</b>
	<form action="store_s_inquiryList.jsp?pname=<%=pname%>">
	<select name="pname">
		<option value="">전체보기</option>
	<%for(int i = 0; i < pro.size(); i++){
		P_inquiryDTO dto = (P_inquiryDTO)pro.get(i); // 현재 있는 상품 목록을 dto에 넣음
	%>					<%-- 반복문으로 리스트 크기만큼 출력 --%>
		<option value="<%=dto.getPname()%>"><%=dto.getPname()%></option>
	<%} %>
	</select>
		<input type="submit" value="검색" />
	</form>
	<table>
		<tr>
			<td>
				<input type="button" value="전체 보기" onclick="location='storeinquiryList.jsp'"/>
			</td>
		</tr></table>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>브랜드명</th>
			<th>상품번호</th>
			<th>상품명</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일자</th>
			<th>처리상태</th>
		</tr>
		<tbody>
			<%
	            //상품 문의 정보 반복문으로 출력
	            for(int i=0; i < p_list.size();i++){
	            	P_inquiryDTO p_inquiry = (P_inquiryDTO)p_list.get(i); 
	            	if(p_inquiry.getRef_step() == 0 && p_inquiry.getStatus() == 0){ // 답글이 아닌 미처리 문의만 ture인 조건문
	         %>
			<tr>
				<td align="center"><%=number-- %></td>
				<td align="center"><%= p_inquiry.getBrand() %></td>
				<td align="center"><%= p_inquiry.getPnum() %></td>
				<td align="center"><%= p_inquiry.getPname() %></td>
				<td align="center">
				<a href="/pt1/p_inquiry/p_inquiryContent.jsp?num=<%=p_inquiry.getNum()%>&pnum=<%=p_inquiry.getPnum()%>&pageNum=<%=currentPage%>">
           <%=p_inquiry.getSubject()%></a></td>
				<td align="center"><%= p_inquiry.getWriter() %></td>
				<td align="center"><%= p_inquiry.getReg() %></td>
				
				<td align="center">
				<%if(p_inquiry.getRef_step() == 1){ %>
				-
				<%}else if(p_inquiry.getStatus() == 0){ %>
				미처리
				<%}else{ %>
				처리됨
				<%} %>
				</td>
			</tr>
			<% }
	         }%>
		</tbody>
	</table>
	<br>
	
	<div>
		<%
      	//하단에 페이지 처리
         int totalPage = (int)(dao.allCount() / 50)+1; //총 페이지 수. 50개씩 끊어서 보여줌
         if(totalPage >= 0) {
            if(pageNum > 1) { %>
		<a href="store_s_inquiryList.jsp?pageNum=<%= pageNum - 1 %>">[이전]</a>
		<% }
            for(int i = 1; i <= totalPage; i++) { %>
		<% if(i == pageNum) { %>
		<a href="store_s_inquiryList.jsp?pageNum=<%= i %>"><%= i %></a>
		<!-- <strong><%= i %></strong> -->
		<% } else { %>
		<a href="store_s_inquiryList.jsp?pageNum=<%= i %>"><%= i %></a>
		<% } %>
		<% }
            if(pageNum < totalPage) { %>
		<a href="store_s_inquiryList.jsp?pageNum=<%= pageNum + 1 %>">[다음]</a>
		<% }
         } %>

	</div>
</body>
</html>