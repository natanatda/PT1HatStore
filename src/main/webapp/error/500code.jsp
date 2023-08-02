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
<title>error500</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/error.css">
</head>
<body>
	<div class="er500">
		<h1>오류가 발생하였습니다.(500)</h1>
		<p>이용에 불편을 드려 죄송합니다. <br>
		요청하신 페이지에 문법적 오류가 있습니다. <br> 
		입력하신 내용을 다시 한 번 확인하시어 제출 바랍니다. <br>
		동일한 오류가 반복적으로 발생하는 경우 문의를 이용하세요.</p>
		<a href="/pt1/main/main.jsp">메인이동</a>
	</div>
</body>
</html>