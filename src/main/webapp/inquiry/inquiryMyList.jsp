<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="pt1.InquiryDAO" %>
<%@ page import ="pt1.InquiryDTO" %>
<%@ page import ="pt1.P_inquiryDAO" %>
<%@ page import ="pt1.P_inquiryDTO" %>
<%@ page import ="java.util.List" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<%!
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>


<%
	// 각 세션 불러옴
	String id = (String)session.getAttribute("memId");
	String store = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	
	// 페이지 출력 양식
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){pageNum = "1";}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	List articleList = null; // 문의 목록 출력을 위한 리스트
	InquiryDAO dao = InquiryDAO.getInstance();
	P_inquiryDAO p_dao = P_inquiryDAO.getInstance();
	
	if(id != null){
		count = dao.getMyArticleCount(id) + p_dao.getMyp_InquiryCount(id); // 일반 문의글이랑 상품 문의글 갯수 확인하는 메서드 (회원 기준)
	}else if (store != null){
		count = dao.getMyArticleCount(store) + p_dao.getMyp_InquiryCount(store); // 일반 문의글이랑 상품 문의글 갯수 확인하는 메서드 (점주 기준)
	}
				 
	if(count > 0){ // 문의 글이 있으면 리스트에 저장
		if(id != null){
			articleList = dao.getMyInquiry(id, startRow, endRow);
		}else if(store != null){
			articleList = dao.getMyInquiry(store, startRow, endRow);
		}
	}
	number = count - (currentPage-1) * pageSize;
%>
<%
	//로그인 여부 체크
	if(level_num==null){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<% }%>
<html>
<head>
<title>내 문의 목록</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<body>
<%if(level_num!=null){
		// level_num이 3일 경우 (레벨 3 =>관리자)
		if(level_num.equals("3")){%>
			<%@ include file="../header/listAdmin.jsp" %>
		<%
		//level_num이 2일 경우 (레벨 2 =>점주)
		} else if(level_num.equals("2")){ %>
			<%@ include file="../header/listStore.jsp" %>
		<%
		//level_num이 1일 경우 (레벨 1 =>회원)
		} else if(level_num.equals("1")){%>
            <%@ include file="../header/listMember.jsp" %>
		<%}
	}else{%>
		<%@ include file="../header/listGuest.jsp" %>
	<%} %>
<h2>내 문의 목록</h2>
<!-- 
<table border>
<tr>
	<td align="right">
	<a href="inquiryForm.jsp">문의하기</a>
	<a href="inquiryList.jsp">돌아가기</a>

	</td>
</tr>
</table>
 -->
<%
	if(count == 0){
%>
<table border="1">
<tr>
	<td>
	문의하신 내용이 없습니다.
	</td>
</tr>
</table>
<%} else { %>
<table border="1">
	<tr>
		<td >번호</td>
		<td >제 목</td>
		<td >작성자</td>
		<td >작성일</td>
		<td >상 태</td>
	</tr>
<%
		for(int i = 0; i < articleList.size(); i++){
			InquiryDTO dto = (InquiryDTO)articleList.get(i); // 리스트에 있는 값들 dto에 저장
%>
<tr>
	<td ><%=number--%></td>
	<td >
	<%if(dto.getNum() >= 10000){ %> <%-- 상품문의는 글 번호 시퀀스 10000번부터 --%>
	<a href="/pt1/p_inquiry/p_inquiryContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>">
	<%=dto.getSubject()%></a></td>
	<%}else{ %>
	<a href="inquiryContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>">
		<%=dto.getSubject()%></a></td>
		<%} %>
		<td >
		<%=dto.getWriter()%></td>
		<td ><%=sdf.format(dto.getReg_date()) %></td>
		<td >
			 <%
    	if(dto.getRe_step() == 1){ // 답글인 글은 상태칸에 - 표시
    %>
    	-
	<%}else if(dto.getStatus() == 0){ // 답글이 없는 글(답글 달리면 자동으로 1됨!)
	%>
	   미처리
	<%}else{ %>
		처리됨    
    <%}%>
		</td>
</tr>
	<%} %>
</table>
<%}%>
<%

	// 페이지 출력 양식
	if(count > 0){
		int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1 );
		int startPage = (int)(currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		if(startPage > 10){ %>
		<a href="inquiryMyList.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
<%		}
		for(int i = startPage; i <= endPage; i++){ %>
		<a href="inquiryMyList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%
		}
		if(endPage < pageCount){ %>
		<a href="inquiryMyList.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
<%
		}
	}
%>	
</body>
</html>