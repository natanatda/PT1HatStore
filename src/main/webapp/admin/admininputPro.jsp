<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.AdminDAO" %>
<%@ page import="test.web.model.MemberBean" %>
<%request.setCharacterEncoding("UTF-8"); %>
    
<jsp:useBean id="admin" class="pt1.AdminDTO">
    <jsp:setProperty name="admin" property="*" />
</jsp:useBean>

<%
String id = request.getParameter("admin_id");
String pw = request.getParameter("admin_pw");
MemberBean mb = new MemberBean();

boolean result6 = mb.firstString(id);
boolean resultt = mb.lengthCheck(pw, 4, 12);


if(result6 == true && resultt == true ) {
	 AdminDAO manager = AdminDAO.getInstance();
	    manager.insertAdmin(admin);

	    response.sendRedirect("adminloginForm.jsp");
} else {
    if(result6 == false) {
        out.println("<script>alert('관리자 id는 admin을 포함해야합니다');history.go(-1);</script>");
    } else if(resultt == false) {
        out.println("<script>alert('pw는 4~12 글자입니다');history.go(-1);</script>");
    } 
}
   
%>
    



