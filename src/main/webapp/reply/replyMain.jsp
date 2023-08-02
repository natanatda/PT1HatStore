<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.ReplyDAO"  %>
<%@ page import="pt1.ReplyDTO"  %>
<%@ page import = "pt1.LikeyDAO"%>
<%@ page import="java.util.List"  %>
<%@ page import="java.text.SimpleDateFormat"  %>
<!DOCTYPE html>
<% 
   try{
   String admid=(String)session.getAttribute("admId");      //관리자 session
   String store_id=(String)session.getAttribute("stoId");   //점주 session
   String memid=(String)session.getAttribute("memId");      //회원 session
   String level_num=(String)session.getAttribute("level_num");   //level세션(관리자/점주/회원 구분 위함)
   
   int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   String rpageNum = request.getParameter("rpageNum");
    if (rpageNum == null) {
        rpageNum = "1";
    }
    
    int productNum = Integer.parseInt(request.getParameter("pnum"));
    
    int currentPage = Integer.parseInt(rpageNum);   //String을 숫자로 바꿔줌      //1
    int startRow = (currentPage - 1) * pageSize + 1;      //1
    int endRow = currentPage * pageSize;   //startRow ~ endRow 한페이지에 검색될 row      //10
    int count = 0;
    int number=0;
    List replyList = null;
    ReplyDAO dao = ReplyDAO.getInstance();
    LikeyDAO likeyDAO = LikeyDAO.getInstance();
    count = dao.getReplyCount(productNum);   //해당상품 리뷰개수
    ReplyDTO dto =  new ReplyDTO();
    if (count > 0) {
        replyList = dao.getReplys(productNum, startRow, endRow);
    }

    number=count-(currentPage-1)*pageSize;   // number = 전체글 개수 - (현재페이지번호-1)*10
    
%>
<html>
   <head>
      <title>리뷰</title>
      <style>
      	#reviewImg{
      		width:100px;
      		height:100px;
      	}
      </style>
   </head>
   <body>
      <h2>리뷰목록(전체 리뷰 :<%=count%>)</h2>
      <table width="700">
         <tr>
            
            <td >
            <%if((admid == null) && (memid == null)){         //로그인 안 했을때%>   
               <a href="/pt1/member/loginForm.jsp">로그인</a>
               
            <%}else{   //로그인 했을때
            	} %>
               <!-- 
               <button type="button" style="width: 100px;" onclick="location.href='/pt1/main/main.jsp'">메인</button>
                -->
              <%-- <button type="button" style="width: 100px;" onclick="location.href='/pt1/reply/replyWriteForm.jsp?replyNum=<%=dto.getReplyNum()%>&rpageNum=<%=currentPage%>&pnum=<%=productNum %>'">글쓰기</button>
            --%> 
            </td>
         </tr>
      </table>
   <%
      if(count == 0){
   %>
         <table width="700" border="1">
            <tr>
               <td >
                  게시판에 저장된 리뷰이 없습니다.
               </td>
            </tr>
         </table>
   <%   }else{ %>
         <table border="1"> 
            <tr height="30"> 
				<td width="150"  >글번호</td> 
<%--   			<td width="200" >상품번호</td> --%>
       			<td width="150" >작성자</td> 
<%--  			<td width="200" >제목</td>    --%> 
                <td width="500" >내용</td>
                <td width="200" >작성일</td>
                <td width="150" >평점</td>
                <td width="150" >사진</td>
                <td width="150" >좋아요</td>
                
                
             </tr>
          <%for(int i =0 ; i < replyList.size() ; i++){
             dto = (ReplyDTO)replyList.get(i);%>
             <tr height="30">
                <td width="50" > <%=number--%></td>
                 <%--<td width="150"><%= dto.getProductNum()%></td> --%>
                 <td width="150"><%= dto.getMemberId()%></td> 
           <%--   <td width="150">
                 <a href="/pt1/reply/replyContent.jsp?replyNum=<%=dto.getReplyNum()%>&rpageNum=<%=currentPage%>&pnum=<%=productNum %>">
                 <%= dto.getSubject()%></td>             --%>
                 <td width="150">
                 <a href="/pt1/reply/replyContent.jsp?replyNum=<%=dto.getReplyNum()%>&rpageNum=<%=currentPage%>&pnum=<%=productNum %>">
                       <%=dto.getContent()%></a> 
                 </td>
                 <td width="150"><%= sdf.format(dto.getRegDate())%></td>
                 <td width="150"><%= dto.getRating()%></td>
                 <td width="500" >
                  <img id="reviewImg"src="/pt1/uploadrimg/<%=dto.getRimg() %>" >
                 <td width="150">
                 <%
				int chk = likeyDAO.checkLike(memid,dto.getReplyNum(),productNum);
				if(chk == 0){ %>
                 <a onclick="return confirm('추천하시겠습니까?')" href="/pt1/reply/recommendReply.jsp?replyNum=<%=dto.getReplyNum()%>&rpageNum=<%=rpageNum%>&pnum=<%=productNum%>">추천</a>
				<%}else{ %>
				<a onclick="return confirm('추천취소하시겠습니까?')" href="/pt1/reply/recommendReply.jsp?replyNum=<%=dto.getReplyNum()%>&rpageNum=<%=rpageNum%>&pnum=<%=productNum%>">추천</a>
				<%} %>
                 <%= dto.getRecommend()%></td>
       <%      
       }%>
          </table>
          <%} %>
       <%
          if (count > 0) {
             int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
             int startPage = (int)(currentPage/10)*10+1;
             int pageBlock=10;
             int endPage = startPage + pageBlock-1;
             if (endPage > pageCount){ endPage = pageCount;}
             
             if (startPage > 10) {%>
                <a href="/pt1/productDetail/pdMainForm.jsp?rpageNum=<%= startPage - 10 %>&pnum=<%=productNum %>">[이전]</a>
             <%}
             for (int i = startPage ; i <= endPage ; i++) {  %>
                <a href="/pt1/productDetail/pdMainForm.jsp?rpageNum=<%= i %>&pnum=<%=productNum %>">[<%= i %>]</a>
             <%}
             if (endPage < pageCount) {  %>
                <a href="/pt1/productDetail/pdMainForm.jsp?rpageNum=<%= startPage + 10 %>&pnum=<%=productNum %>">[다음]</a>
             <%}
          }
   }catch(Exception e){} 
       %>
   </body>
</html>

