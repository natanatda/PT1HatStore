<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "pt1.EventDTO" %>
<%@ page import = "pt1.EventDAO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
	<head>
		<title>이벤트 게시판</title>
		<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String level_num = (String)session.getAttribute("level_num");
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String admid=(String)session.getAttribute("admId");      //관리자 session
	try{
		EventDAO dao = EventDAO.getInstance();
		EventDTO dto = dao.getEvent(num);
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
			<table  border="1" >
				<tr >
					<td >글번호</td>
					<td  >
						<%=dto.getNum()%></td>
					<td >카테고리</td>
					<td >
						<%=dto.getCategory()%></td>
				</tr>
				<tr >
					<td  >작성자</td>
					<td >
						<%=dto.getWriter()%></td>
					<td  >작성일</td>
					<td >
						<%=sdf.format(dto.getReg())%></td>
				</tr>
				<tr >
					<td >글제목</td>
					<td colspan="3">
						<%=dto.getSubject()%></td>
				</tr>
				<tr>
					<td  >글내용</td>
					<td colspan="3"><pre><%=dto.getContent()%></pre></td>
				</tr>
				<tr >
					<td colspan="4" >
			<%
				if(admid != null){%>
						<input type="button" value="글수정" onclick="document.location.href='eventUpdateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="글삭제" onclick="document.location.href='eventDeleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'">
						&nbsp;&nbsp;&nbsp;&nbsp;
			<%	}%>
					<input type="button" value="글목록" onclick="document.location.href='eventMain.jsp?pageNum=<%=pageNum%>'">
			</td></tr></table>
<%
	}catch(Exception e){}
%>
		</form>
	</body>
</html>