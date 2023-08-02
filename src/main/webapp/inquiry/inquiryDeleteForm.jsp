<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int ref = Integer.parseInt(request.getParameter("ref"));
%>
<!DOCTYPE html>
 <h2>삭제하시겠습니까?</h2>
   <form action="inquiryDelete.jsp">
   		<input type="hidden" name="num" value="<%=num%>" />
   		<input type="hidden" name="ref" value="<%=ref%>" />
   		<input type="submit" value="삭제" /> 
   		<input type="button" value="취소" onclick="location='inquiryList.jsp'"/>   
   </form>
   
   