<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
/* 전체 폼 */
form {
	width: 400px;
	margin: 50px auto;
	font-family: 'Noto Sans KR', sans-serif;
}

/* 제목 */
h1 {
	font-size: 2.5em;
	margin-bottom: 20px;
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
	width: 100%;
}

/* 하단 버튼 */
.button-group input[type="button"] {
	width: 48%;
	background-color: #ddd;
	color: #333;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	cursor: pointer;
}
</style>

<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
    
    function checkIt() {
        var userinput = eval("document.userinput");
        if(!userinput.id.value) {
            alert("사업자ID를 입력하세요");
            return false;
        }
        
 }
</script>
</head>
<body>
	<h1>사업자 로그인</h1>
	<form action="storeloginPro.jsp" method="post">
		<label for="id">사업자 ID :</label> <input type="text" name="store_id" /><br />
		<label for="id">사업자 PW :</label> <input type="password" name="store_pw" />
		<input type="hidden" name="level_num" value="2" /><br /> 
		<%-- 점주 레벨 2 --%>
		<input type="submit" value="로그인" />
		
			<%-- <label><input type="checkbox" name="auto" value="1" />자동로그인</label> --%>
			<%-- <input type="button" value="비회원 로그인" onclick="javascript:window.location='guestloginForm.jsp'" />
  </div>--%>
			<div class="button-group">
				<input type="button" value="사업자 회원가입"
					onclick="javascript:window.location='storeinputForm.jsp'" />
				<input type="button" value="ID/PW찾기"
					onclick="javascript:window.location='findForm.jsp'" />
	
			</div>
				<input type="button" value="취소" onclick="javascript:window.location='/pt1/main/main.jsp'" />
	</form>
	<a href="/pt1/main/main.jsp">메인으로</a>
</body>
</html>