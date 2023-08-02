<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="pt1.StoreDAO" %>
    
    <%request.setCharacterEncoding("utf-8"); %>
    

  
</style>

    <jsp:useBean id="dto" class="pt1.StoreDTO" />
    <jsp:setProperty property="*" name="dto"/>
    
    <%
    	StoreDAO manager = StoreDAO.getInstance(); 
    	String result = manager.idFind(dto);
    	if(result==null){
%>     		<script>
    			alert("사업자 ID를 찾을 수 없습니다");
    			history.go(-1);
    		</script>
  <%  	}else{  %>
    		<h2>사업자 ID : [<%=result %>] 입니다 </h2>
    		<a href="/pt1/main/main.jsp">메인</a>
  <%   	} %>
    	
  