<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.MemListDAO" %>
<%@ page import="pt1.MemListDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<%
	//관리자 여부 체크
	String admId = (String)session.getAttribute("admId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("3"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}
	
	//페이지 구성
	int pageSize = 50;
	int count=0; //글 개수
	int currentPage=0;
	int number=0;
	List memList=null; //회원 정보 저장
	MemListDAO dao = MemListDAO.getInstance();
	count = dao.getMemCount(); //회원수 세는 메소드의 결과 값 대입
	
	int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
	
	memList = dao.getMemList(pageNum); 
    //회원 정보 리스트에 저장
	
    number=count-(pageNum-1)*pageSize;
%>
<body>
	<%@ include file="../header/listAdmin.jsp" %>
	<h2>회원관리</h2>
	<h3>회원 목록 (<%=count %>명)</h3>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>ID</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>배송주소</th>
				<th>가입일</th>
				<th>계정관리</th>			
			</tr>
			<tbody>
				
	            <%
	            //회원 정보 반복문으로 출력
	            for(int i=0; i<memList.size();i++){
	            	MemListDTO member = (MemListDTO)memList.get(i);        	
	            //for(MemListDTO member : memList) { %>
				<tr>
					<td><%= number--%></td>
					<td><%= member.getId() %></td>
					<td><%= member.getName() %></td>
					<td><%= member.getTel() %></td>
					<td><%= member.getEmail() %></td>
					<td><%= member.getAddress() %></td>
					<td><%= member.getReg() %></td>
					<td>
						<% if( member.getActive() ==1){%>
						활성화
						<%}else{ %>
						비활성화
						<% }%>
						<!-- <input type="button" value="수정"> -->
						<form method="post" action="memListPro.jsp">
							<input type="hidden" name="id" value="<%= member.getId() %>">
							<input type="hidden" name="active" value="<%= member.getActive() %>">
							<input type="hidden" name="pageNum" value="<%= pageNum %>">
							<%
							if(member.getActive() ==1){%>
								<input type="submit" value="비활성화 하기">
						<%	}else{%>
								<input type="submit" value="활성화 하기">
						<%	} %>
   						</form>
					</td>
				</tr>
	            <% } %>
	      </tbody>
	   </table>
   <br>
   <div>
      <%
      	//하단에 페이지 처리
         int totalPage = (int)(dao.getMemCount() / 50)+1; //총 페이지 수. 50개씩 끊어서 보여줌
         if(totalPage >= 0) {
            if(pageNum > 1) { %>
               <a href="memList.jsp?pageNum=<%= pageNum - 1 %>">[이전]</a>
            <% }
            for(int i = 1; i <= totalPage; i++) { %>
               <% if(i == pageNum) { %>
					<a href="memList.jsp?pageNum=<%= i %>"><%= i %></a>
					<!-- <strong><%= i %></strong> -->
               <% } else { %>
                  <a href="memList.jsp?pageNum=<%= i %>"><%= i %></a>
               <% } %>
            <% }
            if(pageNum < totalPage) { %>
               <a href="memList.jsp?pageNum=<%= pageNum + 1 %>">[다음]</a>
            <% }
         } %>
         
   </div>
</body>
</html>