<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">

</head>

<%
 try{
   if(session.getAttribute("admId")==null){    //세션 값 꺼냈을때 그게 널 = 로그인 안된 거 %>
   <%@ include file="../header/listGuest.jsp" %>
   		 로그인을 안하셨는걸요? 로그인하러 가요!<input type="button" value="로그인하기" onclick="javascript:window.location='/pt1/admin/adminloginForm.jsp'">
  <%}else{ %>
 <%@ include file="../header/listAdmin.jsp" %>  		 
<h1> 관리자정보페이지</h1>
<body onLoad="focusIt();" bgcolor="white">

       <table border="1" >
         <tr><th>
             <%=session.getAttribute("admId")%>님이 방문하셨습니다.
           </th></tr>
           <tr>
           <td>
             <form  method="post" action="logoutForm.jsp">  
             	<input type="button" value="관리자정보변경" onclick="javascript:window.location='adminmodifyForm.jsp'"></td>
             </form>
         </td>
        </tr>

     </table>
     <br>
<%}
 }catch(NullPointerException e){}
 %>
 </body>
</html>