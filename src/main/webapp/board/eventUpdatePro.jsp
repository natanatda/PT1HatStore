<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "pt1.EventDAO"%>
<%@ page import = "java.sql.Timestamp"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<jsp:useBean id="dto" class="pt1.EventDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	String admid=(String)session.getAttribute("admId");      //관리자 session
	
	dto.setWriter(admid);
	EventDAO dao = EventDAO.getInstance();
	dao.updateEvent(dto,num);
	%>
	 <meta http-equiv="Refresh" content="0;url=eventMain.jsp?pageNum=<%=pageNum%>" >
	
