<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="pt1.RefundDAO" %>

<% 
//int product_id = Integer.parseInt(request.getParameter("id"));
//String pname = request.getParameter("pname");
//int price = Integer.parseInt(request.getParameter("price"));
//int quantity =Integer.parseInt(request.getParameter("quantity"));
//String refundwhy= request.getParameter("refundwhy");

//RefundDAO dao = RefundDAO.getInstance();


//String user_id = (String) session.getAttribute("memId");



//int payment_id = Integer.parseInt(request.getParameter("payment_id"));
//dao.insertRefund(product_id);

%>

<h1>환불 신청</h1>
    <br>
<h3>< 환불 정보 ></h3>
<p>상품 번호: <%=request.getParameter("id")%></p>
<p>상품 이름: <%=request.getParameter("pname")%></p>
<p>상품 가격: <%=request.getParameter("price")%></p>
<p>상품 수량: <%=request.getParameter("quantity")%></p>

<% 
String user_id = (String) session.getAttribute("memId");
int product_id = Integer.parseInt(request.getParameter("id"));
String pname = request.getParameter("pname");
int price = Integer.parseInt(request.getParameter("price"));
int quantity = Integer.parseInt(request.getParameter("quantity"));

%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>환불신청</title>
	<style>
		body {
			font-family: Arial, sans-serif;
			background-color: #F7F7F7;
		}

	h1 {
		font-size: 2em;
		color: #333;
	
		margin-top: 50px;
	}

	input[type="text"] {
		padding: 10px;
		font-size: 1em;
		border-radius: 5px;
		border: 1px solid #ccc;
		width: 50%;
		margin: 20px auto;
		display: block;
	}

	input[type="submit"] {
		padding: 10px 30px;
		font-size: 1em;
		border-radius: 5px;
		background-color: #0077FF;
		color: #fff;
		border: none;
		cursor: pointer;
		display: block;
		margin: 20px auto;
	}

	input[type="submit"]:hover {
		background-color: #0066CC;
	}
</style>
</head>
<body>
	

<form method="post" name="refund" action="repayPro.jsp" >

<input type="hidden" name="user_id" value="<%=user_id%>" />
<input type="hidden" name="product_id" value="<%=product_id%>" />
<input type="hidden" name="pname" value="<%=pname%>" />
<input type="hidden" name="price" value="<%=price%>" />
<input type="hidden" name="quantity" value="<%=quantity%>" />

환불사유
<input type="text" name="refundwhy" placeholder="환불사유"/>

<%-- <form action="/pt1/cart/repayPro.jsp" method="post">
	<input type="text" name="refundwhy" placeholder="환불사유"/>
	<input type="submit" value="신청">--%>
	
	<input type="submit" value="신청" />
	
	<%-- <input type="text" name="refundwhy" placeholder="환불사유"/>
	<td><input type="button" value="신청" onclick="location='repayPro.jsp?id=<%=product_id%>&pname=<%=pname%>&price=<%=price%>&quantity=<%=quantity%>'"/></td>--%>
	 
</form>
</body>
</html>



















