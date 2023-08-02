<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="pt1.AdminDAO" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 계정 찾기</title>
</head>
<body>
	<%
	String id = request.getParameter("id");
	AdminDAO dao = AdminDAO.getInstance();
	String result = dao.pwFind(id);
	if (result == null) {
	%>
	<script>
		alert("PW를 찾을 수 없습니다");
		history.go(-1);
	</script>
	<%
	} else {
	%>
	<h2>
		아이디 : <%=id %> <br/>
		비밀번호 : [<%=result%>] 입니다
	</h2>
	<a href="/pt1/main/main.jsp">메인</a>
	<%
	}
	%>
</body>
</html>