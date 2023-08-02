<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.ReplyDAO" %>
<%@ page import="pt1.ReplyDTO" %>
<%@ page import="pt1.BrandDTO" %>

<%
	request.setCharacterEncoding("utf-8");

	//점주 여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))||stoId==null){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}
	String brnadno = request.getParameter("selectBrand");%>
	<script>
	location.href="/pt1/store/reviewList.jsp?selectBrand=<%=brnadno%>";
	</script>
<%
	ReplyDAO dao = ReplyDAO.getInstance();
	
	
%>
<%=brnadno%>