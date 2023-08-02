
    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="pt1.MemberDAO" %>
    
    <%request.setCharacterEncoding("utf-8"); %>

    <jsp:useBean id="dto" class="pt1.MemberDTO" />
    <jsp:setProperty property="*" name="dto"/>
    
    <%
    	MemberDAO manager = MemberDAO.getInstance(); 
    	String result = manager.pwFind(dto);
    	if(result==null){
%>     		<script>
    			alert("PW를 찾을 수 없습니다");
    			history.go(-1);
    		</script>
  <%  	}else{  %>
    		<h2>PW : [<%=result %>] 입니다 </h2>
    		<a href="/pt1/main/main.jsp">메인</a>
  <%   	} %>
    	
  