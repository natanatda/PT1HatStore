<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.NoticeDAO"  %>
<%@ page import="pt1.NoticeDTO"  %>
<%@ page import="java.util.List"  %>
<%@ page import="java.text.SimpleDateFormat"  %>
<!DOCTYPE html>
<% 
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String admid=(String)session.getAttribute("admId");      //관리자 session
	String pageNum = request.getParameter("pageNum");
	String level_num = (String)session.getAttribute("level_num");
    if (pageNum == null) {
        pageNum = "1";
    }
    int currentPage = Integer.parseInt(pageNum);	//String을 숫자로 바꿔줌
    int startRow = (currentPage - 1) * pageSize + 1;	
    int endRow = currentPage * pageSize;	//startRow ~ endRow 한페이지에 검색될 row
    int count = 0;
    int number=0;
    
    List noticeList = null;
	NoticeDAO dao = NoticeDAO.getInstance();
    count = dao.getNoticeCount();	//전체 글의 개수를 리턴하는 메서드
    if (count > 0) {
        noticeList = dao.getNotices(startRow, endRow);
    }

    number=count-(currentPage-1)*pageSize;	// number = 전체글 개수 - (현재페이지번호-1)*10
    
%>
<html>
	<head>
		<title>공지사항</title>
		<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	</head>
	<body>
	<div>
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
	</div>
		<h2>게시판</h2>
		<h3>공지사항</h3>
	<b>글목록(전체 글 :<%=count%>)</b>
		<table>
			<tr>
				<!--
				<td align="left">
					<a href="/pt1/board/noticeMain.jsp">공지사항</a>
					<a href="/pt1/board/eventMain.jsp">이벤트</a>
				</td>
				 -->
				<td align="right" >
				<%if(admid==null){			//로그인 안 했을때%>	
					<!-- <a href="/pt1/admin/adminloginForm.jsp">관리자 로그인</a> -->
					<!-- <a href="/pt1/main/main.jsp">홈페이지</a> -->
					
				<%}else{		//로그인 했을때 %>
				
					<a href="noticeWriteForm.jsp">글쓰기</a>
					<!--<a href="/pt1/main/main.jsp">홈페이지</a>-->
				<%} %>
				</td>
			</tr>
		</table>
	<%
		if(count == 0){
	%>
			<table border="1">
				<tr>
					<td >
						게시판에 저장된 글이 없습니다.
					</td>
				</tr>
			</table>
	<%	}else{ %>
			<table border="1"> 
				<tr height="30"> 
					<td width="50"  >번 호</td> 
    				<td width="100" >작성자</td>
      				<td width="250" >제  목</td> 
    				<td width="150" >카테고리</td>
    				<td width="150" >작성일</td>
    			</tr>
    		<%for(int i =0 ; i < noticeList.size() ; i++){
    			NoticeDTO dto = (NoticeDTO)noticeList.get(i);%>
    			<tr height="30">
    				<td width="50" > <%=number--%></td>
     				<td width="150"><%= dto.getWriter()%></td>
     				<td width="150">
     				<a href="noticeContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>">
         				  <%=dto.getSubject()%></a> 
     				</td>
     				<td width="150"><%= dto.getCategory()%></td>
     				<td width="150"><%= sdf.format(dto.getReg())%></td>
    			</tr>
    	<%		}%>
    		</table>
    		<%} %>
    		
    	<%
    		if (count > 0) {
    			int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
    			int startPage = (int)(currentPage/10)*10+1;
    			int pageBlock=10;
    			int endPage = startPage + pageBlock-1;
    			if (endPage > pageCount){ endPage = pageCount;}
    			
    			if (startPage > 10) {%>
    			
    				<a href="noticeMain.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
    			<%}
    			for (int i = startPage ; i <= endPage ; i++) {  %>
    				<a href="noticeMain.jsp?pageNum=<%= i %>">[<%= i %>]</a>
    			<%}
    			if (endPage < pageCount) {  %>
    				<a href="noticeMain.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
    			<%}
    		}
    	%>
    	
	</body>
</html>

