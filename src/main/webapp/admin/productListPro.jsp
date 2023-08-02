<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.ProductListDAO" %>
<%@ page import="pt1.ProductListDTO" %>


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
	
	// 비활성화할 상품의 pnum 값을 받아옴
	Integer pnum = Integer.parseInt(request.getParameter("pnum"));
	Integer active = Integer.parseInt(request.getParameter("active"));
	String pageNum = request.getParameter("pageNum");
	
	// 비활성화를 위해 DB의 active 컬럼 조정
	ProductListDAO dao = ProductListDAO.getInstance();
	int result = dao.activePro(pnum, active);
	
	// 결과에 따라 메시지 출력
	if (result == 1) {
		%>
	    <script>alert('수정 되었습니다.')</script>;
	    <meta http-equiv="Refresh" content="0;url=productList.jsp?pageNum=<%=pageNum%>" >
<%	} else { %>
	    <script>
	    	alert('수정 실패했습니다.')
	    	history.go(-1);
    	</script>
<%	}%>

<%=pnum%>
<%=pageNum%>