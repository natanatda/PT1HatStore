<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/view/color.jsp"%>
<%request.setCharacterEncoding("utf-8"); %>


  
<style>
body {
	background-color: #f1f1f1;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	color: #333;
}

h1, h2, h3 {
	margin-top: 0;
	text-align: center;
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
	border-radius: 10px; /* 테이블 모서리 둥글게 */
	overflow: hidden; /* 테이블 크기가 넘어갈 때 부분 숨기기 */
}

th, td {
	padding: 10px;
	border: 1px solid #ccc;
	text-align: center;
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
	text-align: center;
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
h1, h2, h3, a, th {
	background-color: #7AC9EB;
	color: #fff;
}

input[type="submit"] {
	border-radius: 5px; /* 테두리를 부드럽게 만들기 위해 값을 주었습니다. */
	padding: 5px 20px;
	background-color: #2196F3;
	color: #fff;
	border: none;
	cursor: pointer;
	height: 100%;
}


input[type="button"] {
	background-color: #ddd;
	color: #333;
	border: none;
	cursor: pointer;
	border-radius: 5px;
	height: 100%;
	padding: 5px 20px;
}
</style>
<html>
<head><title>회원탈퇴</title>
<link href="style.css" rel="stylesheet" type="text/css">

   <script language="javascript">
     
       function begin(){
         document.myform.pw.focus();
       }

       function checkIt(){
		  if(!document.myform.pw.value){
           alert("비밀번호를 입력하지 않으셨습니다.");
           document.myform.pw.focus();
           return false;
         }
	   }   
     
   </script>
</head>
<BODY onload="begin()" bgcolor="white" > <%--온로그는 페이지 시작하자마자 하는거라 포거스랑 많이 같이 쓰임 --%>
<form name="myform" action="deletePro.jsp" method="post" onSubmit="return checkIt()">
<TABLE cellSpacing=1 cellPadding=1 width="260" border=1 align="center" >
  
  <TR height="30">
    <TD colspan="2" align="middle" bgcolor="pink">
	  <font size="+1" ><b>회원 탈퇴</b></font></TD></TR>
  
  <TR height="30">
    <TD width="110" bgcolor="pink" align=center>비밀번호</TD>
    <TD width="150" align=center>
      <INPUT type=password name="pw"  size="15" maxlength="12"></TD></TR>
  <TR height="30">
    <TD colspan="2" align="middle" bgcolor="pink" >
      <INPUT type=submit value="회원탈퇴"> 
      <input type="button" value="취  소" onclick="javascript:window.location='mypage.jsp'"></TD></TR>
</TABLE>
</form>
</BODY>
</HTML>
    