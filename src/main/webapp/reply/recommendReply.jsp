<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "pt1.MemberDAO"%>
<%@ page import = "pt1.LikeyDAO"%>
<%@ page import = "pt1.ReplyDAO"%>
<%@ page import = "java.io.PrintWriter"%>
<!DOCTYPE html>
<html>

<body>
	<%!
public static String getClientIP(HttpServletRequest request) {
    String ip = request.getHeader("X-FORWARDED-FOR"); 
    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("Proxy-Client-IP");
    }
    if (ip == null || ip.length() == 0) {
        ip = request.getHeader("WL-Proxy-Client-IP");
    }
    if (ip == null || ip.length() == 0) {
        ip = request.getRemoteAddr() ;
    }
    return ip;
}
%>
<%try{
        // 로그인한 유저의 아이디를 가져오기(세션 확인)
	String memid=(String)session.getAttribute("memId"); 
	if(memid == null) {
		out.println("<script>");
		out.println("alert('로그인을 해주세요.');");
		out.println("location.href = '/pt1/member/loginForm.jsp'");
		out.println("</script>");
		return;
	}
        // 이전의 파라매터로 보낸 게시판 글번호 가져오기
	
	int replyNum = Integer.parseInt(request.getParameter("replyNum"));
	int productNum = Integer.parseInt(request.getParameter("pnum"));
	ReplyDAO replyDAO = ReplyDAO.getInstance();
	LikeyDAO likeyDAO = LikeyDAO.getInstance();
	
	//int result = likeyDAO.like(memid,replyNum,productNum);	//추천
	int count = likeyDAO.checkLike(memid,replyNum,productNum);	//이미 추천했는지 체크
	
	if(count > 0){	//추천 눌렀는지 검사 - 이미 누른경우
		int result = replyDAO.unlike(replyNum); //이미 추천이 있는 경우 -1 감소 연산후 1반환
		int x = likeyDAO.deleteLike(replyNum, memid); //db에서 삭제 후 1반환
		if(result==1 && x==1){
			out.println("<script>");
			out.println("alert('추천이 취소되었습니다.');");
			out.println("location='/pt1/productDetail/pdMainForm.jsp?pnum="+productNum+"'");
			out.println("</script>");
		}
	}else if(count == 0){//추천안눌렸을 떄
			int result = replyDAO.like(replyNum);	//추천수 올라감
		if (result == 1) {	// 정상적으로 1번 데이터가 들어가고 추천수 올라가면
			int likeInsert = likeyDAO.like(memid, replyNum, productNum);
			out.println("<script>");
			out.println("alert('추천이 완료되었습니다.');");
			out.println("location='/pt1/productDetail/pdMainForm.jsp?pnum="+productNum+"'");
			out.println("</script>");
			return;
		} else{
			out.println("<script>");
			out.println("alert('데이터베이스 오류가 발생했습니다.');");
			out.println("history.back();");
			out.println("</script>");
			return;
		}
	} 
		
}catch(Exception e){}
%>
</body>
</html>