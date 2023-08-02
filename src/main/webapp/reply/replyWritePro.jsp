<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.ReplyDAO" %>
<%@ page import="pt1.ReplyDTO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");
	//D:\p\pt1\src\main\webapp\reply\rimg
	//String dir = "D://p//pt1//src//main//webapp//reply//rimg";//파일 저장 경로
	String dir = request.getRealPath("uploadrimg");//파일 저장 경로
	
	String pageNum = request.getParameter("pageNum");
	
	int max = 1024*1024*10; //10메가
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, dir, max, "UTF-8", dp);

	String sysName = mr.getFilesystemName("save");
	
	Enumeration enu = mr.getFileNames();
	if(enu.hasMoreElements()){
		String key = (String)enu.nextElement();
		sysName = mr.getFilesystemName(key); //업로드한 파일의 이름을 찾음
	}
	
	ReplyDTO dto = new ReplyDTO();
  	String replyNum = mr.getParameter("replyNum");
  	String productNum = mr.getParameter("productNum");
  	String memberId = mr.getParameter("memberId");
  	/*String regDate = mr.getParameter("regDate");*/
  	String content=mr.getParameter("content");
  	String subject=mr.getParameter("subject");
  	String rating=mr.getParameter("rating");

  	dto.setReplyNum(Integer.parseInt(replyNum));
  	dto.setProductNum(Integer.parseInt(productNum));
  	dto.setMemberId(memberId);
  	dto.setRegDate(new Timestamp(System.currentTimeMillis()));
  	dto.setSubject(subject);
  	dto.setContent(content);
  	dto.setRating(Integer.parseInt(rating));
  	dto.setRimg(sysName);
  	
  	ReplyDAO dao = ReplyDAO.getInstance();
  	
  	int result=dao.insertReply(dto);
  	%>
<%	if(result==1){
%>
	<script>
		alert("등록성공!");
		location="/pt1/productDetail/pdMainForm.jsp?pnum=<%=productNum %>";
	</script>
<% }else{%>
      <script>      
        alert("등록실패");
        history.go(-1);
     </script>
<%
    }
 %>  
