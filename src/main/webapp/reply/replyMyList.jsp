<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="pt1.ReplyDAO" %>
<%@ page import ="pt1.ReplyDTO" %>
<%@ page import ="java.util.List" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>

<%!
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
	String id = (String)session.getAttribute("memId");
	//String pnum = (String)session.getAttribute("pnum");
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	List replyList = null;
	ReplyDAO dao = ReplyDAO.getInstance();
	count = dao.getMyReplyCount(id);
	if(count > 0){
		replyList = dao.getMyReplys(id, startRow, endRow);
	}
	number = count - (currentPage-1) * pageSize;
	//관리자 여부 체크
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("1"))){
	%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%
}
%>
<html>
<head>
<title>내 리뷰</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<body>
<%@ include file="../header/listMember.jsp" %>
<h2>내 리뷰</h2>
<table>
<tr>
	<td >
	<a href="/pt1/member/mypage.jsp">돌아가기</a>

	</td>
</tr>
</table>
<%
	if(count == 0){
%>
<table>
<tr>
	<td>
	쓴 리뷰가 없습니다.
	</td>
</tr>
</table>
<%} else { %>
<table border="1">
	<tr>
		<td>번호</td>
		<td>내 용</td>
		<td>작성자</td>
		<td>작성일</td>
		<td>좋아요</td>
	</tr>
<%
	for(int i = 0; i < replyList.size(); i++){
		ReplyDTO dto = (ReplyDTO)replyList.get(i);
%>
<tr>
	<td><%=number--%></td>
	<td>
		<a href="replyContent2.jsp?replyNum=<%=dto.getReplyNum()%>&pageNum=<%=currentPage%>">
		<%=dto.getContent()%></a></td>
	<td>
		<%=dto.getMemberId()%></td>
	<td><%=sdf.format(dto.getRegDate())%></td>
	<td><%= dto.getRecommend()%></td>
     		
</tr>
	<%} %>
</table>


<%}%>
<%
	if(count > 0){
		int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1 );
		
		int startPage = (int)(currentPage / 10) * 10 + 1;
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		if(startPage > 10){ %>
		<a href="replyMyList.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
<%		}
		for(int i = startPage; i <= endPage; i++){ %>
		<a href="replyMyList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%
		}
		if(endPage < pageCount){ %>
		<a href="replyMyList.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
<%
		}
	}
%>	
</body>
</html>