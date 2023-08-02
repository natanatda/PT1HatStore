<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.BrandDAO" %>
<%@ page import="pt1.BrandDTO" %>
<%@ page import="pt1.BrandPermitDAO" %>
<%@ page import="pt1.BrandPermitDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 목록</title>
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
	List brandList=null; //브랜드 정보 저장
	BrandDAO dao = BrandDAO.getInstance();
	BrandPermitDAO permitdao = BrandPermitDAO.getInstance();
	count = dao.getBrandCount(); //브랜드 세는 메소드의 결과 값 대입
	
	int pageNum = (request.getParameter("pageNum") == null) ? 1 : Integer.parseInt(request.getParameter("pageNum"));
    //pageNum의 값을 가져오는데 null이면 1, null이 아니면 pageNum 가져오기
	
	brandList = dao.getBrandList(pageNum);
    //브랜드 정보 리스트에 저장
	
    number=count-(pageNum-1)*pageSize;
%>
<body>
	<%@ include file="../header/listAdmin.jsp" %>
	<h2>브랜드 관리</h2>
	<h3>브랜드 목록 (<%=count%>명)</h3>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>ID</th>
				<th>브랜드번호</th>
				<th>브랜드명</th>
				<th>대표자</th>
				<th>사업자번호</th>
				<th>종목</th>
				<th>가입일</th>
				<th>입점 신청</th>
				<th>수정 신청</th>
				<th>계정관리</th>
			</tr>
			<tbody>
				
	            <%
	            //브랜드 정보 반복문으로 출력
	            for(int i=0; i<brandList.size();i++){
	            	BrandDTO brand = (BrandDTO)brandList.get(i);        	
	            %>
				<tr>
					<td><%= number--%></td>
					<td><%= brand.getStore_id() %></td>
					<td><%= brand.getBrandNo() %></td>
					<td><%= brand.getBrand() %></td>
					<td><%= brand.getRepresentative() %></td>
					<td><%= brand.getBNumber() %></td>
					<td><%= brand.getSectors() %></td>
					<td><%= brand.getApplication_date() %></td>
					<td>
						<% if(brand.getPermit()==0){ %>
							수리 대기 상태<br>
							<a href="/pt1/admin/brandLaunchPermit.jsp?brandNo=<%= brand.getBrandNo() %>&pageNum=<%=pageNum%>">신청서 보러가기</a>
						<% }else{%>
							입점 수락 완료
						<%} %>
					</td>
					<td>
						<%if(permitdao.getBrand(brand.getBrandNo())!=null){ %>
							<a href="/pt1/admin/brandModifyPermit.jsp?brandNo=<%= brand.getBrandNo() %>&pageNum=<%=pageNum%>">신청서 보러가기</a>
						<%}else{ %>
							&nbsp;
						<%} %>
					</td>
					<td>
						<% if( brand.getActive() ==1){%>
						활성화
						<%}else{ %>
						비활성화
						<% }%>
						<!-- <input type="button" value="수정"> -->
						<form method="post" action="brandListPro.jsp">
							<input type="hidden" name="brandNo" value="<%= brand.getBrandNo() %>">
							<input type="hidden" name="active" value="<%= brand.getActive() %>">
							<input type="hidden" name="pageNum" value="<%= pageNum %>">
							<%
							if(brand.getActive() ==1){%>
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
         int totalPage = (int)(dao.getBrandCount() / 50)+1; //총 페이지 수. 50개씩 끊어서 보여줌
         if(totalPage >= 0) {
            if(pageNum > 1) { %>
               <a href="brandList.jsp?pageNum=<%= pageNum - 1 %>">[이전]</a>
            <% }
            for(int i = 1; i <= totalPage; i++) { %>
               <% if(i == pageNum) { %>
					<a href="brandList.jsp?pageNum=<%= i %>"><%= i %></a>
					<!-- <strong><%= i %></strong> -->
               <% } else { %>
                  <a href="brandList.jsp?pageNum=<%= i %>"><%= i %></a>
               <% } %>
            <% }
            if(pageNum < totalPage) { %>
               <a href="brandList.jsp?pageNum=<%= pageNum + 1 %>">[다음]</a>
            <% }
         } %>
         
   </div>
</body>
</html>