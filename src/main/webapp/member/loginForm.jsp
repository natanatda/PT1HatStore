<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>


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
    background-color: #ddd;
    color: #333;
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    cursor: pointer;
  }
</style>
 
<h1>로그인</h1>
<form action="loginPro.jsp" method="post">
  <label for="id">id :</label>
  <input type="text" name="id" />
  <br />
  <label for="pw">pw :</label>
  <input type="password" name="pw" />
  <br />
  <input type="hidden" name="level_num" value="1" /> <%-- 일반회원 레벨 1 --%>
  <input type="submit" value="로그인" />
  <div class="button-group">
    <%-- <label><input type="checkbox" name="auto" value="1" />자동로그인</label> --%>
    <%-- <input type="button" value="비회원 로그인" onclick="javascript:window.location='guestloginForm.jsp'" />
  </div>--%>
  <div class="button-group">
    <input type="button" value="회원가입" onclick="javascript:window.location='inputForm.jsp'" /></div>
     <div class="button-group">
    <input type="button" value="아이디찾기" onclick="javascript:window.location='findForm.jsp'" /></div>
    <div class="button-group">
    <input type="button" value="비밀번호찾기" onclick="javascript:window.location='pwfindForm.jsp'" /></div>
  </div>
  <input type="button" value="취소" onclick="javascript:window.location='/pt1/main/main.jsp'" />
</form>


<a href="/pt1/main/main.jsp">메인이동</a>
<%-- 
<form action= "loginPro.jsp" method="post">
	id :<input type="text"  name="id" /> <br/>

	
	pw :<input type="password"  name="pw" /> <br/>

		
	            <input type="submit" value="로그인" />
	            	  
	            	  <input type="checkbox" name="auto" value="1"/>자동로그인 
	            	  <br>
	            	  <br>
	            	  <input type="button" value="비회원 로그인" onclick="javascript:window.location='guestloginForm.jsp'">
	                 <br>
	                 <br>
	                 <input type="button" value="회원가입" onclick="javascript:window.location='inputForm.jsp'">
	                 <br>
	                 <br>
	                 <input type="button" value="아이디찾기" onclick="javascript:window.location='findForm.jsp'">
</form>


--%>


<%--
	String cooId = null;
	String cooPw = null;
	Cookie [] cookies = request.getCookies();
	for(Cookie c : cookies){
		if(c.getName().equals("cooId")){
			cooId = c.getValue();
		}if(c.getName().equals("cooPw")){
			cooPw = c.getValue();
		}
	}
	if(cooId !=null && cooPw !=null){
		response.sendRedirect("loginPro.jsp");
	}
		
--%>
