<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="pt1.BrandDAO"  %>
<%@ page import="pt1.BrandDTO"  %>
<html>

<%request.setCharacterEncoding("utf-8"); %>
<%
String brandName = request.getParameter("brandName");
String level_num = (String) session.getAttribute("level_num"); //level세션(관리자/점주/회원 구분 위함)

int count=0;
BrandDAO brandcountdao = BrandDAO.getInstance();
count=brandcountdao.getBrandCount();
%>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/pt1/resources/css/category.css">
</head>
<body>

<div>
	<%if(level_num!=null){
		// level_num이 3일 경우 (레벨 3 =>관리자)
		if(level_num.equals("3")){%>
			<%@ include file="../header/listAdmin.jsp" %>
		<%
		//level_num이 2일 경우 (레벨 2 =>점주)
		} else if(level_num.equals("2")){ %>
			<%@ include file="../header/listStore.jsp" %>
		<%
		//level_num이 1일 경우 (레벨 1 =>회원)
		} else if(level_num.equals("1")){%>
            <%@ include file="../header/listMember.jsp" %>
		<%}
	}else{%>
		<%@ include file="../header/listGuest.jsp" %>
	<%} %>
</div>
	
<%
	List brandList = null;
	BrandDAO dao = BrandDAO.getInstance();
	brandList=dao.brandList();
%>
<h3> 브랜드 (<%=count %>)</h3>
<div class="brandList">
<%
	for(int i =0 ; i < brandList.size() ; i++){
		BrandDTO dto = (BrandDTO)brandList.get(i);%>

<%-- 클릭하면 해당 페이지에 파라미터 주고 hidden 값 보냄(해당 파라미터에 맞는 브랜드 상품 가져오기 위함 --%>
	<form action="/pt1/brand/brandMain.jsp?brandName=<%=dto.getBrand() %>" method="post">
		<input type="hidden" value="<%=dto.getBrand() %>" name="brand" maxlength="12">
		<input type="submit" value="<%=dto.getBrand() %>" />
	</form>
<%} %>
</div>

<% if(brandName==null){ %>
	<jsp:include page="../product/bestReadProduct.jsp" flush="false" />
<%} %>
<%
	for(int i =0 ; i < brandList.size() ; i++){
		BrandDTO dto = (BrandDTO)brandList.get(i);
	//form 클릭해서 받은 brandName 파라미터가 없는 경우 or brandName 파라미터가 nike인 경우 jsp파일 include
	if(brandName!=null&&brandName.equals(dto.getBrand())){
%>
<%-- 처음 상품 페이지 들어갔을 때 존재해야될 상품 무엇을/어떻게 출력해야될지 고민해봐야될 듯 --%>
    	<%-- jsp 파일 include 형식으로 변경 --%>
    	<jsp:include page="brandMainPro.jsp" flush="false" />
	</body>
<%}
}%>
</html>