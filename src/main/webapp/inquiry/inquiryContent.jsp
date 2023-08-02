<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "pt1.InquiryDAO" %>
<%@ page import = "pt1.InquiryDTO" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import ="java.util.List" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	String id = (String)session.getAttribute("memId");	// 회원 세션 불러오기
    String admin = (String)session.getAttribute("admId"); // 관리자 세션 불러오기
    String store = (String)session.getAttribute("stoId"); // 점주 세션 불러오기
    String level_num = (String)session.getAttribute("level_num"); // 로그인 폼에서 지정한 레벨 불러오기
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 출력 형식 지정
	
	try{
		InquiryDAO dao = InquiryDAO.getInstance();
		InquiryDTO dto = dao.getArticle(num);
		
		int ref = dto.getRef();				// 글 그룹
		int re_step = dto.getRe_step();		// 답글 (가장 최근 답글이 1번~);
		int re_level = dto.getRe_level();	// 답글의 답글 1 ... ~
	
		if(id == null && admin == null && store == null && level_num == null ){ // 작성자나 관리자가 아닐경우 못 보게함
%>
		<script>
			alert("회원만 볼 수 있는 글입니다.");
			history.go(-1);
		</script>
		<%}%>
<body>
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
<h2>글내용 보기</h2>
<br/>
<form>
<table border="1"> 
<tr >
    <td>문의유형</td>
    <td colspan="3">
	     <%=dto.getCategory()%></td>
	     
  </tr> 
  <tr >
    <td >글번호</td>
    <td >
	     <%=dto.getNum()%></td>
    <td  >상태</td>
    <td >
    <%
    	if(dto.getStatus() == 0){%>   <%-- 상태값이 0이면 미처리, 1이면 처리된 글 --%>
    		미처리
    	<%}else{%>
    		처리됨
	     <%} %></td>
  </tr>
  <tr >
    <td >작성자</td>
    <td  >
	     <%=dto.getWriter()%></td>
    <td  >작성일</td>
    <td  >
	     <%= sdf.format(dto.getReg_date())%></td>
  </tr>
  <tr >
    <td  >글제목</td>
    <td  colspan="3">
	     <%=dto.getSubject()%></td>
  </tr>
  <tr>
    <td  >글내용</td>
    <td align="left" colspan="3"><pre><%=dto.getContent()%></pre></td>
  </tr>
  <tr >      
    <td colspan="4" align="right" > 
    <%
    	if(id != null || store != null){			// 멤버나 점주 세션이 있을경우
    		if(id.equals(dto.getWriter()) || store.equals(dto.getWriter()) ){	 // 아이디가 같은 작성자만 삭제 버튼 출력
    %>
	  <input type="button" value="글삭제" 
       onclick="document.location.href='inquiryDeleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&ref=<%=ref%>'" />
	   &nbsp;&nbsp;&nbsp;&nbsp; 
	  <%}
    } %>
    	<%if(admin != null){ %> 
	  <input type="button" value="글삭제" 
       onclick="document.location.href='inquiryDeleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&ref=<%=ref%>'" />
	   &nbsp;&nbsp;&nbsp;&nbsp;
	 	
	   		<%if(dto.getStatus() == 0 && dto.getRe_step() == 0){ %> <%-- 미처리상태와 답글이 아닌 글만 답글쓰기 가능 --%>
      <input type="button" value="답글쓰기" 
       onclick="document.location.href='inquiryForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'" />
	   &nbsp;&nbsp;&nbsp;&nbsp;
	 <%} 
	 } %>
	 <%if(level_num.equals("3")){ // 관리자는 글목록 누르면 관리하는 페이지로 이동 %>
	 <input type="button" value="글목록" 
       onclick="document.location.href='/pt1/inquiry/admininquiryList.jsp'" />
       &nbsp;&nbsp;&nbsp;&nbsp;
       <%}else{ %>
	 	<input type="button" value="글목록" 
       onclick="document.location.href='inquiryList.jsp?pageNum=<%=pageNum%>'" />
    	&nbsp;&nbsp;&nbsp;&nbsp;   
     <%} %>
       
    </td>
  </tr>
</table><br/><br/>
<%
	if(dto.getRe_step() == 0){ // 답글이 아닌 글만해당
		InquiryDAO dao1 = InquiryDAO.getInstance();
		List list = null;
		list = dao1.answerArticle(ref); // 글 그룹별로 글을 불러옴
		for(int i =0; i < list.size(); i++){ 
			InquiryDTO dto1 = (InquiryDTO)list.get(i); // 리스트에 저장된 값들 DTO에 저장
%>
		<b>답변 내용</b>
<br/>
<form>
<table border="1">  
  <tr >
    <td  >글번호</td>
    <td  >
	     <%=dto1.getNum()%></td>
    <td  >상태</td>
    <td  >
	     -</td>
  </tr>
  <tr >
    <td >작성자</td>
    <td  >
	     <%=dto1.getWriter()%></td>
    <td  >작성일</td>
    <td  >
	     <%= sdf.format(dto1.getReg_date())%></td>
  </tr>
  <tr >
    <td  >글제목</td>
    <td colspan="3">
	     <%=dto1.getSubject()%></td>
  </tr>
  <tr>
    <td  >글내용</td>
    <td align="left" colspan="3"><pre><%=dto1.getContent()%></pre></td>
  </tr>
  <tr >      
    <td colspan="4" align="right" > </td></tr></table>
    <br /><br/></form>
<%} 
}%>
<%
}catch(Exception e){} 
 %>
</form>      
</body>
</html>      
