<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "pt1.*"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<title>점주 정보 수정</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
<script src="/pt1/resources/js/storeinput.js"></script>


<%
    String id = (String)session.getAttribute("stoId");  //세션 꺼내오고있음. 아이디는 현재 세션에 보관되어있으니까. 세션으로부터 아이디 꺼내옴
    String level_num = (String)session.getAttribute("level_num");
   
    if(!(level_num.equals("2"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}
    StoreDAO manager = StoreDAO.getInstance();
    StoreDTO c = manager.getStore(id);

%>
</head>
<body>
<%@ include file="../header/listStore.jsp" %>
<h2>회원 정보수정</h2>
	<form method="post" action="storemodifyPro.jsp" name="userinput"
		onSubmit="return checkIt()">
		<table border="1">
			<tr>
				<th colspan="2" class="normal">점주회원의 정보를 수정합니다.</th>
			</tr>

			<tr>
				<td>사업자 ID</td>
				<td><%=c.getStore_id()%></td>
			</tr>

			<tr>
				<td>사업자 PW</td>
				<td><input type="password" name="store_pw" size="10"
					maxlength="10"></td>
			</tr>
			
			<tr>
				<td>담당자 이름</td>
				<td>
					<%if(c.getStore_name()==null){ %>
					<input type="text" name="store_name" size="10" maxlength="10">
					<%}else{ %>
					<input type="text" name="store_name" size="10" maxlength="10" value="<%=c.getStore_name()%>">
					<%} %>
				</td>
			</tr>

			<tr>
				<td>전화번호</td>
				<td>
					<%if(c.getStore_tel()==null){ %>
					<input type="text" name="store_tel" size="10" maxlength="12" oninput="autoHyphen(this)" placeholder="010-0000-0000">
					<%}else{ %>
					<input type="text" name="store_tel" size="10" maxlength="12" value="<%=c.getStore_tel()%>" oninput="autoHyphen(this)" placeholder="010-0000-0000">
					<%} %>
				</td>
			</tr>

			<tr>
				<td>이메일</td>
				<td>
					<%if(c.getStore_email()==null){ %>
					<input type="text" name="store_email" size="10" maxlength="40">
					<%}else{ %>
					<input type="text" name="store_email" size="10" maxlength="40" value="<%=c.getStore_email()%>">
					<%}
		%>
				</td>
			</tr>


			<tr>
				<td colspan="2"><input type="submit" name="modify"
					value="수   정"> <input type="button" value="취  소"
					onclick="javascript:window.location='/pt1/main/main.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>