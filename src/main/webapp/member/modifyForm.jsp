<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="pt1.*"%>
<%@ include file="/view/color.jsp"%>
<%request.setCharacterEncoding("utf-8"); %>

<style>
body {
	background-color: #f1f1f1;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	color: #333;
}

h1, h2, h3 {
	margin-top: 0;
	color: #fff;
	background-color: #f1f1f1;
	padding: 10px;
}

hr {
	border: none;
	border-top: 1px solid #ccc;
	margin: 20px 0;
}

table {
	border-collapse: collapse;
	margin: 0 auto;
	border-radius: 5px; /* 테이블 모서리 둥글게 */
	overflow: hidden; /* 테이블 크기가 넘어갈 때 부분 숨기기 */
}

th, td {
	padding: 10px;
	border: 1px solid #ccc;
	background-color: #fff;
}

th {
	background-color: #00BFFF;
}

tr:nth-child(even) {
	background-color: #00BFFF;
}

a {
	display: block;
	padding: 10px;
	background-color: #00BFFF;
	color: #fff;
	font-weight: bold;
	text-decoration: none;
	border-radius: 5px;
	margin: 20px auto;
	max-width: 100px;
}

/* 하늘색 배경 색상 조절 */
h1, h2, h3, a, th {
	background-color: #7AC9EB;
	color: #fff;
}

/* 입력 필드 라벨 */
label {
	display: block;
	margin-bottom: 5px;
	font-size: 1.1em;
	font-weight: bold;
}

/* 입력 필드 */
input[type="text"], input[type="password"], input[type="submit"], input[type="button"]
	{
	width: 100%;
	height: 100%;
	padding: 10px;
	border-radius: 5px;
	border: 1px solid #ddd;
	font-size: 1.1em;
	margin: 5px 0;
	box-sizing: border-box;
}

/* 로그인 버튼 */
input[type="submit"] {
	background-color: #2196F3;
	color: #fff;
	border: none;
	cursor: pointer;
}

/* 자동 로그인 체크박스 */
input[type="checkbox"] {
	margin-top: 10px;
}

/* 버튼 그룹 */
.button-group {
	display: flex;
	justify-content: space-between;
}

/* 하단 버튼 */
.button-group input[type="button"] {
	background-color: #ddd;
	color: #333;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	cursor: pointer;
}
</style>


<%
    String id = (String)session.getAttribute("memId");  //세션 꺼내오고있음. 아이디는 현재 세션에 보관되어있으니까. 세션으로부터 아이디 꺼내옴
   
    MemberDAO manager = MemberDAO.getInstance();
    MemberDTO c = manager.getMember(id);
    
%>


<html>
<head>
<title>회원정보수정</title>
<script src="/pt1/resources/js/memberinput.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="<%=bodyback_c%>">
	<form method="post" action="modifyPro.jsp" name="userinput" onsubmit="return checkIt2()">

		<table width="600" border="1" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="2" height="39" bgcolor="<%=title_c%>"><font
					size="+1"><b>회원 정보수정</b></font></td>
			</tr>
			<tr>
				<td colspan="2" class="normal">회원의 정보를 수정합니다.</td>
			</tr>
			<tr>
				<td width="200" bgcolor="<%=value_c%>"><b>아이디 입력</b></td>
				<td width="400" bgcolor="<%=value_c%>">&nbsp;</td>
			<tr>
			<tr>
				<td width="200">사용자 ID</td>
				<td width="400"><%=c.getId()%></td>
			</tr>

			<tr>
				<td width="200">비밀번호</td>
				<td width="400"><input type="password" name="pw" maxlength="13"></td>
			<tr>
			<tr>
				<td width="200">비밀번호 확인</td>
				<td width="400"><input type="password" name="pw2" maxlength="13"></td>
			<tr>
			<tr>
				<td width="200" bgcolor="<%=value_c%>"><b>개인정보 입력</b></td>
				<td width="400" bgcolor="<%=value_c%>">&nbsp;</td>
			<tr>
			<tr>
				<td width="200">사용자 이름</td>
				<td width="400">
				<input type="text" name="name" size="15" maxlength="20" value="<%=c.getName()%>"> <%-- 변경가능하니까 벨류에..요렇게 --%>
				</td>
			</tr>

			<tr>
				<td width="200">전화번호</td>
				<td width="400">
					<%if(c.getTel()==null){%>
					<input type="text" name="tel" size="40" maxlength="13" oninput="autoHyphen(this)" placeholder="010-0000-0000">
					<%}else{%>
					<input type="text" name="tel" size="40" maxlength="13" value="<%=c.getTel()%>" oninput="autoHyphen(this)" placeholder="010-0000-0000">
					<%}%>
				</td>
			</tr>
			
			<tr>
				<td width="200">E-Mail</td>
				<td width="400">
					<%if(c.getEmail()==null){%>
					<input type="text" name="email" size="40" maxlength="30">
					<%}else{%>
					<input type="text" name="email" size="40" maxlength="30" value="<%=c.getEmail()%>">
					<%}%>
				</td>
			</tr>
				<tr>
				<td width="200">주소</td>
				<td width="400">
					<%if(c.getAddress()==null){%>
					<input type="text" name="address" size="40" maxlength="30">
					<%}else{%>
					<input type="text" name="address" size="40" maxlength="30" value="<%=c.getAddress()%>">
					<%}%>
				</td>
			</tr>

			<tr>
				<td colspan="2" align="center" bgcolor="<%=value_c%>">
				<input type="submit" name="modify" value="수   정">
				<input type="button" value="취  소" onclick="javascript:window.location='/pt1/main/main.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>