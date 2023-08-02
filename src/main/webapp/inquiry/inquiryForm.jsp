<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.InquiryDTO" %>
<!DOCTYPE html>
<html>
<head>
<title>문의</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	// 각 세션 불러옴
   String member = (String)session.getAttribute("memId"); 
   String admin = (String)session.getAttribute("admId"); 
   String store = (String)session.getAttribute("stoId");
   String level_num = (String)session.getAttribute("level_num");
%>
   <%if(member == null && admin == null && store == null){ %>
   <script>
      alert("회원만 문의 작성이 가능합니다.");
      history.go(-1);
   </script>
   <%} %>
<%      
   int num = 0, ref = 1, re_step = 0, re_level = 0;
      if(request.getParameter("num") != null){ // 글 번호가 있으면 content에서 uri로 넘겨준 값들 불러옴
         num = Integer.parseInt(request.getParameter("num"));
         ref = Integer.parseInt(request.getParameter("ref"));
         re_step = Integer.parseInt(request.getParameter("re_step"));
         re_level = Integer.parseInt(request.getParameter("re_level"));
      }
%>
<body>
<%if(admin == null && !(level_num.equals("3"))){ // 관리자가 아니면 문의하기로 출력%>
   <% if(level_num.equals("1")){%>
      <%@ include file="../header/listMember.jsp" %>
      <h2>문의 하기</h2>
   <%}else if(level_num.equals("2")){%>
      <%@ include file="../header/listStore.jsp" %>
      <h2>문의 하기</h2>
   <%} %>
<%}else{ %>
<%@ include file="../header/listAdmin.jsp" %>
<h2>답변 하기</h2>
<%} %>
<br>
<script src="/pt1/resources/js/inquiry.js"></script>
<%if(level_num.equals("3")){ // 관리자는 문의유형 빼고 유효성 검사 %>
<form method="post" name="writeform" action="inquiryPro.jsp" onsubmit="return chkinquiry2()">
<%}else{ %>
<form method="post" name="writeform" action="inquiryPro.jsp" onsubmit="return chkinquiry()">
<%} %>
<input type="hidden" name="num" value="<%=num%>" />
<input type="hidden" name="ref" value="<%=ref%>" />
<input type="hidden" name="re_step" value="<%=re_step%>" />
<input type="hidden" name="re_level" value="<%=re_level%>" />

<table width="500" border="1" cellspacing="0">
   <tr>
    <td align="right" colspan="2" >
       <a href="inquiryList.jsp"> 글목록</a> 
   </td>
   </tr> 
   <%if(admin == null && !(level_num.equals("3"))){ // 관리자가 아니면 문의유형도 작성! %>
   <tr>
          <td  width="170" align="center">문의유형</td>
       <td  width="330">
          <select name="category">
             <option value="">선택해주세요</option>
             <option value="회원가입">회원가입/로그인</option>
             <option value="정보수정">정보수정/탈퇴</option>
             <option value="이용문의">이용문의/결제수단</option>
             <option value="기타">기타</option>
          </select>
       </td>
   </tr>
   <%}%>
  <tr>
    <td  width="170" align="center" >제 목</td>
    <td  width="330">
    <%if(request.getParameter("num")==null){ // 글 번호가 없으면 일반 글 작성, 있으면 답변 글 %>
       <input type="text" size="40" maxlength="50" name="subject" /></td>
   <%}else{%> 
      <input type="text" size="40" maxlength="50" name="subject" value="[답변]" />
   <%}%>
  </tr>
  <tr> 
    <td  width="170" align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="13" cols="40"></textarea> </td>
  </tr>
<tr>      
 <td colspan=2 align="center"> 
 <%if(admin == null && !(level_num.equals("3"))){ %>
  <input type="submit" value="글쓰기" />
  <input type="reset" value="다시작성" />
  <input type="button" value="목록보기" onclick="location='inquiryList.jsp'"/>
  <%}else{ %>
  <input type="submit" value="답변하기" />
  <input type="reset" value="다시작성" />
  <input type="button" value="목록보기" onclick="location='/pt1/inquiry/admininquiryList.jsp'"/>
  <%} %>  
</td></tr></table>    
</form>      
</body>
</html>      

    