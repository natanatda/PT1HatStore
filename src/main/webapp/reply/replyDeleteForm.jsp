<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  int replyNum = Integer.parseInt(request.getParameter("replyNum"));
  String pageNum = request.getParameter("pageNum");
  String productNum = request.getParameter("pnum");
%>
<html>
<head>
	<title>리뷰</title>
	<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	<style>
		@font-face {
			font-family: 'TheJamsil5Bold';
			src:
				url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/TheJamsil5Bold.woff2')
				format('woff2');
			font-weight: normal;
			font-style: normal;
		}
		
		.reviewFormBt input {
			font-family: 'TheJamsil5Bold', sans-serif;
			width: 100px;
			height: 50px;
			border: 1px solid #919191;
			font-size: 1em;
			font-weight: bold;
		}
		
		.reviewFormBt input[type="submit"] {
			font-family: 'TheJamsil5Bold', sans-serif;
			background-color: #2196F3;
			border: none;
			color: #fff;
			font-size: 1em;
			font-weight: bold;
		}
		</style>
</head>
<%
String admid = (String) session.getAttribute("admId"); //관리자 session
String store_id = (String) session.getAttribute("stoId"); //점주 session
String memid = (String) session.getAttribute("memId"); //회원 session
String level_num = (String) session.getAttribute("level_num"); //level세션(관리자/점주/회원 구분 위함)
if ((memid == null && admid == null)) {
%>
			alert("로그인후 삭제 가능");
		<script>
			location="/pt1/member/loginForm.jsp";
		</script>
<%} %>
	<body>
		<br>
		<%
			if(admid != null && level_num.equals("3")){	//관리자일때
		%>
		<h2>글삭제</h2>
			<form class="reviewFormBt" method="post" name="replyDeleteForm" action="/pt1/reply/replyDeletePro2.jsp?pageNum=<%=pageNum%>&pnum=<%=productNum%>">
				<table border="1" cellpadding="0" width="360">
					<tr height="30">
						<td >
							<input type="hidden" name="replyNum" value="<%=replyNum%>">
							<input type="submit" value="글삭제" >
							<input type="button" value="목록보기" onclick="document.location.href='/pt1/admin/adReviewList.jsp'">     
							<input type="button" value="취소" onclick="document.location.href='/pt1/productDetail/pdMainForm.jsp?pageNum=<%=pageNum%>&pnum=<%=productNum%>'">
						</td>
					</tr>
				</table>
			</form>
			<%}else if( memid != null && level_num.equals("1")){ //일반 작성자일 때%>
		<h2>글삭제</h2>
			<form class="reviewFormBt" method="post" name="replyDeleteForm" action="/pt1/reply/replyDeletePro.jsp?pageNum=<%=pageNum%>&pnum=<%=productNum%>">
				<table border="1" cellpadding="0" width="360">
					<tr height="30">
						<td >
							<input type="hidden" name="replyNum" value="<%=replyNum%>">
							<input type="submit" value="글삭제" >
							<input type="button" value="취소" onclick="document.location.href='/pt1/productDetail/pdMainForm.jsp?pageNum=<%=pageNum%>&pnum=<%=productNum%>'">     
						</td>
					</tr>
				</table>
			</form>
			<%} %>
	</body>
</html>


