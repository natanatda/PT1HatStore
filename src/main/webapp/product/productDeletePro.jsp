<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.ProductDAO" %>
<%@ page import="pt1.ProductDTO" %>


<%
	//점주 여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))||stoId==null){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}%>
<%
	request.setCharacterEncoding("utf-8");

	// 삭제할 상품의 pnum 값을 받아옴
	Integer pnum = Integer.parseInt(request.getParameter("pnum"));
	String pageNum = request.getParameter("pageNum");

	// 상품 삭제 조정
	ProductDAO dao = ProductDAO.getInstance();
	int result = dao.deleteProduct(pnum);
	
	// 결과에 따라 메시지 출력
	if (result == 1) {
		%>
	    <script>alert('삭제 되었습니다.')</script>;
	    <meta http-equiv="Refresh" content="0;url=/pt1/store/productList.jsp?pageNum=<%=pageNum%>" >
<%	} else { %>
	    <script>
	    	alert('삭제 실패했습니다.')
	    	history.go(-1);
    	</script>
<%	}
%>