<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "pt1.P_inquiryDAO" %>
<%@ page import = "pt1.P_inquiryDTO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import ="java.util.List" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<title>상품문의</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	// 각 세션 불러옴
	String id = (String)session.getAttribute("memId");
	String admin = (String)session.getAttribute("admId");
	String store = (String)session.getAttribute("stoId");
	
	// 날짜 출력 형식 지정
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		P_inquiryDAO dao = P_inquiryDAO.getInstance();
		P_inquiryDTO dto = dao.getContent(num);
		
		int ref = dto.getRef();
		int ref_step = dto.getRef_step();
		
		if(ref_step == 0){ // 답글이 아닌 글은 작성자만 볼 수 있게함
			if(!(dto.getWriter().equals(id)) && admin == null && store == null){
%>	
			<script>
				alert("작성자만 볼 수 있는 글입니다.");
				history.go(-1);
			</script>
		<%} 
	}%>
		
<body>
<%@ include file="../header/listStore.jsp" %>
<h2>문의내용 보기</h2>
<br/>
<form>
<table width="500" border="1" cellspacing="0" cellpadding="0" >  
  <tr height="30">
    <td align="center" width="125" >상품번호</td>
    <td align="center" width="125" align="center">
	     <%=dto.getPnum()%></td>
    <td align="center" width="125" >상태</td>
    <td align="center" width="125" align="center">
    	<%if(dto.getStatus() == 0){ %>
	     미처리
	     <%}else{ %>
	     처리됨
	     <%} %>
	     </td>
  </tr>
  <tr height="30">
    <td align="center" width="125">작성자</td>
    <td align="center" width="125" align="center">
	     <%=dto.getWriter()%></td>
    <td align="center" width="125" >작성일</td>
    <td align="center" width="125" align="center">
	     <%= sdf.format(dto.getReg())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" >제목</td>
    <td align="center" width="375" align="center" colspan="3">
	     <%=dto.getSubject()%></td>
  </tr>
  <tr>
    <td align="center" width="125" >문의내용</td>
    <td align="left" width="375" colspan="3"><pre><%=dto.getContent()%></pre></td>
  </tr>
  <tr height="30">      
    <td colspan="4" align="right" > 
    <%
    	if(id != null){
    		if(id.equals(dto.getWriter())){	
    %>
	  <input type="button" value="글삭제" 
       onclick="document.location.href='p_inquiryDeleteForm.jsp?num=<%=dto.getNum()%>&pnum=<%=dto.getPnum()%>&pageNum=<%=pageNum%>&ref=<%=ref%>'" />
	   &nbsp;&nbsp;&nbsp;&nbsp;
	   
	  <%}	
    }%>
    	<%if(store != null || admin != null){  %> 
	  <input type="button" value="글삭제"  
       onclick="document.location.href='p_inquiryDeleteForm.jsp?num=<%=dto.getNum()%>&pnum=<%=dto.getPnum()%>&pageNum=<%=pageNum%>&ref=<%=ref%>'" />
	   &nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" value="답글쓰기"  
       onclick="document.location.href='p_inquiryForm.jsp?num=<%=num%>&ref=<%=ref%>&pnum=<%=dto.getPnum() %>&ref_step=<%=ref_step%>'" />
	   &nbsp;&nbsp;&nbsp;&nbsp;
	 <% }%>
       <input type="button" value="돌아가기" 
       onclick='history.go(-1)' />
    </td>
  </tr>
</table><br/><br/>
<%
	if(dto.getRef_step() == 0){ // 답글 스탭이 0인 글에만 출력 (답글이 아닌 글에만 출력)
		P_inquiryDAO dao1 = P_inquiryDAO.getInstance();
		List list = null; // 답글 출력을 위한 리스트
		list = dao.answerInquiry(ref); 
		for(int i =0; i < list.size(); i++){
			P_inquiryDTO dto1 = (P_inquiryDTO)list.get(i);
%>

		<b>답변 내용</b>
<br/>
<form>
<table width="500" border="1" cellspacing="0" cellpadding="0">  
  <tr height="30">
    <td align="center" width="125" >상품번호</td>
    <td align="center" width="125" align="center">
	     <%=dto1.getPnum()%></td>
    <td align="center" width="125" >상태</td>
    <td align="center" width="125" align="center">
	     -</td>
  </tr>
  <tr height="30">
    <td align="center" width="125">작성자</td>
    <td align="center" width="125" align="center">
	     <%=dto1.getWriter()%></td>
    <td align="center" width="125" >작성일</td>
    <td align="center" width="125" align="center">
	     <%= sdf.format(dto1.getReg())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125" >제목</td>
    <td align="center" width="375" align="center" colspan="3">
	     <%=dto1.getSubject()%></td>
  </tr>
  <tr>
    <td align="center" width="125" >답변내용</td>
    <td align="left" width="375" colspan="3"><pre><%=dto1.getContent()%></pre></td>
  </tr>
  <tr height="30">      
    <td colspan="4" align="right" > </td></tr></table>
    <br /><br/></form>
<%} 
}%>
</form>      
</body>
</html>      
