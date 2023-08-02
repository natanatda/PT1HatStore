<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "pt1.EventDAO" %>
<%@ page import = "java.sql.Timestamp" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<%
	int num = Integer.parseInt(request.getParameter("num"));	//num 파라미터 값 불러서 int로 변환
	String pageNum = request.getParameter("pageNum");
	String writer = request.getParameter("writer");
	
	EventDAO dao= EventDAO.getInstance();		//dao 객체 생성
	int check = dao.deleteEvent(num, writer);
	
	if(check==1){	//관리자면 게시글 삭제후 eventMain으로 이동
%>
	  <meta http-equiv="Refresh" content="0;url=eventMain.jsp?pageNum=<%=pageNum%>" >
<% }else{%>
      <script language="JavaScript">      
         alert("관리자가 아닙니다");
         history.go(-1);
      </script>s
<%
    }
 %>