<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="test.web.model.MemberBean" %>



<%


String tel = request.getParameter("tel");



MemberBean mb = new MemberBean();  //객체 생성
boolean result5 = mb.Tel(tel);

if(result5 == true) {
   result5=true;
} else {
    if(result5 == false) {
        out.println("<script>alert('전화번호는 하이픈 제외하고 작성해주세요');history.go(-1);</script>");
    }
}
%>

    <script> 
        alert("인증번호가 전송되었습니다");
         history.go(-1);
      </script>
      
     
