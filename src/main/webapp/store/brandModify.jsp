<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.BrandDAO" %>
<%@ page import="pt1.BrandDTO" %>
<%@ page import="java.util.List" %>

<%
	//관리자 여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}
	String brandNo=request.getParameter("brandNo");
	String pageNum = request.getParameter("pageNum");

	//브랜드 정보 불러오기
	BrandDAO dao = BrandDAO.getInstance();
	BrandDTO brand = dao.getBrand(Integer.parseInt(brandNo));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 정보 수정</title>
<script src="/pt1/resources/js/brandLaunch.js"></script>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<body>
	<%@ include file="../header/listStore.jsp" %>
	<h2>브랜드 정보 수정</h2>
	<form name="userinput" action="brandModifyPro.jsp" method="post" enctype="multipart/form-data" onsubmit="return checkInput()">
		<input type="hidden" name="brandNo" value="<%=brandNo%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<table border="1">
			<tr>
				<td>점주아이디</td>
				<td><%=brand.getStore_id()%></td>
			</tr>
			<tr>
				<td>브랜드번호</td>
				<td><%=brand.getBrandNo()%></td>
			</tr>
			<tr>
				<td>브랜드명</td>
				<td><input type="text" name="brand" value="<%=brand.getBrand()%>"></td>
			</tr>
			<tr>
				<td>대표자</td>
				<td><input type="text" name="representative" value="<%=brand.getRepresentative()%>"></td>
			</tr>
			<tr>
				<td>사업자등록번호</td>
				<td><input type="text" name="bnumber" value="<%=brand.getBNumber()%>" oninput="autoHyphen(this)" maxlength="10"></td>
			</tr>
			<tr>
				<td>업종</td>
				<td><input type="text" name="sectors" value="<%=brand.getSectors()%>"></td>
			</tr>
			<tr>
				<td>소재지</td>
				<td><input type="text" name="blocation" value="<%=brand.getBLocation()%>"></td>
			</tr>
			<tr>
				<td>사업자등록증 첨부(pdf만 가능)</td>
				<td>
					<!-- 사업자등록증 파일 선택 input 태그 추가 -->
					수정 시에도 사업자 등록증을 반드시 첨부해주세요.<br>
					<input type="file" name="bsave" accept=".pdf">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정">
					<input type="button" value="취소" onclick="location='brandList.jsp?pageNum=<%=pageNum%>'">					
				</td>
			</tr>
		</table>
	</form>
</body>
</html>