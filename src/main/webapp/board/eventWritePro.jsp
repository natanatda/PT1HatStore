<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.EventDAO" %>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<jsp:useBean id="dto" scope="page" class="pt1.EventDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%
	dto.setReg(new Timestamp(System.currentTimeMillis()));
	String admid=(String)session.getAttribute("admId");      //관리자 session
	
	dto.setWriter(admid);
	
	EventDAO dao = EventDAO.getInstance();
	dao.insertEvent(dto);
	
	response.sendRedirect("eventMain.jsp");
%>
