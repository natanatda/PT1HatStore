<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "pt1.NoticeDAO"%>
<%@ page import = "pt1.NoticeDTO"%>
<!DOCTYPE html>
<html>
	<head>
		<title>공지사항</title>
		<script src="/pt1/resources/js/board.js"></script>
		<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	</head>
	<%
	String level_num = (String)session.getAttribute("level_num");
	if(level_num!=null){
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
<%
	String admid=(String)session.getAttribute("admId");      //관리자 session
	if(admid != null){	//관리자이면
			int num = Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
			try{
				NoticeDAO dao = NoticeDAO.getInstance();
			    NoticeDTO notice =  dao.updateGetNotice(num);
%>		
			    <body >  
				    <h2>글수정</h2>
				    <br>
					    <form method="post" name="boardinput" action="noticeUpdatePro.jsp?pageNum=<%=pageNum%>&num=<%=num %>" onSubmit="return checkIt()">
						    <input type="hidden" name="category" value="notice">
						    <table border="1">
								<tr>
									<td>제 목</td>
									<td >
										<input type="text" size="40" maxlength="50" name="subject" value="<%=notice.getSubject()%>"></td>
								</tr>
								<tr>
									<td>내 용</td>
									<td>
										<textarea name="content" rows="13" cols="40"><%=notice.getContent()%></textarea></td>
								</tr>
								<tr>      
									<td colspan="2"> 
										<input type="submit" value="글수정" >  
										<input type="reset" value="다시작성">
										<input type="button" value="목록보기" onclick="document.location.href='noticeMain.jsp?pageNum=<%=pageNum%>'">
						       </td>
						     </tr>
						     </table>
					    </form>
			<%}catch(Exception e){} 
		}else{%>
			<script>
				alert("관리자만 업데이트 가능");
				location="/pt1/admin/adminloginForm.jsp";
			</script>
		<%} %>

</body>
</html>
