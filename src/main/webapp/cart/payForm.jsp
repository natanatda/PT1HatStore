<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%request.setCharacterEncoding("utf-8"); %>
<%@ page import="pt1.PaymentDTO" %>
<%@ page import="pt1.PaymentDAO" %>
<%@ page import="pt1.MemberDAO" %>
<%@ page import="pt1.MemberDTO" %>
<%@ page import="pt1.Payment_HistoryDTO" %>
<%@ page import="pt1.Payment_HistoryDAO" %>
<%@ page import="java.text.NumberFormat"  %>
<%@ page import="java.util.*" %>
<script src="/pt1/resources/js/payForm.js"></script>

<script>
	alert('결제 페이지에서는 뒤로가기 사용할 수 없습니다. 하단의 주문 취소 버튼을 눌러주세요');
</script>

<%
	String user_id = (String)session.getAttribute("memId");
	NumberFormat nf = NumberFormat.getCurrencyInstance();
	PaymentDAO dao = PaymentDAO.getInstance();
	MemberDAO mdao = MemberDAO.getInstance();
	
	mdao.getMemberinfo(user_id);
	List mylist=null;
	mylist=mdao.getMemberinfo(user_id);
	
	
	List paylist = null;
	
	paylist = dao.getPayment(user_id);
	
	
	Payment_HistoryDAO ddao = Payment_HistoryDAO.getInstance();
	List pay_hlist=null;
	pay_hlist = ddao.getPayment_History(user_id);
%>
<%
	//점주 여부 체크
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("1"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<% }%>


<!DOCTYPE html>
<html>
<head>
<title>결제</title>
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
<script src="cart.js"></script>
<script>
window.onpopstate = function(event) {
	  history.go(1);
	  handleGoback();
	  window.history.pushState('forward', null, null);
	};
	window.history.pushState('forward', null, null);
</script>
</head>

<body>
<%@ include file="../header/listMember.jsp" %>

<h2>결제하기</h2>
<h3>결제리스트</h3>
<b style="color:tomato;">결제 페이지에서는 뒤로가기 사용할 수 없습니다. 하단의 주문 취소 버튼을 눌러주세요.</b>

<% if(paylist.size() == 0){ %>
<table border="1">
  <tr>
    <td>
     주문할 상품이 없습니다.  
    </td>
  </tr></br></br>
</table>

<%}else{ 
int totalSales = 0;%>
<form action="payConfirm.jsp" method="post" name="userinput" onSubmit="return checkIt()" >
	<table border="1"> 
		<tr>
			<td >이미지</td>
			<td >상품번호</td>
			<td >상품명</td>
			<td >판매가</td>
			<td >수량</td>
			<td >선택</td>
			<td >합계</td>
	    </tr>
				<%
				// 결제 리스트 출력
				for(int i = 0; i < paylist.size(); i++){
				PaymentDTO dto = (PaymentDTO)paylist.get(i); %>
		<tr>
		    <td><img src="<%= request.getContextPath() %>/uploadpimg/<%= dto.getPimg() %>" alt="Product" height="200"></td>
		    <td><%=dto.getProduct_id() %></td>
		    <td><%=dto.getPname() %></td>
		    <td><%=nf.format(dto.getPrice()).replace("₩", "") + "원" %></td>
		    
		    <td>
		    	<!--  수량
			    <select name="<%=dto.getProduct_id()%>_quantity">
				<option value="<%=dto.getQuantity()%>"><%=dto.getQuantity()%></option></select>
				 -->
				<%=dto.getQuantity()%>
				
				<%-- <input type="number" name="<%=dto.getProduct_id()%>_quantity" value="<%=dto.getQuantity()%>" min="1" onkeydown="if (event.keyCode === 48) event.preventDefault();">--%>
			</td>
			<td>
				<input type="button" value="삭제" onclick="location='deletePartPay.jsp?payment_id=<%=dto.getPayment_id()%>'" /> 
			</td>
				<%
					int tot = dto.getPrice() * dto.getQuantity();
				%> 
				<td><%=nf.format(tot).replace("₩", "") + "원" %></td>
				
				<%
						
						totalSales += tot;
				%>
		          <%} %>
		          <%-- <%} %> --%>
		   </td>
		</tr>
	</table>
	<h2 style="text-align:center;">총 결제금액 : <%=nf.format(totalSales).replace("₩", "") + "원" %></h2>
    			<%for(int i = 0; i < mylist.size(); i++){
					MemberDTO dto = (MemberDTO)mylist.get(i); %>
<table width="1000" rowspan="2" colspan="3">

<tr><td ></br></br>

<%-- <form action="payPro3.jsp" method="post">--%>


<label for="paymentMethod">결제수단을 선택해주세요:</label>
<select name="paymentMethod" id="paymentMethod">
    <option value="credit_card">Credit Card</option>
    <option value="bank_transfer">Bank Transfer</option>
    <option value="paypal">PayPal</option>
</select>
<br><br>
</td></tr>


<%--
<tr><td>
휴대전화 입력
<input type="text" id="tel" name="tel" value="<%=dto.getTel() %>" size="60" maxlength="50" placeholder="휴대전화 번호를 입력해주세요." required>
<input type="button" value="인증번호 받기" onclick="location='phoneCheck.jsp'"/>
</td></tr>
<tr><td>
인증번호를 입력해주세요
<input type="text" name="code" size="60" maxlength="50" placeholder="인증번호를 입력해주세요." required>
<input type="button" value="다시 받기"/>--%>
<tr><td>
<br><br>
<input type="submit"
value="결제하기" style="font-size: 1.5em; background-color:#2196F3; border:1px solid #212121;"/>  
<input type="button" value="주문취소" onclick="location='clearCart.jsp'" style="border:1px solid #212121;"/>
<input type="button"
value="전체삭제" onclick="location='deletePay.jsp'" style="background-color:#FA9884; border:1px solid #212121;" />
</td></tr>

</form>


<tr><td>


</td></tr></form>
	<%}
    			
}%>
	<script>
	function showPaymentOption(value) {
	  if (value === "card") {
	    document.getElementById("card-option").style.display = "block";
	    document.getElementById("phone-option").style.display = "none";
	  } else if (value === "phone") {
	    document.getElementById("card-option").style.display = "none";
	    document.getElementById("phone-option").style.display = "block";
	  } else {
	    document.getElementById("card-option").style.display = "none";
	    document.getElementById("phone-option").style.display = "none";
	  }
	}
</script>



</table>