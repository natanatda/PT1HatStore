<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>메시지 보내기</title>
		<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
		<script src="/pt1/resources/js/message.js"></script>
	</head>
<%
	
	String admid=(String)session.getAttribute("admId");   //관리자
	//String store_id=(String)session.getAttribute("stoId");   //점주
	//String memid=(String)session.getAttribute("memId");   //고객
	if(admid==null){%>
		<script>
			alert("관리자만 글쓰기 가능");
			location="/pt1/admin/adminloginForm.jsp";
		</script>
<%	} %>
<%
	try{
%>
<body>
	<%@ include file="../header/listAdmin.jsp" %>
	<h2>메시지 관리</h2>
	<h3>메시지 보내기</h3>
	<br>
	<form method="post" name="messageinput" action="adminMsPro.jsp" onsubmit="return message()">
	<%--	<input type="hidden" name="num" value="<%=num%>"> --%>
		
		<table border="1">
			<tr>
				<td >발신자</td>
				<td >
					<%=admid %></td>
			</tr>
			<tr>
				<td>수신자</td>
				<td >
					<input type="text" size="40" maxlength="50" name="store_id"></td>
			</tr>
			<tr>
				<td >브랜드 번호</td>
				<td >
					<input type="number" size="40" maxlength="50" name="brandno"></td>
			</tr>
			<tr>
				<td >제 목</td>
				<td >
					<input type="text" size="40" maxlength="50" name="subject"></td>
			</tr>
			<tr>
				<td >내 용</td>
				<td >
					<textarea name="content" rows="13" cols="40"></textarea> </td>
			</tr>
			<tr>
				<td colspan="2"> 
					<input type="submit" value="보내기" >
					<input type="reset" value="다시작성">
					<input type="button" value="취소" onclick="document.location.href='/pt1/main/main.jsp?'">
				</td>
			</tr>
		</table>
<%
	}catch(Exception e){}
%>
	</form>
</body>
</html>