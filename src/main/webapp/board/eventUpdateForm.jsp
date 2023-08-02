<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="pt1.EventDAO"%>
<%@ page import="pt1.EventDTO"%>
<!DOCTYPE html>
<html>
<head>
<title>이벤트</title>
</head>
<script src="/pt1/resources/js/board.js"></script>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
String level_num = (String) session.getAttribute("level_num");
if (level_num != null) {
	// level_num이 3일 경우 (레벨 3 =>관리자)
	if (level_num.equals("3")) {
%>
<%@ include file="../header/listAdmin.jsp"%>
<%
//level_num이 2일 경우 (레벨 2 =>점주)
} else if (level_num.equals("2")) {
%>
<%@ include file="../header/listStore.jsp"%>
<%
//level_num이 1일 경우 (레벨 1 =>회원)
} else if (level_num.equals("1")) {
%>
<%@ include file="../header/listMember.jsp"%>
<%
}
} else {
%>
<%@ include file="../header/listGuest.jsp"%>
<%
}
%>
<%
String admid = (String) session.getAttribute("admId"); //관리자 session
if (admid != null) { //관리자인가 확인
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	try {
		EventDAO dao = EventDAO.getInstance();
		EventDTO dto = dao.updateGetEvent(num);
%>
<body>
	<b>글수정</b>
	<br>
	<form method="post" name="boardinput" action="eventUpdatePro.jsp?pageNum=<%=pageNum%>&num=<%=num%>"	onSubmit="return checkIt()">
		<input type="hidden" name="category" value="event">
		<table border="1">
			<tr>
				<td>제 목</td>
				<td><input type="text" size="40" maxlength="50" name="subject" value="<%=dto.getSubject()%>"></td>
			</tr>
			<tr>
				<td>내 용</td>
				<td><textarea name="content" rows="13" cols="40"><%=dto.getContent()%></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="글수정"> <input
					type="reset" value="다시작성"> <input type="button"
					value="목록보기"
					onclick="document.location.href='eventMain.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
		</table>
	</form>
	<%
	} catch (Exception e) {
	}
	} else {
	%>
	<script>
		alert("관리자만 업데이트 가능");
		location = "/pt1/admin/adminloginForm.jsp";
	</script>
	<%
	}
	%>
</body>
</html>
