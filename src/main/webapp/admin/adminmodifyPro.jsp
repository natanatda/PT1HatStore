<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "pt1.AdminDAO" %>

<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="admin" class="pt1.AdminDTO">
    <jsp:setProperty name="admin" property="*" />
</jsp:useBean>
 
<%
    String id = (String)session.getAttribute("admId");  //수정폼에서 아이디는 안넘어와서 추가로 집어넣어줌
	admin.setId(id);

	AdminDAO manager = AdminDAO.getInstance();
    manager.updateAdmin(admin);

	//관리자 여부 체크
	if(id==null){ %>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<% }%>
<!doctype html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<body>
<%@ include file="../header/listAdmin.jsp"%>
<table border="1" >
  <tr> 
    <td>
	  <font ><b>관리자 정보가 수정되었습니다.</b></font></td>
  </tr>
  <tr>
    <td> 
      <p>입력하신 내용대로 수정이 완료되었습니다.</p>
    </td>
  </tr>
  <tr>
    <td > 
      <form>
	    <input type="button" value="메인으로" onclick="window.location='/pt1/main/main.jsp'">
      </form>
      5초후에 메인으로 이동합니다.<meta http-equiv="Refresh" content="5;url=/pt1/main/main.jsp" >
    </td>
  </tr>
</table>
</body>
</html>
