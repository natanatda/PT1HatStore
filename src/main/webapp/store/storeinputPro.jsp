<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.StoreDAO" %>
<%@ page import="test.web.model.MemberBean" %>
<%@ page import= "java.util.ArrayList" %>
<%request.setCharacterEncoding("UTF-8"); %>
    
<jsp:useBean id="store" class="pt1.StoreDTO">
    <jsp:setProperty name="store" property="*"/>
</jsp:useBean>
<script src="/pt1/resources/js/storeinput.js"></script>

<%
   //StoreDAO manager= StoreDAO.getInstance();
	//manager.insertStore(store);
	//response.sendRedirect("storeloginForm.jsp");

%>



<%
ArrayList<Integer> code = new ArrayList<Integer>();
for (int i=48; i<=57; i++){
    code.add(i);
}
for(int i=65; i<=90; i++){
    code.add(i);
}
for(int i=97; i<=122; i++){
    code.add(i);
}

String id = request.getParameter("store_id");
String pw = request.getParameter("store_pw");
String email = request.getParameter("store_email");
String tel = request.getParameter("store_tel");

//id는 4~8글자만 허용
MemberBean mb = new MemberBean();  //객체 생성

boolean resultt = mb.lengthCheck(pw, 4, 12);

boolean result4 = mb.Em(email);
//boolean result5 = mb.Tel(tel);

if(resultt == true  && result4 == true /*&& result5 == true*/) {
    StoreDAO manager = StoreDAO.getInstance();
    manager.insertStore(store);
    response.sendRedirect("storeloginForm.jsp");
} else {
     if(resultt == false) {
        out.println("<script>alert('pw는 4~12글자입니다');history.go(-1);</script>");
    } else if(result4 == false) {
        out.println("<script>alert('이메일을 다시 작성해주세요');history.go(-1);</script>");
    } //else if(result5 == false) {
      //  out.println("<script>alert('전화번호는 하이픈 제외하고 작성해주세요');history.go(-1);</script>");
    //}
}
%>

