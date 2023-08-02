<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.ProductDAO"  %>
<%@ page import="pt1.ProductDTO"  %>
<%@ page import="pt1.MemberDAO"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="java.text.NumberFormat"  %>
<% request.setCharacterEncoding("UTF-8");%>



<!DOCTYPE html>
<style>
   #pMain{
      width:300px;
      height: 300px;
   }
</style>
<html>
<jsp:useBean id="dto" class="pt1.ProductDTO" />
<jsp:setProperty name="dto" property="*" />
<head>
   <meta charset="UTF-8">
   <link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
   <title>상세 페이지</title>
   <style>
   	.cartBt{
		font-family: 'TheJamsil5Bold', sans-serif;
		width: 100px;
		height: 50px;
		border: 1px solid #919191;
		font-size: 1em;
		font-weight: bold;
	}
	
	.buyBt {
		font-family: 'TheJamsil5Bold', sans-serif;
		background-color: #2196F3;
		width: 100px;
		height: 50px;
		border: none;
		color: #fff;
		font-size: 1em;
		font-weight: bold;
	}
   </style>
</head>

<%
   //로그인 한 아이디 확인
   String admid=(String)session.getAttribute("admId");   //관리자
   String store_id=(String)session.getAttribute("stoId");   //점주
   String memid=(String)session.getAttribute("memId");   //고객
   String level_num = (String) session.getAttribute("level_num");
   NumberFormat nf = NumberFormat.getCurrencyInstance();
   //상품에 대한 데이터 가져오기
   ProductDAO pdao = ProductDAO.getInstance(); 
   ArrayList<ProductDTO> list=pdao.checkProduct(dto.getPnum());
   
   session.setAttribute("pnum",dto.getPnum());
   
   
%>
<%if(level_num!=null){
      // level_num이 3일 경우 (레벨 3 =>관리자)
      if(level_num.equals("3")){%>
         <%@ include file="../header/listAdmin.jsp" %>
      <%
      //level_num이 2일 경우 (레벨 2 =>점주)
      } else if(level_num.equals("2")){ %>
         <%@ include file="../header/listStore.jsp" %>
      <%
      //level_num이 1일 경우 (레벨 1 =>회원)
      } else if(level_num.equals("1")){%>
            <%@ include file="../header/listMember.jsp" %>
      <%}
   }else{%>
      <%@ include file="../header/listGuest.jsp" %>
   <%} %>
   
<body>
   <% for(ProductDTO dto1 : list){ %>
      <div class="product_view">
      <h2><%=dto1.getPname() %></h2>
      <!-- 
      <button type="button" style="width: 100px;" onclick="location.href='/pt1/classification/classification.jsp'">상품목록</button>
       -->
      <table class="productTable" border="1">
         <div >
            <img id="pMain" src="<%= request.getContextPath() %>/uploadpimg/<%= dto1.getPimg() %>" alt="Product">
         </div>
         <tr>
            <th>판매가</th>
            <td><%=nf.format(dto1.getPrice()).replace("₩", "") + "원" %></td>
         </tr>
         <tr>
            <th>상품코드</th>
            <td><%=dto1.getPnum()%></td>
         </tr>
         <tr>
            <form id="purchase-form" action="" method="post">
                  <th>구매 수량 : </th>
                     <td>
                     <input type="number" min="0" max="<%=dto1.getStock() %>" step="1" name="quantity" value="0" onchange="getTotalPrice()"> 
                     <input type="hidden" name="pnum" value="<%=dto1.getPnum()%>">
                     <input type="hidden" name="action" value="">
                    </td>
         </tr>
         <tr>
            <th>옵션선택</th>
            <td>
               <select>
                  <option>FREE 사이즈(+0)</option>
               </select>
            </td>
         </tr>
         <tr>
            <th>배송비</th>
            <td>무료배송</td>
         </tr>
         <tr>
            <th>결제금액</th>
            <td><span id="total-price"></span></td>
         </tr>
         <tr>
            <td colspan="2">
               <% if(!(level_num==null)){
               if(level_num.equals("1")){ %>
               <button class="cartBt" type="button" onclick="addToCart()">장바구니</button>
               <button class="buyBt" type="button" onclick="buyNow()">구매하기</button>
               <%}
               }else{ %>
               <button class="cartBt" type="button" onclick="alert('일반회원으로 로그인 하세요.');">장바구니</button>
               <button class="buyBt" type="button" onclick="alert('일반회원으로 로그인 하세요.');">구매하기</button>
               <%} %>
            </td>
         </tr>
      </form>
      </table>
   </div>
   
<script>
      function addToCart() {
         document.getElementsByName('action')[0].value = 'cart';
         document.getElementById('purchase-form').action = '/pt1/cart/cartAdd.jsp';
         document.getElementById('purchase-form').submit();
      }
      function buyNow() {
   const quantity = document.getElementsByName('quantity')[0].value;
         if(quantity < 1){
            alert("수량을 조절해 주세요.");
            return;
         }

         document.getElementsByName('action')[0].value = 'buy';
         document.getElementById('purchase-form').action = '/pt1/cart/addPay2.jsp';
         document.getElementById('purchase-form').submit();
      }
      function getTotalPrice(){
         var selectQuantity = document.getElementsByName("quantity")[0].value;
         var selectPrice = "<%=dto1.getPrice()%>";
         var multiQP=selectQuantity*selectPrice;
         document.getElementById("total-price").innerText = multiQP.toLocaleString() + "원";
         //document.write(multiQP);
      }
   </script>
   <%}
   %>

   <br/>
   <br/>

   <div class="product-grid">
      <jsp:include page="../reply/replyMain.jsp?pnum=<%=productNum %>&rpageNum=<%=rpageNum %>" flush="false" />
   </div>
   <div class="product-grid">
      <jsp:include page="../reply/replyWriteForm.jsp" flush="false" />
   </div>
   <div class="product-grid">
      <jsp:include page="../p_inquiry/p_inquiryList.jsp?pnum=<%=productNum %>&ipageNum=<%=ipageNum%>" flush="false" />
   </div>
</body>

<%--
<%
   ProductDAO pdao = ProductDAO.getInstance(); 
   ArrayList<ProductDTO> list=pdao.selectgoods(dto.getPname());
   for(ProductDTO dto1 : list){ %>
<input type="hidden" name = "pnum" value="<%=dto1.getPnum()%>">
<body>
   <table>
      <tr><td><img src="/pt1/main/image/<%=dto1.getPimg() %>" alt="Product"></td></tr>
      <tr><td>카테고리   : <%=dto1.getCategory() %></td></tr>
      <tr><td>색상      : <%=dto1.getColor() %></td></tr>
      <tr><td>브랜드   : <%=dto1.getBrand() %></td></tr>
      <tr><td>사이즈   : <%=dto1.getPsize() %></td></tr>
      <tr><td>재고      : <%=dto1.getStock() %></td></tr>
      <tr><td>가격      : <%=dto1.getPrice() %></td></tr>
      <tr><td>세일      : <%=dto1.getOnsale() %></td></tr>
   <%}%>
   </table>
</body>
--%>