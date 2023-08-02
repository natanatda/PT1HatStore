<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%
	String classificationName = request.getParameter("classificationName");
	String level_num=(String)session.getAttribute("level_num");   //level세션(관리자/점주/회원 구분 위함)  
    String admid=(String)session.getAttribute("admId");      //관리자 session
    String store_id=(String)session.getAttribute("stoId");   //점주 session
    String memid=(String)session.getAttribute("memId");      //회원 session
%>
<head>
	<meta charset="UTF-8">
	<!-- <link rel="stylesheet" type="text/css" href="/pt1/resources/css/list.css"> 
	<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	-->
</head>

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
<!-- 
<%-- 클릭하면 해당 페이지에 파라미터 주고 hidden 값 보냄(해당 파라미터에 맞는 카테고리 상품 가져오기 위함 --%>
<form action="/pt1/classification/classification.jsp?classificationName=beanie" method="post">
	<input type="hidden" value="beanie" name="category" maxlength="12">
	<input type="submit" value="beanie(hidden타입의 value값)" />
</form>
<%-- 클릭하면 해당 페이지에 파라미터 주고 hidden 값 보냄(해당 파라미터에 맞는 카테고리 상품 가져오기 위함 --%>
<form action="/pt1/classification/classification.jsp?classificationName=beret" method="post">
	<input type="hidden" value="beret" name="category" maxlength="12">
	<input type="submit" value="beret(hidden타입의 value값)" />
</form>
<%-- 클릭하면 해당 페이지에 파라미터 주고 hidden 값 보냄(해당 파라미터에 맞는 카테고리 상품 가져오기 위함 --%>
<form action="/pt1/classification/classification.jsp?classificationName=cap" method="post">
	<input type="hidden" value="cap" name="category" maxlength="12">
	<input type="submit" value="cap(hidden타입의 value값)" />
</form>
<%-- 클릭하면 해당 페이지에 파라미터 주고 hidden 값 보냄(해당 파라미터에 맞는 카테고리 상품 가져오기 위함 --%>
<form action="/pt1/classification/classification.jsp?classificationName=hat" method="post">
	<input type="hidden" value="hat" name="category" maxlength="12">
	<input type="submit" value="hat(hidden타입의 value값)" />
</form>
<%-- 클릭하면 해당 페이지에 파라미터 주고 hidden 값 보냄(해당 파라미터에 맞는 카테고리 상품 가져오기 위함 --%>
<form action="/pt1/classification/classification.jsp?classificationName=snapback" method="post">
	<input type="hidden" value="snapback" name="category" maxlength="12">
	<input type="submit" value="snapback(hidden타입의 value값)" />
</form>
<%-- 클릭하면 해당 페이지에 파라미터 주고 hidden 값 보냄(해당 파라미터에 맞는 카테고리 상품 가져오기 위함 --%>
<form action="/pt1/classification/classification.jsp?classificationName=etc" method="post">
	<input type="hidden" value="etc" name="category" maxlength="12">
	<input type="submit" value="etc(hidden타입의 value값)" />
</form>
 -->
<%
	if(classificationName==null){
%>
	<jsp:include page="../product/bestReadProduct.jsp" flush="false" />
<%
	//if문에 각각의 파라미터에 해당하는 카테고리 상품 목록 불러옴
	}else if(classificationName.equals("beanie")){
%>
<body>
	<%-- jsp 파일 include 형식으로 변경 --%>
    <jsp:include page="classificationPro.jsp" flush="false" />
<%} else if(classificationName.equals("beret")){%>
    <%-- jsp 파일 include 형식으로 변경 --%>
    <jsp:include page="classificationPro.jsp" flush="false" />
<%} else if(classificationName.equals("cap")){%>
    	<%-- jsp 파일 include 형식으로 변경 --%>
    	<jsp:include page="classificationPro.jsp" flush="false" />
<%} else if(classificationName.equals("hat")){%>
    	<%-- jsp 파일 include 형식으로 변경 --%>
    	<jsp:include page="classificationPro.jsp" flush="false" />
<%} else if(classificationName.equals("snapback")){%>
    	<%-- jsp 파일 include 형식으로 변경 --%>
    	<jsp:include page="classificationPro.jsp" flush="false" />
<%} else if(classificationName.equals("etc")){%>
    	<%-- jsp 파일 include 형식으로 변경 --%>
    	<jsp:include page="classificationPro.jsp" flush="false" />
<%}%>
</body>