<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.ReplyDAO" %>
<%@ page import="pt1.ReplyDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<% request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>

<%!
	// 페이지당 게시글 수
	int pageSize = 10;
	// 날짜 형식 지정을 위한 SimpleDateFormat 객체 생성
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
	// 세션에서 관리자, 회원, 점주 아이디 가져오기
	String admin = (String)session.getAttribute("admId");
	String member = (String)session.getAttribute("memId");
	String store = (String)session.getAttribute("stoId");
	// 페이지 번호와 상품 번호 가져오기
	String pageNum = request.getParameter("pageNum");
	int productNum = Integer.parseInt(request.getParameter("pnum"));
	if(pageNum == null){
		pageNum = "1";
	}

	// 현재 페이지 번호, 시작 행, 마지막 행, 게시글 수, 게시글 번호 초기화
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;

   	// 게시글 목록과 게시글 수를 DB에서 가져오기 위한 DAO 객체 생성
   	List replyList = null;
   	ReplyDAO dao = ReplyDAO.getInstance();
   	count = dao.getReplyCount(productNum);

   	// 게시글이 하나 이상일 경우 게시글 목록 가져오기
   	if(count > 0){
   		replyList = dao.getReplys(productNum,startRow, endRow);
   	}
   	// 게시글 번호 계산
   	number = count - (currentPage-1) * pageSize;
%>

<html>
<head>
<title>리뷰 게시판</title>
</head>
<body>
<b>리뷰 목록</b>
<table width="700">
<tr>
    <td >
    <%if(admin == null && member == null && store == null){ %>
    <%-- 세션에 아이디가 없는 경우 관리자, 회원, 점주 로그인 페이지로 이동할 수 있는 링크 표시 --%>
    <a href="/pt1/admin/adminloginForm.jsp">관리자로그인</a>
    <a href="/pt1/store/storeloginForm.jsp">점주로그인</a>
    <a href="/pt1/member/loginForm.jsp">회원로그인</a>
    <%}%>
    <%-- 메인 페이지로 이동하는 링크 표시 --%>
    <a href="/pt1/main/main.jsp">메인</a>
