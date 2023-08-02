<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.InquiryDAO" %>    
<%@ page import="pt1.InquiryDTO" %>    
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<%!
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

%>
<%
	// 각 세션들을 불러옴
	String admin = (String)session.getAttribute("admId");
	String member = (String)session.getAttribute("memId");
	String store = (String)session.getAttribute("stoId");
	String level_num=(String)session.getAttribute("level_num");
	
	
	
	// 페이지 출력 양식
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){pageNum = "1";}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize; 
    int count = 0;
    int number=0;
    
   	List articleList = null; // 모든 문의 목록 출력을 위한 리스트   	
   	InquiryDAO dao = InquiryDAO.getInstance();
   	count = dao.getArticleCount(); // 문의글이 있는지 확인
   
   	if(count > 0){
   		articleList = dao.getArticles(startRow, endRow); // 있으면 리스트에 목록 저장
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
<title>문의</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
<style>
	#text1{ width:200px;}
	#text2{width:200px;}
</style>
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

	<h2>문의</h2>
	<h3>문의글 목록</h3>

<%
    if (count == 0) { 
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>

<%  } else{    %>
<table border="1" width="700" cellpadding="0" cellspacing="0"> 
    <tr height="30"> 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="250" >제 목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td>    
       <td align="center"  width="50" >상 태</td> 
    </tr>
<%  
        for (int i = 0 ; i < articleList.size() ; i++) { 
          InquiryDTO dto = (InquiryDTO)articleList.get(i); // 리스트에 저장된 값들 dto에 저장
%>
   <tr height="30">
    <td align="center"  width="50" > <%=number--%></td>
    <td  width="250" >
          			 
      <a href="inquiryContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>">
           <%=dto.getSubject()%></a> </td>
    <td align="center"  width="100"> 
       <a><%=dto.getWriter()%></a></td> 
    <td align="center"  width="150"><%= sdf.format(dto.getReg_date())%></td>
    <td align="center"  width="50">
    <%
    	if(dto.getRe_step() == 1){ 
    %>
    	-
	<%}else if(dto.getStatus() == 0){
	%>
	   미처리
	<%}else{ %>
		처리됨    
    <%}%>
    </td>
  </tr> 
     <%}%>
</table>
<%}%>

<%
	// 페이지 출력 양식
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (int)(currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		if(startPage > 10){ %>
		<a href="inquiryList.jsp?pageNum=<%=startPage - 10 %>">[이전]</a>
<%		}
		for(int i = startPage; i <= endPage; i++){  %>
		<a href="inquiryList.jsp?pageNum=<%=i%>">[<%=i %>]</a>
<%		}
		if(endPage < pageCount) { %>
		<a href="inquiryList.jsp?pageNum=<%=startPage + 10 %>">[다음]</a>
<%
		}
	}
%>
</body></html>