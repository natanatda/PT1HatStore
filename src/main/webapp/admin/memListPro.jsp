<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.MemListDAO" %>
<%@ page import="pt1.MemListDTO" %>

<%
	//관리자 여부 체크
	String admId = (String)session.getAttribute("admId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("3"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}%>

<%
	request.setCharacterEncoding("utf-8");

	// 비활성화할 회원의 ID 값을 받아옴
	String memId = request.getParameter("id");
	Integer active = Integer.parseInt(request.getParameter("active"));
	String pageNum = request.getParameter("pageNum");

	// 비활성화를 위해 DB의 active 컬럼 조정
	MemListDAO dao = MemListDAO.getInstance();
	int result = dao.activeMem(memId, active);
	
	// 결과에 따라 메시지 출력
	if (result == 1) {
		%>
	    <script>alert('수정 되었습니다.')</script>;
	    <meta http-equiv="Refresh" content="0;url=memList.jsp?pageNum=<%=pageNum%>" >
<%	} else { %>
	    <script>
	    	alert('수정 실패했습니다.')
	    	history.go(-1);
    	</script>
<%	}
	//회원 목록 페이지로 이동
	//response.sendRedirect("/pt1/admin/memList.jsp");
%>