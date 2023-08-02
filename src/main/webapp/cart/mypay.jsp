<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%request.setCharacterEncoding("utf-8"); %>



<%@ page import="java.util.*" %>
<%@ page import="pt1.Payment_HistoryDTO" %>
<%@ page import="pt1.Payment_HistoryDAO" %>

<%@ page import="pt1.ProductDAO" %>
<%@ page import="pt1.ProductDTO" %>
<%@ page import="java.text.NumberFormat" %>
<%
	NumberFormat nf = NumberFormat.getCurrencyInstance();
%>
<style>

body {
  background-color: #F7F7F7;
  font-family: Arial, Helvetica, sans-serif;
  font-size: 16px;
  color: #333;
}

hr {
  border: none;
  border-top: 1px solid #ddd;
  margin: 20px 0;
}

h3 {
  margin-top: 0;
  color: #fff;
  padding: 10px;
  background-color: #212121;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

table {
  border-collapse: collapse;
  margin: 0 auto;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  border-radius: 5px;
}

th, td {
  padding: 10px;
  border: 1px solid #ddd;
}

th {
  background-color: #F7F7F7;
  font-weight: bold;
}

tr:nth-child(even) {
  background-color: #F0F0F0;
}

a {
  display: block;
  padding: 10px;
  background-color: #2196F3;
  color: #fff;
  font-weight: bold;
  text-decoration: none;
  border-radius: 5px;
  margin: 20px auto;

  max-width: 110px;

}
</style>

<%
	Payment_HistoryDAO dao = Payment_HistoryDAO.getInstance();
	String user_id = (String) session.getAttribute("memId");
	
	
	List mmylist=null;
	Payment_HistoryDTO dto = new Payment_HistoryDTO();
	mmylist = dao.getPayment_History(user_id);
	
	ProductDAO ddao =ProductDAO.getInstance();
	ProductDTO ddto = new ProductDTO();
	
%>



<%

   if(session.getAttribute("memId")==null){    //세션 값 꺼냈을때 그게 널 = 로그인 안된 거 %>
   		 로그인 필요<input type="button" value="로그인하기" onclick="javascript:window.location='/pt1/member/loginForm.jsp'">
  <%}else{ %>


<html>
<head>
    <title>주문내역</title>
</head>
<body>
    <hr>
 
        <h3>주문내역</h3>
        <table border="1" cellpadding="8">
  
       <a href="/pt1/main/main.jsp">메인</a><a href="/pt1/cart/refundPage.jsp">환불신청내역 보러가기</a>
       
            <thead>
                <tr>
                	
                    <th>주문번호</th>
					<th>상품명</th>
					<th>가격</th>
					<th>수량</th>
					<th>총액</th>
					<th>결제일시</th>
					<th>브랜드</th>
                    <th>환불신청</th>
                    <th>환불신청 조회</th>
                    <th>배송조회</th>
                
                </tr>
            </thead>
            <tbody>
           

<% for (int i = 0; i < mmylist.size(); i++) {

    dto = (Payment_HistoryDTO)mmylist.get(i);
    String pname=ddao.getProductBrandName(dto.getPname());	//해당 데이터의 상품 이름으로 브랜드 값 추력하여 pname 변수에 대입
%>
    <tr>
    <%-- <td><input type="button" value="환불신청" onclick="location='repay.jsp'"/></td>--%>
        <td><%= dto.getPayment_id() %></td>
        <td><%= dto.getPname() %></td>
        <td><%= nf.format(dto.getPrice()).replace("₩", "") + "원" %></td>
		<td><%= dto.getQuantity() %></td>
        <td><%= nf.format(dto.getPrice()*dto.getQuantity()).replace("₩", "") + "원" %></td>
		<td><%= dto.getCreated_at() %></td>
        <td><%= pname%></td>
        <td><input type="button" value="환불신청" onclick="location='repay.jsp?Payment_id=<%=dto.getPayment_id()%>&id=<%=dto.getProduct_id()%>&pname=<%=dto.getPname()%>&price=<%=dto.getPrice()%>&quantity=<%=dto.getQuantity()%>'"/></td>
        <td><input type="button" value="환불신청 조회" onclick="location='repayFind.jsp?Payment_id=<%=dto.getPayment_id()%>&id=<%=dto.getProduct_id()%>&pname=<%=dto.getPname()%>&price=<%=dto.getPrice()%>&quantity=<%=dto.getQuantity()%>'"/></td>
        <td><input type="button" value="배송조회" onclick="location='/pt1/delivery/deliveryFind.jsp?payment_id=<%=dto.getPayment_id()%>'"/></td>
    <% } %>
    <% }%>
    </tr>
    