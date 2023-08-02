<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.StoreListDAO" %>
<%@ page import="pt1.StoreListDTO" %>


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
	
	// 삭제할 회원의 ID 값을 받아옴
	String stoId = request.getParameter("stoId");
	Integer active = Integer.parseInt(request.getParameter("active"));
	String pageNum = request.getParameter("pageNum");
	
	// 회원 정보를 DB에서 삭제
	StoreListDAO dao = StoreListDAO.getInstance();
	int result = dao.activePro(stoId, active);
	
	if (result == 1) {
		%>
	    <script>alert(stoId)</script>;
	    <script>alert('수정 되었습니다.')</script>;
	    <meta http-equiv="Refresh" content="0;url=storeList.jsp?pageNum=<%=pageNum%>" >
<%	} else { %>
	    <script>
	    	alert(stoId);
	    	alert('수정 실패했습니다.');
	    	history.go(-1);
    	</script>
<%	}%>
