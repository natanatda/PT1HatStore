<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Payment_HistoryDAO"  %>
<%@ page import="pt1.Payment_HistoryDTO"  %>
<%@ page import="java.util.*" %>
<!DOCTYPE html> 

<html>
	<head>
	<meta charset="UTF-8">
	<title>리뷰</title>
	<script src="/pt1/resources/js/reply.js"></script>
	<style>
	textarea {
		resize: none;
	}
	
	#resetReview{
		font-family: 'TheJamsil5Bold', sans-serif;
		width: 100px;
		height: 50px;
		border: 1px solid #919191;
		font-size: 1em;
		font-weight: bold;
	}
	
	#submitReview {
		font-family: 'TheJamsil5Bold', sans-serif;
		background-color: #2196F3;
		width: 100px;
		height: 50px;
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
String memberId = (String) session.getAttribute("memId"); //회원 session
String level_num = (String) session.getAttribute("level_num"); //level세션(관리자/점주/회원 구분 위함)

//String user_id=(String)session.getAttribute("user_id");   
String product_id = (String) session.getAttribute("product_id");

String productNum = request.getParameter("pnum");
String pageNum = request.getParameter("pageNum");
int productNum2 = Integer.parseInt(productNum); //int타입의 상품 번호(payment테이블의 상품번호와 비교하기 위해 바꿔줌)

int replyNum = 0;
%>

<%
		if(request.getParameter("replyNum")!=null){
			replyNum=Integer.parseInt(request.getParameter("replyNum"));
		}
		Payment_HistoryDAO dao = Payment_HistoryDAO.getInstance();
		
		Payment_HistoryDTO dto = dao.checkPayment(productNum, memberId);
%>

<%		
		if(dto != null){
		if( memberId.equals(dto.getUser_id()) ){		// 지금 로그인 한사람이 상품구매자이고 
			if(dto.getProduct_id()==productNum2){		// 이 상품이 구매한 상품일때 리뷰쓰기
%>
<body>
	<br>
	<h2>리뷰쓰기</h2>
	<br>
	<form method="post" name="replyinput" action="/pt1/reply/replyWritePro.jsp" onsubmit="return checkIt()" enctype="multipart/form-data">
		<input type="hidden" name="replyNum" value="<%=replyNum%>">
		<input type="hidden" name="memberId" value="<%=memberId%>">
		<input type="hidden" name="productNum" value="<%=productNum%>">
		<table width="400" border="1">
			
			<!-- 
			<tr>
				<td  width="70" >제목</td>
				<td  width="330">
					<input type="text" size="40" maxlength="50" name="subject"></td>
			</tr>
			 -->

			<tr>
				<td>평점 <select name="rating">
						<option value="5">5점</option>
						<option value="4">4점</option>
						<option value="3">3점</option>
						<option value="2">2점</option>
						<option value="1">1점</option>
				</select></td>
				<td><textarea name="content" placeholder="상품 리뷰를 작성해주세요"
						rows="4" cols="70"></textarea></td>
				<td>사진 첨부 &nbsp; <input type="file" name="save"></td>
				<td colspan="2" > 
					<input id="submitReview" type="submit" value="글쓰기" >
					<input id="resetReview" type="reset" value="다시작성">
				</td>
			</tr>
		</table>
<%			}	
		}
	}
%>
	</form>
</body>
</html>