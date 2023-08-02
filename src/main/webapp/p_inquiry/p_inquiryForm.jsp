<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.P_inquiryDTO" %>
<!DOCTYPE html>
<html>
<head>
<script src="/pt1/resources/js/p_inquiry.js"></script>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
<title>상품 문의</title>
</head>
<style>
	input{
		font-family: 'TheJamsil5Bold', sans-serif;
		width: 100px;
		height: 50px;
		border: 1px solid #919191;
		font-size: 1em;
		font-weight: bold;
	}
	
	input[type="submit"] {
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
<%
	// 각 세션을 불러옴
	String member = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admId");
	String store = (String)session.getAttribute("stoId");
%>
	<%if(member == null && admin == null && store == null){ %>
	<script>
		alert("회원만 문의 작성이 가능합니다.");
		history.go(-1);
	</script>
	<%} %>
<%		
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	int num = 0, ref = 1, ref_step = 0;
	try{
		if(request.getParameter("num") != null){ // 글 번호가 있으면 ture
			num = Integer.parseInt(request.getParameter("num"));
			ref = Integer.parseInt(request.getParameter("ref"));
			ref_step = Integer.parseInt(request.getParameter("ref_step"));
		}
%>
<%@ include file="../header/listMember.jsp" %>
<h2>문의 하기</h2>
<br>
<form method="post" name="writeform" action="p_inquiryPro.jsp" onsubmit="return chkp_inquiry()">
<input type="hidden" name="pnum" value="<%=pnum%>" />
<input type="hidden" name="num" value="<%=num%>" />
<input type="hidden" name="ref" value="<%=ref%>" />
<input type="hidden" name="ref_step" value="<%=ref_step%>" />

<table border="1">
  <tr>
    <td  width="70" align="center" >제 목</td>
    <td  width="330">
    <%if(request.getParameter("num")==null){%>
       <select name="subject">
	       	<option value="">선택</option>
	       	<option value="배송문의">배송문의</option>
	       	<option value="재입고">재입고</option>
	       	<option value="제품상세">제품상세</option>
	       	<option value="사이즈">사이즈</option>
       </select>
       </td>
	<%}else{%> 
	   <input type="text" size="40" maxlength="50" name="subject" value="[답변]" />
	<%}%>
  </tr>
  <tr>
    <td>내 용</td>
    <td>
     <textarea name="content" rows="13" cols="40" placeholder="문의하실 내용을 자세하게 적어주세요."></textarea> </td>
  </tr>
<tr>      
 <td colspan=2 align="center"> 
 <%if(member != null){ %>
  <input type="submit" value="문의하기" />
  <%}else{ %>
  <input type="submit" value="답변하기" />
  <%} %>  
  <input type="reset" value="다시작성" />
  <input type="button" value="돌아가기" onclick='history.go(-1)'/>
</td></tr></table>    
 <%
  }catch(Exception e){}
%>     
</form>      
</body>
</html>