<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 입점 신청</title>
<script src="/pt1/resources/js/brandLaunch.js"></script>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<body>
<%
	//점주 여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}%>
	<%@ include file="../header/listStore.jsp" %>
	<h2>브랜드 입점 신청</h2>
	<form name="userinput" method="post" action="brandLaunchPro.jsp" enctype="multipart/form-data" onsubmit="return checkInput()">
		<input type="hidden" name="store_id" value="<%= stoId %>">
		<table border="1">
			<tr>
				<td>브랜드명</td>
				<td><input type="text" name="brand"></td>
			</tr>
			<tr>
				<td>대표자</td>
				<td><input type="text" name="representative"></td>
			</tr>
			<tr>
				<td>사업자등록번호</td>
				<td><input type="text" name="bnumber" placeholder="123-45-67890" oninput="autoHyphen(this)" maxlength="10"></td>
			</tr>
			<tr>
				<td>업종</td>
				<td><input type="text" name="sectors"></td>
			</tr>
			<tr>
				<td>소재지</td>
				<td><input type="text" name="blocation"></td>
			</tr>
			<tr>
				<td>사업자등록증 첨부(pdf만 가능)</td>
				<td><input type="file" name="bsave" accept=".pdf"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="취 소"
					onclick="javascript:window.location='/pt1/store/brandList.jsp'">
					<input type="submit" value="신 청">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>