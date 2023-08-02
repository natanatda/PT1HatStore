<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>

<%
	// 현재 페이지가 정상적으로 응답되는 페이지임을 지정
    // 코드 생략 시 웹 브라우저가 자체적으로 제공하는 에러 페이지 출력
    response.setStatus(HttpServletResponse.SC_OK);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>error404</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/error.css">
</head>
<body>
	<div class="er404">
		<h1>페이지를 찾을 수 없습니다.(404)</h1>
		<p>이용에 불편을 드려 죄송합니다. <br>
		올바른 URL을 입력하였는지 확인하세요. 
		자세한 내용은 사이트 소유자에게 문의하시기 바랍니다.</p>
		<a href="/pt1/main/main.jsp">메인이동</a>
	</div>
</body>
</html>