<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "pt1.ReplyDAO" %>
<%@ page import = "java.sql.Timestamp" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 리뷰삭제</title>
</head>
<body>
<%
	int replyNum = Integer.parseInt(request.getParameter("replyNum"));	//replyNum 파라미터 값 불러서 int로 변환
	String pageNum = request.getParameter("pageNum");
	String productNum = request.getParameter("pnum");
	String memberId = request.getParameter("memberId");
	String memId = (String)session.getAttribute("memId");
	String admid=(String)session.getAttribute("admId");      //관리자 session
	String level_num=(String)session.getAttribute("level_num");   //level세션(관리자/점주/회원 구분 위함)
	ReplyDAO dao= ReplyDAO.getInstance();		//dao 객체 생성
	
	int check = dao.deleteReply(replyNum, memId);
	int check2 = dao.admDeleteReply(admid,replyNum);
	if(check==1 || check2==1){	//관리자이면 게시글 삭제후 관리자 리뷰관리페이지로 이동
		%>
			   <script language="JavaScript">      
         alert("삭제되었습니다.");
         </script>
			 <meta http-equiv="Refresh" content="0;url=/pt1/admin/adReviewList.jsp" >
<%	}else{%>
      <script language="JavaScript">      
         alert("삭제할 권한이 없습니다.");
         history.go(-2);
      </script>
<%
    }
 %>
</body>
</html>