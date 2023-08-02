<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.util.*" %>
<%@ page import="pt1.CartDAO" %>
<%@ page import="pt1.PaymentDAO" %>
<%@ page import="pt1.PaymentDTO" %>
<%@ page import="pt1.Payment_HistoryDTO" %>
<%@ page import="pt1.Payment_HistoryDAO" %>
<%@ page import="pt1.Order_HistoryDAO" %>
<%@ page import="pt1.DeliveryDAO" %>
<%@ page import="java.text.NumberFormat"  %>
<style>
body {
  background-color: #f1f1f1;
  font-family: Arial, Helvetica, sans-serif;
  font-size: 14px;
  color: #333;
}

h1,
h2,
h3 {
  margin-top: 0;
  color: #fff;
  background-color: #f1f1f1;
  padding: 10px;
}

hr {
  border: none;
  border-top: 1px solid #ccc;
  margin: 20px 0;
}

table {
  border-collapse: collapse;
  margin: 0 auto;
  border-radius: 10px; /* 테이블 모서리 둥글게 */
  overflow: hidden; /* 테이블 크기가 넘어갈 때 부분 숨기기 */
}

th,
td {
  padding: 10px;
  border: 1px solid #ccc;
  background-color: #fff;
  
}

th {
  background-color: #00BFFF;
}

tr:nth-child(even) {
  background-color: #00BFFF;
}

a {
  display: block;
  padding: 10px;
  background-color: #00BFFF;
  color: #fff;
  font-weight: bold;
  text-decoration: none;
  border-radius: 5px;
  margin: 20px auto;
  max-width: 100px;
}



/* 하늘색 배경 색상 조절 */
h1,
h2,
h3,
a,
th {
  background-color: #7AC9EB;
  color: #fff;
}

</style>


<%
String paymentMethod = (String)session.getAttribute("paymentMethod");
NumberFormat nf = NumberFormat.getCurrencyInstance();
if(paymentMethod != null && paymentMethod.equals("credit_card")){
    // 카드 선택 처리
    String cardNumber = request.getParameter("cardNumber");
    String cardExpireDate = request.getParameter("cardExpireDate");
    String cardCvc = request.getParameter("cardCvc");
    
    // payPro.jsp 페이지에서 카드 정보를 사용할 수 있도록 처리
    request.setAttribute("cardNumber", cardNumber);
    request.setAttribute("cardExpireDate", cardExpireDate);
    request.setAttribute("cardCvc", cardCvc);
} else {
    // 다른 결제 방법 선택 처리  
    // ...
}


String address = request.getParameter("address");
String name = request.getParameter("name");
String tel = request.getParameter("tel");
PaymentDAO dao = PaymentDAO.getInstance();
Payment_HistoryDAO ddao = Payment_HistoryDAO.getInstance();
Order_HistoryDAO history = Order_HistoryDAO.getInstance();
DeliveryDAO delivery_history = DeliveryDAO.getInstance();
CartDAO cartdao = CartDAO.getInstance();

String user_id = (String) session.getAttribute("memId");
List mylist=null;

mylist = dao.getPayment(user_id);
PaymentDTO dto = new PaymentDTO();

List mmylist=null;
//mmylist = ddao.getPayment_History(user_id);
Payment_HistoryDTO ddto = new Payment_HistoryDTO();

int product_id= dto.getProduct_id();
int product_hid=ddto.getProduct_id();
//int payment_id = Integer.parseInt(request.getParameter("payment_id"));
dao.addPayment (user_id,product_id);
Payment_HistoryDTO dto2 = new Payment_HistoryDTO();

%>




<html>
<head>
    <title>결제 완료</title>
</head>
<body>
    <h1>결제 완료</h1>
    <hr>
        <h2>주문이 완료되었습니다.</h2>
       </br>
       </br>
       </br>
        <table border="1" cellpadding="8">
            <thead>
                <tr>
                  <%--<th>주문번호</th> --%>  
                    <th>상품번호</th>
                    <th>상품명</th>
                    <th>수량</th>
                    <th>가격</th>
                    <th>결제 총액</th>
                    <th>결제수단</th>
                    <th>결제 일시</th>
                    <th>주문자</th>
                    <th>배송지</th>
                    <th>연락처</th>
                    
                </tr>
            </thead>
            <tbody>
                <% for (int i = 0; i < mylist.size(); i++) {
                          dto = (PaymentDTO) mylist.get(i);
                     //     dto2 = (Payment_HistoryDTO) mmylist.get(i);
                          history.setHistory(dto,address);
                          delivery_history.setDelivery(dto, name, address);
                          ddao.addPayment_History(dto);
                          cartdao.deleteAfterPay(dto.getProduct_id(), user_id);
                %>
                    <tr>
                    <%--  <td><%= dto2.getPayment_id() %></td> --%>  
                        <td><%= dto.getProduct_id()%></td>
                        <td><%= dto.getPname()%></td>
                        <td><%= dto.getQuantity() %></td>
                        <td><%=nf.format(dto.getPrice()).replace("₩", "") + "원" %></td>
                        <%
                        int tot = 0; // 합계 금액 = 갯수 * 가격
    					tot = dto.getQuantity() * dto.getPrice();
    					 %>
    					<td><%=nf.format(tot).replace("₩", "") + "원" %></td>
                        <td><%= paymentMethod %></td>
                        <td><%= dto.getCreated_at()%></td>
                        <td><%= user_id %></td>
                        <td><%= address %></td>
                        <td><%= tel %></td>
                    </tr>
                <% } %>
                <%
                dao.deleteLastProduct(user_id);
                %>
            </tbody>
        </table>
        <br>
        <a href="/pt1/cart/mypay.jsp">확인</a>
        
</body>
</html>









