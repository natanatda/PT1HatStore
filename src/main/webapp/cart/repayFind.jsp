<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.RefundDAO" %>
<%@ page import="java.text.NumberFormat"  %>
<%@ page import="java.util.*" %>
<%@ page import="pt1.RefundDTO" %>
<%@ page import="pt1.RefundDAO" %>

<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">

    <%
	RefundDAO dao = RefundDAO.getInstance();
	String user_id = (String) session.getAttribute("memId");
	int Payment_id = Integer.parseInt(request.getParameter("Payment_id"));
	 NumberFormat nf = NumberFormat.getCurrencyInstance();
	
	List refundlist=null;
	RefundDTO dto = new RefundDTO();
	refundlist = dao.findRefund(user_id, Payment_id);
	
	
%>
    

<%

   if(session.getAttribute("memId")==null){    //세션 값 꺼냈을때 그게 널 = 로그인 안된 거 %>
   		 로그인 필요<input type="button" value="로그인하기" onclick="javascript:window.location='/pt1/member/loginForm.jsp'">
  <%}else{ %>


   <h3>환불신청내역</h3>
        <table border="1" cellpadding="8">
        <a href="/pt1/main/main.jsp">메인</a>
            <thead>
                <tr>
                	
                    <th>상품번호</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>환불신청 일자</th>
                    <th>환불처리 상태</th>

    
        </tr>
            </thead>
            <tbody>
           
         
     <% //for (int i = 0; i < mmylist.size(); i++) {
    //dto = (Payment_HistoryDTO)mmylist.get(i);
   //List productList = null;
   //String pname = dto.getPname(); 
    //productList = ddao.searchProduct(pname);
%>
<% if(refundlist==null) { %>
<td>환불 신청 정보가 없습니다.</td>
<% } else{ %>
<% for (int i = 0; i < refundlist.size(); i++) {

    dto = (RefundDTO)refundlist.get(i);
 
%>
    <tr>
    <%-- <td><input type="button" value="환불신청" onclick="location='repay.jsp'"/></td>--%>
        <td><%= dto.getProduct_id() %></td>
        <td><%= dto.getPname() %></td>
        <td><%=nf.format(dto.getPrice()).replace("₩", "") + "원" %></td>
        <td><%= dto.getQuantity() %></td>
        <td><%= dto.getAdded_at() %></td>
		<%
			if (dto.getStatus().equals("5")) {
		%>
			<td>환불 신청</td>
		<%
			} else if (dto.getStatus().equals("6")) {
		%>
			<td>환불 수리</td>
		<%
			} else if (dto.getStatus().equals("8")) {
		%>
			<td>환불 완료</td>
		<%	} else if (dto.getStatus().equals("7")) {%>
			<td>환불 실패</td>
		<%	} %>
    <%  } %>
<% }
}%>

      
          

    </tr>
    