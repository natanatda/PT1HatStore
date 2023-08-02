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
    height:100%;
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
    height:100%;
    color: #fff;
    border: none;
    cursor: pointer;
  }
  
  /* 자동 로그인 체크박스 */
  input[type="checkbox"] {
  height:100%;
    margin-top: 10px;
  }
  
  /* 버튼 그룹 */
  .button-group {
    display: flex;
    justify-content: space-between;
    background-color: #7AC9EB;
     color: #fff;
  }
  
  /* 하단 버튼 */
  .button-group input[type="button"] {
    background-color: #7AC9EB;
    height:100%;
     color: #fff;
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    cursor: pointer;
  }
  
  
    input[type="button"] {
        background-color: #2196F3;
        height:100%;
        border: none;
        color: #fff;
        padding: 10px 20px;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    }


</style>



<jsp:useBean id="member" class="pt1.MemberDTO">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>
 
<%
    String id = (String)session.getAttribute("memId");  //수정폼에서 아이디는 안넘어와서 추가로 집어넣어줌
	member.setId(id);

	MemberDAO manager = MemberDAO.getInstance();
    manager.updateMember(member);
 %>
<link href="style.css" rel="stylesheet" type="text/css">

<table width="270" border="0" cellspacing="0" cellpadding="5">
  <tr bgcolor="pink"> 
    <td height="39"  >
	  <font size="+1" ><b>회원정보가 수정되었습니다.</b></font></td>
  </tr>
  <tr>
    <td bgcolor="pink"> 
      <p>입력하신 내용대로 수정이 완료되었습니다.</p>
    </td>
  </tr>
  <tr>
    <td bgcolor="pink" > 
      <form>
	    <input type="button" value="메인으로" onclick="window.location='/pt1/main/main.jsp'">
      </form>
      5초후에 메인페이지로 이동합니다.<meta http-equiv="Refresh" content="5;url=/pt1/main/main.jsp" >
    </td>
  </tr>
</table>
</body>
</html>
    