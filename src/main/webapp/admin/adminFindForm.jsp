<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.AdminDAO" %>
<%request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="dto" class="pt1.AdminDTO" />
<jsp:setProperty property="*" name="dto"/>

<style>
body {
  background-color: #f1f1f1;
  font-family: Arial, Helvetica, sans-serif;
  font-size: 14px;
  color: #333;
}

h1,
h2,
h3 {
  margin-top: 0;
  color: #fff;
  background-color: #f1f1f1;
  padding: 10px;
}
div

/* 하늘색 배경 색상 조절 */
h1,
h2,
h3 {
  background-color: #7AC9EB;
  color: #fff;
}
  input[type="submit"] {
    font-size: 1.2em;
    padding: 10px 20px;
    background-color: #2196F3;
    color: #fff;
    border: none;
    cursor: pointer;
  }
  input[type="submit"] {
  border-radius: 5px; /* 테두리를 부드럽게 만들기 위해 값을 주었습니다. */
  border: none; /* 기존에 있던 테두리를 제거합니다. */
  padding: 10px 20px; /* 버튼 내부에 여백을 주어 크기를 늘립니다. */
  background-color:#2196F3; /* 버튼의 배경색을 설정합니다. */
  color: white; /* 버튼 내부의 글자 색상을 설정합니다. */
  font-size: 16px; /* 버튼 내부의 글자 크기를 설정합니다. */
}

  input[type="button"] {
    background-color: #ddd;
    color: #333;
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    cursor: pointer;
    font-size: 16px;
  }
</style>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 계정찾기</title>
</head>
<body>
	<div>
	<h1>비밀번호 찾기</h1>
	<form action="adminFindPro.jsp" name="pwFind" method="post">
		아이디 : <input type="text" name="id" />
		<input type="submit" value="찾기" />
		<input type="button" onclick="location='/pt1/member/loginForm.jsp'" value="취소"/>
	</form>
	<hr />
	</div>

</body>
</html>