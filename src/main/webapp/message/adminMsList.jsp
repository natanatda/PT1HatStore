<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="pt1.Admin_MessageDAO"  %>
<%@ page import="pt1.Admin_MessageDTO"  %>
<%@ page import="java.util.List"  %>
<%@ page import="java.text.SimpleDateFormat"  %>
<%
	request.setCharacterEncoding("utf-8");
	String admid=(String)session.getAttribute("admId");   //관리자
	
	String stoId = (String)session.getAttribute("stoId"); //점주
	String level_num = (String)session.getAttribute("level_num");
	
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    int currentPage = Integer.parseInt(pageNum);	//String을 숫자로 바꿔줌
    int startRow = (currentPage - 1) * pageSize + 1;	
    int endRow = currentPage * pageSize;	//startRow ~ endRow 한페이지에 검색될 row
    int count = 0;
    int number=0;
    
    List admin_MessageList = null;
    Admin_MessageDAO dao = Admin_MessageDAO.getInstance();
    count = dao.getAdminMessageCount();	//전체 글의 개수를 리턴하는 메서드
    if (count > 0) {
    	admin_MessageList = dao.getAdminMessages(startRow, endRow);
    }

    number=count-(currentPage-1)*pageSize;	// number = 전체글 개수 - (현재페이지번호-1)*10
    
%>
<html>
	<head>
		<title>보낸 메시지</title>
		<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	</head>
	<body>
	<%if(level_num!=null){ %>
		<%if(level_num.equals("3")){%>
		<%@ include file="../header/listAdmin.jsp" %>
		<%} else if(level_num.equals("2")){%>
		<%@ include file="../header/listStore.jsp" %>
		<%}else if(level_num.equals("1")){ %>
		<%@ include file="../header/listMember.jsp" %>
		<%} 
	}else{%>
	<%@ include file="../header/listGuest.jsp" %>
<%	}%>
	<h2>메시지 관리</h2>
	<%if(admid == null){
%>
		<table >
			<tr><td>
				<!-- <a href="/pt1/main/main.jsp">홈페이지</a> -->
				글 읽을 권한이 없습니다.
			</td></tr>
		</table>
<%	}else{	%>
	
	<h3>보낸 메시지 목록(전체 메시지 :<%=count%>)</h3>

	<%
		if(count == 0){ %>
			<table border="1">
				<tr>
					<td >
					<!-- <a href="/pt1/main/main.jsp">홈페이지</a> -->
					<!-- <a href="/pt1/message/adminMs.jsp">메시지보내기</a> -->
						보낸 메시지가 없습니다.
					</td>
				</tr>
			</table>
	<%	}else{ %>
			<table border="1"> 
				<!-- <a href="/pt1/main/main.jsp">홈페이지</a><br /> -->
				<!-- <a href="/pt1/message/adminMs.jsp">메시지보내기</a> -->
				<tr height="30"> 
					<td width="50"  >번 호</td> 
    				<td width="100" >발신자</td>
    				<td width="100" >점 주</td>
    				<td width="100" >브랜드 번호</td>
    				<td width="100" >브랜드명</td>
      				<td width="150" >제  목</td> 
    				<td width="150" >내 용</td>
    				<td width="150" >발송일</td>
    			</tr>
    		<%for(int i =0 ; i < admin_MessageList.size() ; i++){
    			Admin_MessageDTO dto = (Admin_MessageDTO)admin_MessageList.get(i);%>
    			<tr>
    				<td> <%=number--%></td>
     				<td><%= dto.getWriter()%></td>
     				<td><%= dto.getStore_id()%></td>
     				<td><%= dto.getBrandno()%></td>
     				<td><%= dto.getBrandname()%></td>
     				<td>
     				<%-- <a href="brandMsContent.jsp?brandNo=<%=brandNo %>&pageNum=<%=currentPage%>">
     				--%>
         				  <%=dto.getSubject()%></a> 
     				</td>
     				<td><%= dto.getContent()%></td>
     				<td><%= sdf.format(dto.getRegDate())%></td>
    			</tr>
    	<%		} %>
    		</table>
    		<% } 
	} %>
    	<%
    		if (count > 0) {
    			int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
    			int startPage = (int)(currentPage/10)*10+1;
    			int pageBlock=10;
    			int endPage = startPage + pageBlock-1;
    			if (endPage > pageCount){ endPage = pageCount;}
    			
    			if (startPage > 10) {%>
    			
    				<a href="adminMsList.jsp?admid=<%=admid %>&pageNum=<%= startPage - 10 %>">[이전]</a>
    			<%}
    			for (int i = startPage ; i <= endPage ; i++) {  %>
    				<a href="adminMsList.jsp?admid=<%=admid %>&pageNum=<%= i %>">[<%= i %>]</a>
    			<%}
    			if (endPage < pageCount) {  %>
    				<a href="adminMsList.jsp?admid=<%=admid %>&pageNum=<%= startPage + 10 %>">[다음]</a>
    			<% }
    		}
    	%>
	</body>
</html>

