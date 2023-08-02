<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.BrandDAO" %>
<%@ page import="pt1.BrandDTO" %>

<%
	//관리자 여부 체크
	String admId = (String)session.getAttribute("admId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("3"))){%>
<script>
	alert("잘못된 경로입니다.");
	location = "/pt1/main/main.jsp";
</script>
<%}
	
	request.setCharacterEncoding("utf-8");

	// 입점 수락할 브랜드의 brandNo값을 받아옴
	String brandNo = request.getParameter("brandNo");
	String pageNum = request.getParameter("pageNum");

	// 입점수락을 위해 DB의 active 컬럼 조정
	BrandDAO dao = BrandDAO.getInstance();
	int result = dao.permitBrand(Integer.parseInt(brandNo));
	
	// 결과에 따라 메시지 출력
	if (result == 1) {
		%>
	    <script>alert('입점 수락 되었습니다.');</script>
	    <meta http-equiv="Refresh" content="0;url=brandList.jsp?pageNum=<%=pageNum%>" >
<%	} else { %>
	    <script>
	    	alert('입점 거부 되었습니다.');
	    	history.go(-1);
    	</script>
<%	}%>
<script>
alert(brandNo);
</script>