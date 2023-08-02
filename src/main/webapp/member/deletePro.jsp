<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "pt1.MemberDAO" %>
<%@ include file="/view/color.jsp"%>
<%request.setCharacterEncoding("utf-8"); %>

  
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

th,
td {
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
  
  
</style>
<html>
<head>
<title>회원탈퇴</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
    String id = (String)session.getAttribute("memId");  //세션에서 꺼내주고있음 
	String pw  = request.getParameter("pw");
	
	MemberDAO manager = MemberDAO.getInstance();
    int check = manager.deleteMember(id,pw);   //삭제 진행 
	
	if(check==1){
		session.invalidate();
%>
<body bgcolor="pink">
<form method="post" action="/pt1/main/main.jsp" name="userinput" >
  <tr bgcolor="pink"> 
    <td height="39" align="center">
	  <font size="+1" ><b>회원정보가 삭제되었습니다.</b></font></td>
  </tr>
  <tr bgcolor="pink">
    <td align="center"> 
      <p>힝.... 아쉽네요... 안녕히 가세요.</p>
      <meta http-equiv="Refresh" content="5;url=main.jsp" >
    </td>
  </tr>
  <tr bgcolor="pink">
    <td align="center"> 
      <input type="submit" value="확인">
    </td>
  </tr>
</table>
</form>
<%}else {%>
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<%}%>

</body>
</html>
    