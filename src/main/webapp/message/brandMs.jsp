<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.Admin_MessageDAO"  %>
<%@ page import="pt1.Admin_MessageDTO"  %>
<%@ page import="pt1.StoreMyPage"  %>
<%@ page import="java.util.List"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="java.util.Map"  %>
<%@ page import="java.text.SimpleDateFormat"  %>
<!DOCTYPE html>
<h1>brandMs.jsp</h1>
<%/*
   //관리자 여부 체크
   String stoId = (String)session.getAttribute("stoId");
   String level_num = (String)session.getAttribute("level_num");
   if(!(level_num.equals("2"))){ */
   String sort=request.getParameter("sort");
   %>
   <script>
      //alert("잘못된 경로입니다.");
      //location="/pt1/main/main.jsp";
   </script>
<%
	String stoId = (String)session.getAttribute("stoId");
	StoreMyPage smp = StoreMyPage.getInstance();
%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>메시지</title>
	</head>
	<body>
		<table width="700">
			<tr>
				<a href="/pt1/main/main.jsp">홈페이지</a>
			</tr>
		</table>
		<table>
			<tr>
				<a href="/pt1/store/storePage.jsp">이전</a>
			</tr>
		</table>
		<table>
		<%
			ArrayList<Map<String, Object>> brandList = smp.getBrandList(stoId);
			for(int i=0; i<brandList.size(); i++){ %>
				
				<form method="get" action="brandMsPro.jsp" >
					<td>
						<input type="submit" value="<%=brandList.get(i).get("brand")%>(<%=brandList.get(i).get("brandno")%>)">
						<input type="hidden" name="brandno" value="<%=brandList.get(i).get("brandno")%>">
					</td>
				</form>
		<%
			}
		%>
			</table>
	</body>
	
</html>

