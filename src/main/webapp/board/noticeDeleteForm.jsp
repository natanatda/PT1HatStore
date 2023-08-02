<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
%>
<html>
	<head>
		<title>공지사항</title>
	</head>
<%	String admid=(String)session.getAttribute("admId");      //관리자 session
	if(admid==null){%>
		<script>
			alert("관리자만 삭제 가능");
			location="/pt1/admin/adminloginForm.jsp";
		</script>
<%} %>
	<body>
		<b>글삭제</b>
		<br>
			<form method="post" name="noticeDeleteForm" action="noticeDeletePro.jsp?pageNum=<%=pageNum%>">
				<table border="1" cellspacing="0" cellpadding="0" width="360">
					<tr height="30">
						<td align="center">
							<input type="hidden" name="num" value="<%=num%>">
							<input type="submit" value="글삭제" >
							<input type="button" value="글목록" onclick="document.location.href='noticeMain.jsp?pageNum=<%=pageNum%>'">     
						</td>
					</tr>
				</table>
			</form>
	</body>
</html>


