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
    text-align: center;
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
  input[type="text"], input[type="password"], input[type="submit"], input[type="button"], input[type="reset"] {
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



    
  
    

<form method="post" action="storeinputForm.jsp">

   
       <tr><td><font size="+1" ><b>사업자 여부 체크</b></font></td></tr> </br></br>

      상호명 입력
      <input type="text" name="store_id" size="10" maxlength="12">

    
     
      사업자 등록 코드 입력
  
        <input type="password" name="store_code" size="15" maxlength="12">


          <input type="submit" name="confirm" value="등   록" >

    