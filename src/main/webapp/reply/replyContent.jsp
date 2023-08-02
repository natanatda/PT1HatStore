<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "pt1.ReplyDTO" %>
<%@ page import = "pt1.ReplyDAO" %>
<%@ page import = "pt1.LikeyDAO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
	<head>
		<title>리뷰 게시판</title>
		<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	</head>
<%
	int replyNum = Integer.parseInt(request.getParameter("replyNum"));
	String pageNum = request.getParameter("pageNum");
	
	int productNum = Integer.parseInt(request.getParameter("pnum"));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	String admid=(String)session.getAttribute("admId");      //관리자 session
    String store_id=(String)session.getAttribute("stoId");   //점주 session
    String memid=(String)session.getAttribute("memId");      //회원 session
    String level_num=(String)session.getAttribute("level_num");   //level세션(관리자/점주/회원 구분 위함)
    
    LikeyDAO likeyDAO = LikeyDAO.getInstance();
    int count = likeyDAO.checkLike(memid,replyNum,productNum);	//이미 추천했는지 체크
	try{
		ReplyDAO dao = ReplyDAO.getInstance();
		ReplyDTO dto = dao.getReply(replyNum);
	
%>

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
		<h2>글내용 보기</h2>
		<br>
		<form>
			<table border="1">
				<tr>
					<td>리뷰번호</td>
					<td>
						<%=dto.getReplyNum()%></td>
					<td>상품번호</td>
					<td>
						<%=dto.getProductNum()%></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td>
						<%=dto.getMemberId()%></td>
					<td>작성일</td>
					<td>
						<%=sdf.format(dto.getRegDate())%></td>
				</tr>
				<tr>
					<td>평점</td>
					<td >
						<%=dto.getRating()%></td>
					
					<td>추천수</td>
					<td>
				<%if(count > 0){	//추천 눌렀는지 검사 - 이미 누른경우 %>
						<a onclick="return confirm('추천 취소하시겠습니까?')" href="/pt1/reply/recommendReply.jsp?replyNum=<%=dto.getReplyNum()%>&pageNum=<%=pageNum%>&pnum=<%=productNum%>">추천취소 </a>
						(<%= dto.getRecommend()%>)</td>
				<%}else if(count == 0){//추천안눌렸을 떄 %>
					<a onclick="return confirm('추천하시겠습니까?')" href="/pt1/reply/recommendReply.jsp?replyNum=<%=dto.getReplyNum()%>&pageNum=<%=pageNum%>&pnum=<%=productNum%>">추천하기 </a>
     					(<%= dto.getRecommend()%>)</td>
     			<%} %>
				</tr>
				<tr>
					<td>사진</td>
					<td colspan="3">
						<%-- <img src="/pt1/uploadrimg/<%=dto.getRimg() %>"> --%>
						<input type="image" src="<%= request.getContextPath() %>/uploadrimg/<%= dto.getRimg() %>" alt="Product" height="200" width="100">
				</tr>
				<tr>
					<td>글내용</td>
					<td colspan="3"><pre><%=dto.getContent()%></pre></td>
				</tr>
				<tr >
					<td colspan="4">
					<input type="button" value="글목록" onclick="document.location.href='/pt1/productDetail/pdMainForm.jsp?pageNum=<%=pageNum%>&pnum=<%=productNum%>'"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%
			//작성자가 본인일경우, 관리자일때만 삭제 가능
				if(level_num.equals("3") || memid.equals(dto.getMemberId())){%>	
					<input type="button" value="글삭제" onclick="document.location.href='/pt1/reply/replyDeleteForm.jsp?replyNum=<%=dto.getReplyNum()%>&pageNum=<%=pageNum%>&pnum=<%=productNum%>'">
					&nbsp;&nbsp;&nbsp;&nbsp;
			<%	}%>
					</td></tr>
			</table>
<%
	}catch(Exception e){}
%>
		</form>
	</body>
</html>