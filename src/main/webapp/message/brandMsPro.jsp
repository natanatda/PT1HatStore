<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="pt1.Admin_MessageDAO"  %>
<%@ page import="pt1.Admin_MessageDTO"  %>
<%@ page import="java.util.List"  %>
<%@ page import="java.text.SimpleDateFormat"  %>
<%
	request.setCharacterEncoding("utf-8");
	String stoId = (String)session.getAttribute("stoId");
	String admid=(String)session.getAttribute("admId");   //관리자
	Integer brandNo=Integer.parseInt(request.getParameter("brandno"));
	
	/*
	//관리자 여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))){ */
%>
<script>
   //alert("잘못된 경로입니다.");
   //location="/pt1/main/main.jsp";
</script>
<%=brandNo%>
<% 
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
    count = dao.getAdmin_MessageCount(brandNo);	//전체 글의 개수를 리턴하는 메서드
    if (count > 0) {
    	admin_MessageList = dao.getAdmin_Messages(brandNo,startRow, endRow);
    }

    number=count-(currentPage-1)*pageSize;	// number = 전체글 개수 - (현재페이지번호-1)*10
    
%>
<html>
	<head>
		<title>메시지</title>
	</head>
	<body>
<%
	if(stoId == null && admid == null){
%>		<table width="700">
			<tr>
				<a href="/pt1/main/main.jsp">홈페이지</a>
				글 읽을 권한이 없습니다.
		</table>
<%	}else{	%>
		<table width="700">
			<body>
			<div class="product-grid">
				<jsp:include page="../message/brandMs.jsp" flush="false" />
			</div>
		</body>
		</table>
		<b>메시지 목록(전체 메시지 :<%=count%>)</b>
		
	<%
		if(count == 0){
	%>
			<table width="700" border="1" cellpadding="0" >
				<tr>
					<td>
						받은 메시지가 없습니다.
					</td>
				</tr>
			</table>
	<%	}else{ %>
			<table border="1" width="1000" cellpadding="0"> 
				<tr height="30"> 
					<td width="50"  >번 호</td> 
    				<td width="100" >보낸 사람</td>
    				<td width="100" >받는 사람</td>
      				<td width="150" >제  목</td> 
    				<td width="150" >내 용</td>
    				<td width="150" >받은 날짜</td>
    			</tr>
    		<%for(int i =0 ; i < admin_MessageList.size() ; i++){
    			Admin_MessageDTO dto = (Admin_MessageDTO)admin_MessageList.get(i);%>
    			<tr height="30">
    				<td width="50" > <%=number--%></td>
     				<td width="150"><%= dto.getWriter()%></td>
     				<td width="150"><%= dto.getStore_id()%></td>
     				<td width="150">
     				<%-- <a href="brandMsContent.jsp?brandNo=<%=brandNo %>&pageNum=<%=currentPage%>">
     				--%>
         				  <%=dto.getSubject()%></a> 
     				</td>
     				<td width="500"><%= dto.getContent()%></td>
     				<td width="150"><%= sdf.format(dto.getRegDate())%></td>
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
    			
    				<a href="brandMsPro.jsp?brandno=<%=brandNo %>&pageNum=<%= startPage - 10 %>">[이전]</a>
    			<%}
    			for (int i = startPage ; i <= endPage ; i++) {  %>
    				<a href="brandMsPro.jsp?brandno=<%=brandNo %>&pageNum=<%= i %>">[<%= i %>]</a>
    			<%}
    			if (endPage < pageCount) {  %>
    				<a href="brandMsPro.jsp?brandno=<%=brandNo %>&pageNum=<%= startPage + 10 %>">[다음]</a>
    			<%}
    		}
	}
    	%>
	</body>
</html>

