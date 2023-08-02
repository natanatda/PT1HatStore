<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/view/color.jsp"%>
<%request.setCharacterEncoding("utf-8"); %>
<html>
<head>
<title>회원가입</title>

 <html>
  <head>
    <meta charset="UTF-8">
   <%--  
    <style>
      /* 전체 테이블 */
      table {
        width: 600px;
        margin: 20px auto;
        border-collapse: collapse;
        font-family: 'Noto Sans KR', sans-serif;
      }

      /* 테이블 타이틀 */
      tr.title {
        height: 39px;
        background-color: pink;
        text-align: center;
        font-size: 1.3em;
        font-weight: bold;
      }

      /* 셀 타이틀 */
      th {
        width: 200px;
        background-color: #fafafa;
        border: 1px solid #ddd;
        padding: 10px;
        font-weight: normal;
        text-align: left;
      }

      /* 인풋 타입 */
      input[type="text"], 
      input[type="password"], 
      input[type="button"] {
        width: 100%;
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ddd;
        font-size: 1em;
        margin: 5px 0;
        box-sizing: border-box;
      }

      /* 버튼 */
      input[type="submit"], 
      input[type="button"] {
        background-color: #2196F3;
        color: #fff;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        cursor: pointer;
      }

      input[type="button"] {
        background-color: #ddd;
        color: #333;
        margin-left: 10px;
      }

      /* 에러 메시지 */
      .error-message {
        color: #f44336;
        font-size: 0.9em;
        margin-top: 5px;
      }
    </style>
  --%>
  
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


<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
    
    function checkIt() {
        var userinput = eval("document.userinput");
        if(!userinput.id.value) {
            alert("ID를 입력하세요");
            return false;
        }
        
        if(!userinput.pw.value ) {
            alert("비밀번호를 입력하세요");
            return false;
        }
        if(userinput.pw.value != userinput.pw2.value)  //비밀번호랑 비밀번호확인이랑 같지않으면
        {
            alert("비밀번호를 동일하게 입력하세요");
            return false;
        }
       
        if(!userinput.username.value) {
            alert("사용자 이름을 입력하세요");
            return false;
        }
      
    }

    // 아이디 중복 여부를 판단
    function openConfirmId(userinput) {   //여기 대입되는게 this.form 폼태그임. 위에 하고 있는것처럼 도큐맨트 점 인풋 점 막 이케 해도되는데 여기선 그렇게 안한거임. 
        // 아이디를 입력했는지 검사
       
        	if (userinput.id.value == "") {
                alert("아이디를 입력하세요");
                return;
            }
    
    		
            // url과 사용자 입력 id를 조합합니다.
            url = "confirmId.jsp?id="+userinput.id.value ;  //?뒤쪽으로는 주소가 아니라 겟방식으로 보내고 있는 파라미터임. 지금은 사용자가 입력간 값을... 
            
            // 새로운 윈도우를 엽니다.
            open(url, "confirm",  "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");  //새 창 나오는게 open함수임. 
        }
        
</script>


<body bgcolor="white">

<form method="post" action="inputPro.jsp" name="userinput" onSubmit="return checkIt()">
  <table width="600" border="1" cellspacing="0" cellpadding="3" align="center" >
    <tr> 
    <td colspan="2" height="39" align="center" bgcolor="pink" >
       <font size="+1" ><b>회원가입</b></font></td>
    </tr>
    <tr> 
      <td width="200" bgcolor="<%=value_c%>"><b>아이디 입력</b></td>
      <td width="400" bgcolor="<%=value_c%>">&nbsp;</td>
    </tr>  

    <tr> 
      <td width="200"> ID</td>
      <td width="400"> 
        <input type="text" name="id" size="10" maxlength="12">
  		 <input type="button" name="confirm_id" value="ID중복확인" 
        							OnClick="openConfirmId(this.form)">  
      </td>
    </tr>
    <tr> 
      <td width="200"> 비밀번호</td>
      <td width="400" > 
        <input type="password" name="pw" size="15" maxlength="12">
      </td>
    <tr>  
      <td width="200">비밀번호 확인</td>
      <td width="400"> 
        <input type="password" name="pw2" size="15" maxlength="12">
      </td>
    </tr>
    
    <tr> 
      <td width="200" bgcolor="<%=value_c%>"><b>개인정보 입력</b></td>
      <td width="400" bgcolor="<%=value_c%>">&nbsp;</td>
    <tr>  
    <tr> 
      <td width="200">사용자 이름</td>
      <td width="400"> 
        <input type="text" name="name" size="15" maxlength="10">
      </td>
    </tr>
    <tr> 
      <td width="200">생년월일</td>
      <td width="400"> 
        <input type="text" name="birth" size="7" maxlength="6">
      </td>
    </tr>
    <tr> 
      <td width="200">전화번호</td>
      <td width="400"> 
        <input type="text" name="tell" size="40" maxlength="30">
      </td>
    </tr>
    <tr> 
      <td width="200">이메일</td>
      <td width="400"> 
        <input type="text" name="email" size="60" maxlength="50">
      </td>
    </tr>
    <tr> 
      <td width="200">주소</td>
      <td width="400"> 
        <input type="text" name="address" size="60" maxlength="50">
      </td>
    </tr>
    <tr> 
      <td colspan="2" align="center" bgcolor="pink"> 
          <input type="submit" name="confirm" value="등   록" >
          <input type="reset" name="reset" value="다시입력">
          <input type="button" value="비회원" onclick="javascript:window.location='guestloginForm.jsp'">
      </td>
    </tr>
  </table>
</form>
</body>
</html>
