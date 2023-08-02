<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.*"%>
<%request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
<title>관리자정보수정</title>
<script src="/pt1/resources/js/admininput.js"></script>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>


<%
    String id = (String)session.getAttribute("admId");  //세션 꺼내오고있음. 아이디는 현재 세션에 보관되어있으니까. 세션으로부터 아이디 꺼내옴
   
    AdminDAO manager = AdminDAO.getInstance();
    AdminDTO c = manager.getAdmin(id);

	//관리자 여부 체크
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("3"))){ %>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<% } %>
<%@ include file="../header/listAdmin.jsp"%>

<body><form method="post" action="adminmodifyPro.jsp" name="admininput"
	onsubmit="return checkIt2()">
	<table border="1">
		<tr>
			<td colspan="2"><font size="+1"><b>관리자 정보수정</b></font></td>
		</tr>
		<tr>
			<td colspan="2" class="normal">관리자의 정보를 수정합니다.</td>
		</tr>

		<tr>
			<td>관리자 ID</td>
			<td><%=c.getId()%></td>
		</tr>

		<tr>
			<td>관리자 PW</td>
			<td><input type="password" name="pw" size="10" maxlength="10"
				value="<%=c.getPw()%>"></td>


		</tr>
		<tr>
			<td colspan="2"><input type="submit" name="modify" value="수   정">
				<input type="button" value="취  소"
				onclick="javascript:window.location='/pt1/main/main.jsp'"></td>
		</tr>
	</table>
</form>
</body>
</html>