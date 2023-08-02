<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.NoticeDAO" %>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<jsp:useBean id="dto" scope="page" class="pt1.NoticeDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%
	dto.setReg(new Timestamp(System.currentTimeMillis()));
	String admid=(String)session.getAttribute("admId");      //관리자 session
	
	dto.setWriter(admid);
	NoticeDAO dao = NoticeDAO.getInstance();
	dao.insertNotice(dto);
	
	response.sendRedirect("noticeMain.jsp");
%>
