<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  .button-group input[type="button"] {
    background-color: #ddd;
    color: #333;
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    cursor: pointer;
  }
  
  
</style>
        <h1>ID 찾기</h1>
    <form action="idFInd.jsp" method="post">
    	이름 : <input type="text" name="name"/> <br/></br>
    	이메일 : <input type="text" name="email"/></br></br>
        전화번호 : <input type="text" name="tel" placeholder="010-0000-0000"/></br></br>
    			 <br/>
    			 <input type="submit" value="ID찾기" />    
    			 <input type="button" onclick="location='/pt1/member/loginForm.jsp'" value="취소"/>
    </form>
    <hr/>