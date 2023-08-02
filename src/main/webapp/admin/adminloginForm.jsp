<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 

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
  input[type="text"], input[type="password"], input[type="submit"], input[type="button"] {
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
  }
  
  /* 하단 버튼 */
  .button-group input[type="button"] {
  	width:49%;
    background-color: #ddd;
    color: #333;
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    cursor: pointer;
  }
</style>
 
<h1>관리자 로그인</h1>
<form action="adminloginPro.jsp" method="post">
	<label for="id">관리자 id :</label>
	<input type="text" name="id" />
	<br />
	<label for="pw">관리자 pw :</label>
	<input type="password" name="pw" />
	<input type="hidden" name="level_num" value="3" /><%-- 관리자 레벨 3 --%>
	<br />
	<input type="submit" value="로그인" />

	<div class="button-group">
		<input type="button" value="비밀번호 찾기"
			onclick="javascript:window.location='adminFindForm.jsp'" /> <input
			type="button" value="취소"
			onclick="javascript:window.location='/pt1/main/main.jsp'" />
	</div>
</form>
