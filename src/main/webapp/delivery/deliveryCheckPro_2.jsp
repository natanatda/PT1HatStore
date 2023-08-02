<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import ="pt1.DeliveryDTO" %>
<%@ page import ="pt1.DeliveryDAO" %>
<%@ page import ="pt1.BrandDAO" %>
<%@ page import ="pt1.BrandDTO" %>
<%@ page import="java.util.List"  %>
<%@ page import="java.text.NumberFormat"  %>
<jsp:useBean id="dto" class="pt1.DeliveryDTO" />
<jsp:setProperty name="dto" property="*" />

<h1>test_store_brandCheckPro2.jsp</h1>

<%request.setCharacterEncoding("utf-8"); %>
<%	
	try{
	String store_id=(String)session.getAttribute("stoId");	//점주 session	
	String status=request.getParameter("status");	//배송 상태 변수
	Integer delivery_id=Integer.parseInt(request.getParameter("delivery_id")); // 배송번호 변수
	Integer brandno=Integer.parseInt(request.getParameter("brandno")); //브랜드번호 변수
	
	DeliveryDAO ddao=DeliveryDAO.getInstance();
	int result=ddao.updateDeliveryTwo(delivery_id);	//배송번호 변수를 매개변수로 넣어 배송중 상태로 UPDATE
	//UPDATE가 정상적으로 된 상태
	if(result == 2){
%> 
	<script>alert('수정되었습니다.')</script>;
	<meta http-equiv="Refresh" content="0;url=deliveryCheck.jsp">
	<input type="hidden" name="brandno" value="<%=brandno  %>">
	<%--UPDATE가 실패한 상태 --%>
<%	} else { %>
	    <script>
	    	alert('수정 실패했습니다.')
	    	history.go(-1);
    	</script>
<%}	
}catch(Exception e){}%>
