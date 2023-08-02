<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="pt1.AdminDAO" %>
    
<%-- 인코딩 방식 설정 --%>
<%request.setCharacterEncoding("UTF-8"); %>
       
       <%
    String id = request.getParameter("id");             
   String pw  = request.getParameter("pw");
   String level_num= request.getParameter("level_num");
 
    
   AdminDAO manager = AdminDAO.getInstance();   //dao
    int check= manager.adminCheck(id,pw);   // dao에서 유효성 겁사 통과했으면 check==1 / 통과 못했으면(id/pw 틀렸으면) check==0
  //로그인 성공 true
   if(check==1){
      session.setAttribute("admId",id);  //로그인 성공하면 세션 만듦.
      session.setAttribute("level_num", level_num);
      response.sendRedirect("/pt1/main/main.jsp");
   }else if(check==0){%>
   <%-- dao에서 유효성 검사 통과 못했으면 check==0 --%>
   <script> 
     alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
   </script>
<%   }else{ %>
   <script>
     alert("아이디가 맞지 않습니다..");
     history.go(-1);
   </script>
<%}   %>   

