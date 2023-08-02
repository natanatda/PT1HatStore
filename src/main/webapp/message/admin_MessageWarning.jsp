<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Admin_MessageDAO"  %>
<%@ page import="pt1.BrandDTO"  %>
<%@ page import="pt1.BrandDAO"  %>
<%@ page import="pt1.Admin_MessageDTO"  %>
<%@ page import="java.text.SimpleDateFormat"  %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<%
  	String admid=(String)session.getAttribute("admId");   //관리자
    String store_id=(String)session.getAttribute("stoId");   //점주
    String memid=(String)session.getAttribute("memId");   //고객
	int brandno = Integer.parseInt(request.getParameter("brandno"));
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Admin_MessageDAO dao = Admin_MessageDAO.getInstance();
	Admin_MessageDTO dto = new Admin_MessageDTO();
	
	BrandDTO bdto= dao.getStore_id(brandno);
	String id = bdto.getStore_id();
	BrandDTO bdto2= dao.getBrandname(brandno);
	String brandname = bdto2.getBrand();
  	int result=dao.insertWarning(admid,id,brandno,brandname);
  	%>
<%	if(result==1){
%>
	<script>
		alert("경고성공!");
		 history.go(-1);
	</script>
<% }else{%>
      <script>      
        alert("경고실패");
        history.go(-1);
     </script>
<%
    }
 %>  