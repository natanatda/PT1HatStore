<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.Order_HistoryDAO" %>
<%@ page import="pt1.Order_HistoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%
   request.setCharacterEncoding("utf-8"); 
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
   
   Order_HistoryDAO dao = Order_HistoryDAO.getInstance();
   String store = (String)session.getAttribute("stoId");
   String admin = (String)session.getAttribute("admId");
   String level_num = (String)session.getAttribute("level_num");
   if(!(level_num.equals("3")) && !(level_num.equals("2"))){
      %>
      <script>
         alert("잘못된 경로입니다.");
         location="/pt1/main/main.jsp";
      </script>
   <%
   }
   int order_history_id = Integer.parseInt(request.getParameter("order_history_id")); //orderList.jsp에서 주문내역ID불러옴
      
   Order_HistoryDTO dto = dao.getContent(order_history_id); // 주문내역 불러오는 메서드
   
   int tot = dto.getPrice() * dto.getQuantity(); // 총 결제금액 계산을 위한 변수
   int status = dto.getStatus(); // 상태 값마다 다르게 출력하기 위한 변수
   String brand = dto.getBrand();
   
   int result = 0;
   if(level_num.equals("2")){%>
	   <%@ include file="../header/listStore.jsp" %>
   	<%result = dao.checkContent(brand, store);
   }
   if(level_num.equals("3")){%>
	   <%@ include file="../header/listAdmin.jsp" %>
	   	<%result = 1;
	   }
   if(result == 0){
%>
	<script>
		alert("잘못된 경로입니다.");
		history.go(-1);
	</script>
<%}%>
<head>
	<title>주문내역</title>
	<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
</head>
<body>
<h2>주문내역</h2> <br/>
<table border="1">
   <tr >
      <td >주문 번호</td>
      <td ><%=dto.getOrder_history_id()%></td>
      <td >처리 상태</td>
      <%if(status == 0){%><td >결제완료</td><%}%>
      <%if(status == 1){%><td >상품준비중</td><%}%>
      <%if(status == 2){%><td >주문취소</td><%}%>
      <%if(status == 3){%><td >배송중</td><%}%>
      <%if(status == 4){%><td >배송완료</td><%}%>
      <%if(status == 5){%><td >환불요청</td><%}%>
      <%if(status == 6){%><td >환불완료</td><%}%>
      <%if(status == 7){%><td >구매확정</td><%}%>
      <%if(status == 8){%><td >완료</td><%}%>
      
   </tr>
   <tr>   
      <td  >주문 ID</td>
      <td colspan="3" ><%=dto.getOrder_id()%></td>
   </tr>
   
   <tr >
      <td >상품명</td>
      <td colspan="3" ><%=dto.getPname() %></td>
   </tr>
   
   <tr >
      <td  >수량</td>
      <td colspan="3"  ><%=dto.getQuantity() %></td>
   </tr>
   <tr >   
      <td  >결제금액</td>
      <td colspan="3"  ><%=tot%></td>
   </tr>
   <tr >   
      <td  >결제수단</td>
      <td colspan="3"  ><%=dto.getPayment_method() %></td>
   </tr>
   
   <tr >   
      <td >배송지</td>
      <td colspan="3" ><%=dto.getAddress() %></td>
   </tr>
   
   <tr >
      <td  >전화번호</td>
      <td colspan="3"  ><%=dto.getTel() %></td>
   </tr>
   <tr >   
      <td colspan="1"  >주문일시</td>
      <td colspan="3"  ><%=sdf.format(dto.getCreated_at())%> </td>
   </tr>
   <tr>
      <td colspan="4" align="rigth">
      <input type="button" value="돌아가기" onclick="history.back()"/>
      &nbsp;&nbsp;
      </td></tr>
</table>
</body>

