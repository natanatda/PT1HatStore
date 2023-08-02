<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Admin_MessageDAO" %>
<%@ page import="pt1.BrandDTO" %>
<%@ page import="pt1.BrandDAO" %>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<jsp:useBean id="dto" class="pt1.Admin_MessageDTO"/>
<jsp:setProperty name="dto" property="*"/>
<jsp:useBean id="dto2" class="pt1.BrandDTO"/>
<jsp:setProperty name="dto2" property="*"/>

<%
//	dto.setRegDate(new Timestamp(System.currentTimeMillis()));
	String admid=(String)session.getAttribute("admId");      //관리자 session
//	String store_id=(String)session.getAttribute("stoId");   //점주 session
//	String memid=(String)session.getAttribute("memId");      //회원 session
	int brandno = Integer.parseInt(request.getParameter("brandno"));

	out.println(brandno);
	Admin_MessageDAO dao = Admin_MessageDAO.getInstance();
	BrandDAO dao2 = BrandDAO.getInstance();
	dao2.getBrand(brandno);
	String brandname = dto2.getBrand();
	int result=dao.insertAdminMs(dto,brandno,admid);
  	%>
<%	if(result==1){
%>
	<script>
		alert("등록성공!");
		location="/pt1/message/adminMsList.jsp";
	</script>
<% }else{%>
      <script>      
        alert("등록실패");
        history.go(-1);
     </script>
<%
    }
 %>  
