<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="pt1.PaymentDTO" %>
<%@ page import="pt1.PaymentDAO" %>
<%@ page import="pt1.MemberDAO" %>
<%@ page import="pt1.MemberDTO" %>
<%@ page import="pt1.Payment_HistoryDTO" %>
<%@ page import="pt1.Payment_HistoryDAO" %>
<%@ page import="java.util.*" %>
<script src="/pt1/resources/js/kakaoPayForm.js"></script>

<%	
	String user_id = (String) session.getAttribute("memId");
	String address = request.getParameter("address"); 
	String tel = request.getParameter("tel");
	String name=request.getParameter("name");

	PaymentDAO dao = PaymentDAO.getInstance();
	Payment_HistoryDAO ddao = Payment_HistoryDAO.getInstance();
	
	List mylist=null;
	List mmylist=null;
	List memlist=null;
	
	mylist = dao.getPayment(user_id);
	mmylist = ddao.getPayment_History(user_id);
	PaymentDTO dto = new PaymentDTO();
	
	Payment_HistoryDTO ddto = new Payment_HistoryDTO();
	int product_id= dto.getProduct_id();
	int product_hid= ddto.getProduct_id();
	//int payment_id = Integer.parseInt(request.getParameter("payment_id"));
	dao.addPayment (user_id,product_id);
	

	
	
	
	ddao.addPayment_History(user_id,product_hid);
	

%>


<%
	MemberDAO mdao = MemberDAO.getInstance();
	MemberDTO mdto = new MemberDTO();
	String email = request.getParameter("email");
	
	memlist = mdao.getMemberinfo(user_id);
%>



	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakaoPayForm.jsp</title>

<%-- 
<style>
span {
	width: 60px;
	display: inline-block;
}

textarea {
	width: 40%;
	height: 280px;
}
--%>

<style>
  span {
    width: 60px;
    display: inline-block;
    font-weight: bold;
  }

  input, textarea {
    width: 40%;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
  }

  input[type="submit"] {
    background-color: #2196F3;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 18px;
  }

  input[type="submit"]:hover {
    background-color: #2196F3;
  }

  input[type="reset"] {
    background-color: #f44336;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 18px;
  }

  input[type="reset"]:hover {
    background-color: #da190b;
  }
</style>


</head>
<body>
<h2>kakao</h2>
			<% for (int i = 0; i < memlist.size(); i++) {
                          mdto = (MemberDTO) memlist.get(i);
                          
                %>
	<form action="kakaoPay.jsp" method="post" name="userinput" onSubmit="return checkIt()">

		<p>
		<span>name:</span> <input id="name" name="name" value="<%=mdto.getName() %>" required> 
		
		
		


			<!-- 값 가져오기 -->
		</p>
		<span>폰넘버:</span>
		<p>
			<input id="tel" name="tel" value="<%=mdto.getTel()%>" required>
		
		</p>
		<span>배송지:</span>
		<p>
			<input  id="address" name="address" value="<%=mdto.getAddress()%>" required>
		</p>
		<%} %>
		<% int sum=0; %>
			<% for (int i = 0; i < mylist.size(); i++) {
                          dto = (PaymentDTO) mylist.get(i);
                          
                %>
                <% sum += dto.getPrice() * dto.getQuantity(); %>
                <%} %>
		<span>총가격:</span>
		<p>
			
			<input id="totalPrice" name="totalPrice" value="<%=sum%>" readonly>
		</p>
		
		<input type="submit" value="결제하기"> 
		<input type="button" value="취소하기" onClick="location.href='/pt1/cart/payForm.jsp'"> 
	</form>


</body>
</html>




















