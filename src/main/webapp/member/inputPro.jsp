<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.MemberDAO" %>
<%@ page import="test.web.model.MemberBean" %>
<%@ page import= "java.util.ArrayList" %>
<%request.setCharacterEncoding("utf-8"); %>
    
<jsp:useBean id="member" class="pt1.MemberDTO">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>

	
	                      	 

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

String id = request.getParameter("id"); 
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String email = request.getParameter("email");
String tel = request.getParameter("tel");
String address = request.getParameter("address");
MemberDAO dao = MemberDAO.getInstance();
dao.insertMember(member);

%>
	<script> 
	  alert("축하합니다! 회원가입 되었습니다.");
	  location="/pt1/member/loginForm.jsp";
	</script>
<%--
//id는 4~8글자만 허용
MemberBean mb = new MemberBean();  //객체 생성
boolean result = mb.lengthCheck(id, 4, 8);
boolean resultt = mb.lengthCheck(pw, 4, 12);


//첫글자 숫자 불가능
boolean result2 = mb.firstChar(id);

//특수문자 사용 불가능
boolean result3 = mb.speStr(id);
boolean result4 = mb.Em(email);
boolean result5 = mb.Tel(tel);

if(result == true && resultt == true && result2 == true && result3 == true && result4 == true && result5 == true) {
    MemberDAO manager = MemberDAO.getInstance();
    manager.insertMember(member);
    response.sendRedirect("loginForm.jsp");
} else {
    if(result == false) {
        out.println("<script>alert('id는 4~8글자입니다');history.go(-1);</script>");
    } else if(result2 == false) {
        out.println("<script>alert('id 첫글자는 숫자가 불가능합니다');history.go(-1);</script>");
    } else if(result3 == false) {
        out.println("<script>alert('id는 특수문자 사용이 불가합니다');history.go(-1);</script>");
    } else if(resultt == false) {
        out.println("<script>alert('pw는 4~12글자입니다');history.go(-1);</script>");
    } else if(result4 == false) {
        out.println("<script>alert('이메일은 @를 포함하여 전체 작성해주세요');history.go(-1);</script>");
    } else if(result5 == false) {
        out.println("<script>alert('전화번호는 하이픈 제외하고 작성해주세요');history.go(-1);</script>");
    }
}

%>
 --%>

