<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>이벤트</title>
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
if (admid == null) {
%>
<script>
	alert("관리자만 글쓰기 가능");
	location = "/pt1/admin/adminloginForm.jsp";
</script>
<%
}
%>
<%
int num = 0;
try {
	if (request.getParameter("num") != null) {
		num = Integer.parseInt(request.getParameter("num"));
	}
%>
<body>
	<h2>글쓰기</h2>
	<br>
	<form method="post" name="boardinput" action="eventWritePro.jsp"
		onSubmit="return checkIt()">
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="category" value="event">
		<table border="1">
			<tr>
				<td><a href="eventMain.jsp"> 글목록</a></td>
			</tr>
			<tr>
				<td>제 목</td>
				<td><input type="text" size="40" maxlength="50"
					name="subject"></td>
			</tr>
						<tr>
				<td>내 용</td>
				<td><textarea name="content" rows="13" cols="40"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="글쓰기"> <input
					type="reset" value="다시작성"> <input type="button"
					value="목록보기" OnClick="window.location='eventMain.jsp'"></td>
			</tr>
		</table>
		<%
		} catch (Exception e) {
		}
		%>
	</form>
</body>
</html>