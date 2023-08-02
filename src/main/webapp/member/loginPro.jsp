<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="pt1.MemberDAO" %>
<%@ page import= "java.util.ArrayList" %>
<%@ page import="test.web.model.MemberBean" %>
   
    

<%request.setCharacterEncoding("utf-8"); %>
       
       <%
    String id = request.getParameter("id");             //액션태그 안쓰고 (셋프로펄티같은거안쓰구...)  하나씩 받았음
    String pw  = request.getParameter("pw");
    String level_num= request.getParameter("level_num");
    	
  	MemberDAO manager = MemberDAO.getInstance();      //싱글인스턴스로 DB에 대한 객체 받아옴
   
	int check= manager.userCheck(id,pw);   //유저 체크 메소드 호출 . 따로 받았기때문에 따로 매개변수 두개. 원래는 DTO로 한번에 했었음. 
    if(check==1){
    	session.setAttribute("memId",id);  //로그인 성공하면 세션 만듦.
        session.setAttribute("level_num", level_num);
        response.sendRedirect("/pt1/main/main.jsp");
      }else if(check==0){ %>
      <script> 
        alert("아이디와 비밀번호를 확인하세요.");
         history.go(-1);
      </script>
      <%}else if(check==2){%>
      <script>
        alert("비정상적인 활동으로 계정이 정지되었습니다.");
        history.go(-1);
      </script>
   <% } %>   
   