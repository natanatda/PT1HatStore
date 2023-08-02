<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>


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

hr {
  border: none;
  border-top: 1px solid #ccc;
  margin: 20px 0;
}

table {
  border-collapse: collapse;
  margin: 0 auto;
  border-radius: 5px; /* 테이블 모서리 둥글게 */
  overflow: hidden; /* 테이블 크기가 넘어갈 때 부분 숨기기 */
}

th,
td {
  padding: 10px;
  border: 1px solid #ccc;

  background-color: #fff;
  
}

th {
  background-color: #00BFFF;
}

tr:nth-child(even) {
  background-color: #00BFFF;
}

a {
  display: block;
 
  padding: 10px;
  background-color: #00BFFF;
  color: #fff;
  font-weight: bold;
  text-decoration: none;
  border-radius: 5px;
  margin: 20px auto;
  max-width: 100px;
}

/* 하늘색 배경 색상 조절 */
h1,
h2,
h3,
a,
th {
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
  


  .button-group input[type="button"] {
    background-color: #ddd;
    color: #333;
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    cursor: pointer;
  }
  
  
  input[type="text"], input[type="password"], textarea {  /*입력칸 사이즈 다똑같게*/
  box-sizing: border-box;
  width: 80%;
  padding: 5px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}
  
</style>


<script src="/pt1/resources/js/memberinput.js"></script>

<body bgcolor="white">

<form method="post" action="inputPro.jsp" name="userinput" onSubmit="return checkIt()">
  <table width="600" border="1" cellspacing="0" cellpadding="3" >
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
      <td width="200">전화번호</td>
      <td width="400"> 
        <input type="text" name="tel" size="40" maxlength="13" oninput="autoHyphen(this)" placeholder="010-0000-0000">
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
      
      
      <input type="text" id="sample4_postcode" placeholder="우편번호">
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
<input type="text" id="sample4_jibunAddress" placeholder="지번주소">
<span id="guide" style="color:#999;display:none"></span>
<input type="text" id="sample4_extraAddress" placeholder="참고항목">
<input type="text" id="sample4_detailAddress" placeholder="상세주소">
<input type="hidden" id="address" name="address" >
      

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<script>
var postcodeInput = document.getElementById("sample4_postcode");
var roadAddressInput = document.getElementById("sample4_roadAddress");
var jibunAddressInput = document.getElementById("sample4_jibunAddress");
var extraAddressInput = document.getElementById("sample4_extraAddress");
var detailAddressInput = document.getElementById("sample4_detailAddress");
var fullAddressInput = document.getElementById("address");

function updateFullAddress() {
  var address = roadAddressInput.value + " " + jibunAddressInput.value + " " + extraAddressInput.value + " " + detailAddressInput.value;
  fullAddressInput.value = address;
}

postcodeInput.addEventListener("input", updateFullAddress);
roadAddressInput.addEventListener("input", updateFullAddress);
jibunAddressInput.addEventListener("input", updateFullAddress);
extraAddressInput.addEventListener("input", updateFullAddress);
detailAddressInput.addEventListener("input", updateFullAddress);

</script>
      
      
       <%-- <input type="text" name="address" size="60" maxlength="50">--%>
      </td>
    </tr>

    <tr> 
      <td colspan="2" align="center" bgcolor="pink"> 
      </br>
     <label style="display: inline-block;">
  
  <details style="margin-left: 10px;">
    <summary>제 1조 (목적)</summary>
    <p>
     
      본 약관은 모자 (이하 "회사")에서 운영하는 인터넷사이트 사이트에서 제공하는 인터넷 관련 서비스 (이하 "서비스")를 이용함에 있어서 회사와 이용자의 권리와 의무 및 책임사항을 규정함을 목적으로 합니다.
    </p>
      </details>
</br>

  <label style="display: inline-block;">

  <details style="margin-left: 10px;">
     <summary>제 2조 (정의)</summary>
    <p>
     
      1. "사이트"란 회사가 재화 또는 서비스를 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 설정한 가상의 영업장을 말합니다.<br>
      2. "이용자"란 "사이트"에 접속하여 이 약관에 따라 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.<br>
      3. "회원"이라 함은 "사이트"에 개인정보를 제공하여 회원등록을 한 자로서, "사이트"의 정보를 지속적으로 제공받으며, "사이트"가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.<br>
      4. "비회원"이라 함은 회원에 가입하지 않고 "사이트"가 제공하는 서비스를 이용하는 자를 말합니다.
    
    </p>
      </details>
     </br> 
    <label style="display: inline-block;">

  <details style="margin-left: 10px;">
    <summary>제 3조  (약관의 게시와 개정)</summary>
    <p>
1. 회사는 이 약관의 내용과 상호 및 대표자 성명, 사업자 등록번호, 연락처 등을 이용자가 알 수 있도록 [사이트 초기화면]에 게시합니다.
2. 회사는 필요하다고 인정되는 경우 이용약관을 개정할 수 있습니다.
3. 회사가 이용약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 [사이트 초기화면]에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관 내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다.

      
    </p>
      </details>
     
      




</label></br></br>


 <input type="checkbox" name="terms" required> 이용약관 동의
 </br>
 </br>
          <input type="reset" name="reset" value="다시입력">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="submit" name="confirm" value="등   록" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" value="비회원" onclick="javascript:window.location='guestloginForm.jsp'">
      </td>
    </tr>
  </table>
</form>
<a href="/pt1/main/main.jsp">메인으로</a>
</body>
</html>

