<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "pt1.P_inquiryDAO" %>
<%@ page import = "pt1.P_inquiryDTO" %>
<!DOCTYPE html>
<html>
<% request.setCharacterEncoding("UTF-8");%>

<%	 	
	// 각 세션을 불러옴
	String member = (String)session.getAttribute("memId");
	String store = (String)session.getAttribute("stoId");
	String admin = (String)session.getAttribute("admId");

	int pnum = Integer.parseInt(request.getParameter("pnum")); // 링크에 포함되어있는 상품 번호를 불러옴(해당 상품에만 리스트 출력하기 위해서)	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 출력 형식 지정
	
	// 페이지 출력 형식
	String ipageNum = request.getParameter("ipageNum");
	int pageSize = 10;
	if(ipageNum == null){ipageNum = "1";}
	int currentPage = Integer.parseInt(ipageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize; 
    int count = 0;
    int number = 0;
    
   	List inquiryList = null;	// 상품 문의 목록 출력을 위한 리스트 
   	P_inquiryDAO i_dao = P_inquiryDAO.getInstance();
   	count = i_dao.getP_inquiryCount(pnum); // 상품 번호별 문의글 개수 확인
   
   	if(count > 0){ // 문의 내역이 하나라도 있으면 리스트에 넣음
   		inquiryList = i_dao.getP_inquiry(pnum, startRow, endRow);
   	}
   	number = count - (currentPage-1) * pageSize;
%>
<head>
	<meta charset="UTF-8">
	<style>
	#pinquiryListBt {
		font-family: 'TheJamsil5Bold', sans-serif;
		background-color: #2196F3;
		width: 100px;
		height: 50px;
		border: none;
		color: #fff;
		font-size: 1em;
		font-weight: bold;
	}
	</style>
</head>
<br>
	<h2>상품 문의(<%=count%>개)</h2>
<br/>
<table width="500" >
<tr>
    <td align="right">
    <%if(member != null){ %>
    <form action="/pt1/p_inquiry/p_inquiryForm.jsp">
		<input type="hidden" name="pnum" value="<%=pnum%>" />
		<input id="pinquiryListBt"type="submit" value="문의하기"/>
	</form> 
	<%} %>
    </td>
</table>
<%
    if (count == 0) { 
%>
<table width="500" border="1" cellpadding="0" cellspacing="0" >
<tr>
    <td align="center">
 	   저장된 글이 없습니다.
    </td>
</table>

<%  } else{    %>
<table border="1" width="500" cellpadding="0" cellspacing="0"> 
    <tr height="30"> 
      <td align="center"  width="50"  >번 호</td> 
      <td align="center"  width="100" >제 목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td>    
       <td align="center"  width="50" >상태</td> 
    </tr>
<%  
        for (int i = 0 ; i < inquiryList.size() ; i++) { 
          P_inquiryDTO i_dto = (P_inquiryDTO)inquiryList.get(i); // 문의 목록 리스트 dto에 넣음
%>
   <tr height="30">
    <td align="center"  width="50" > <%=number--%></td>
    <td  width="100" align="center">
      <a href="/pt1/p_inquiry/p_inquiryContent.jsp?num=<%=i_dto.getNum()%>&pnum=<%=pnum%>&ipageNum=<%=currentPage%>">
           <%=i_dto.getSubject()%></a> </td>
    <td align="center"  width="100"> 
       <%=i_dto.getWriter()%></td> 
    <td align="center"  width="150"><%= sdf.format(i_dto.getReg())%></td>
    <td align="center"  width="50">
    <%
    	if(i_dto.getRef_step() == 1){ // 답글이면 상태칸에 - 출력 
    %>
    	-
	<%}else if(i_dto.getStatus() == 0){ // 처리 상태가 0이면 미처리 출력
	%>
	   미처리
	<%}else{// 0이 아니면 처리됨 출력 %>
		처리됨    
    <%}%>
    </td>
  </tr> 
     <%}%>
</table>
<%}%>
<%
	// 페이지 출력 형식
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (int)(currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}	
		if(startPage > 10){ %>
				<%-- 링크 수정 --%>
		<a href="p_inquiryList.jsp?ipageNum=<%=startPage - 10 %>">[이전]</a>
<%		}
		for(int i = startPage; i <= endPage; i++){  %>
		<a href="/pt1/productDetail/pdMainForm.jsp?pnum=<%=pnum %>&ipageNum=<%=i%>">[<%=i %>]</a>
<%		}
		if(endPage < pageCount) { %>
		<a href="p_inquiryList.jsp?ipageNum=<%=startPage + 10 %>">[다음]</a>
<%
		}
	}
%>
</body></html>