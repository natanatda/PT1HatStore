<%@ page  contentType="text/html; charset=UTF-8"%>
<%@ include file="/view/color.jsp"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="pt1.BrandDTO"  %>
<%-- 
<%@ include %> -- (디렉티브 include) 코드 그대로 결합
<jsp:include> -- 실행결과(화면) 결합
--%>

<!DOCTYPE html>
<html>
	<head>
		<title>점주 : 마이페이지</title>
		<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	</head>
	
   		 
<body onLoad="focusIt();" bgcolor="white">
	<%
	try {
		if (session.getAttribute("stoId") == null) { //세션 값 꺼냈을때 그게 널 = 로그인 안된 거
	%>
	<%@ include file="../header/listGuest.jsp" %>
	로그인을 안하셨는걸요? 로그인하러 가요!
	<input type="button" value="로그인하기"
		onclick="javascript:window.location='storeloginForm.jsp'">
	<%
	} else {
	BrandDTO dto = new BrandDTO();
	%>
	<%@ include file="../header/listStore.jsp" %>
	<h2>점주페이지</h2>
	<table border="1">
		<tr><td bgcolor="#2196F3"><%=session.getAttribute("stoId")%>님이 방문하셨습니다</td></tr>
		<tr>
			<form method="post" action="logoutForm.jsp">
				<td>
					<input type="button" value="점주정보변경"
					onclick="javascript:window.location='storemodifyForm.jsp'"></td>
				</td>
			</form>
		</tr>
	</table>
	<br>
<%}
 }catch(NullPointerException e){}
 %>
 </body>
</html>










