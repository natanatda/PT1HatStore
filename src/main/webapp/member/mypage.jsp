<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%-- 
<%@ include %> -- (디렉티브 include) 코드 그대로 결합
<jsp:include> -- 실행결과(화면) 결합
--%>

<html>
<head>
<title>내 정보</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
<style>
	input{
		margin:10px;
		width:150px;
		height:30px;
		font-weight:bold;
	}
</style>
</head>

<%
	//로그인 여부 검사
   if(session.getAttribute("memId")==null){ %>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<% } %>

<body onLoad="focusIt();">
	<%@ include file="../header/listMember.jsp"%>
	<h2>내 정보페이지</h2>
		<table border="1">
			<tr>
				<th><%=session.getAttribute("memId")%>님이 방문하셨습니다.</th>
			</tr>
			<tr>
				<td>
					<input type="button" value="회원정보변경" onclick="javascript:window.location='modifyForm.jsp'" >
					<input type="button" value="내 주문 확인" onclick="location='/pt1/cart/mypay.jsp'">
					<input type="button" value="내 리뷰 보기" onclick="location='/pt1/reply/replyMyList.jsp'">
					<input type="button" value="환불신청내역" onclick="location='/pt1/cart/refundPage.jsp'">
					<input type="button" value="탈퇴하기" onclick="location='/pt1/member/deleteForm.jsp'">
				</td>
			</tr>
		</table>
	<br>
</body>
</html>
