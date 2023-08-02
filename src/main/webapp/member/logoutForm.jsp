<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
    
    <h1> 로그아웃</h1>
    
    <%
    	session.removeAttribute("sid"); 
    	session.invalidate();  
    	response.sendRedirect("/pt1/main/main.jsp");
    	
    %>
    