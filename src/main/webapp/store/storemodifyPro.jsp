<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "pt1.StoreDAO" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="store" class="pt1.StoreDTO">
    <jsp:setProperty name="store" property="*" />
</jsp:useBean>
 
<%
    String stoId = (String)session.getAttribute("stoId");  //수정폼에서 아이디는 안넘어와서 추가로 집어넣어줌
	store.setStore_id(stoId);

	StoreDAO manager = StoreDAO.getInstance();
    manager.updateStore(store);
 %>
 <%
	//점주 여부 체크
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<% }%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<body>
	<%@ include file="../header/listStore.jsp" %>
	<h2>회원 정보 수정</h2>
<form method="post" action="/pt1/main/main.jsp">
	<table border="1" width="270" border="0">
		<tr>
			<th>회원정보가 수정되었습니다.</th>
		</tr>
		<tr>
			<td>
				입력하신 내용대로 수정이 완료되었습니다.
			</td>
		</tr>
		<tr>
			<td><input type="submit" name="modify" value="메인으로"></td>
		</tr>
		<tr>
			<td>5초후에 메인으로 이동합니다.
				<meta http-equiv="Refresh" content="5;url=/pt1/main/main.jsp">
			</td>
		</tr>
	</table>
</form>
</body>
</html>