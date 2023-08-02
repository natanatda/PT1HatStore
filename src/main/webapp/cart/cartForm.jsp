<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.CartDTO" %>
<%@ page import="pt1.CartDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat"  %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%
	NumberFormat nf = NumberFormat.getCurrencyInstance();    
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<%
	CartDAO dao = CartDAO.getInstance();
	String user_id = (String)session.getAttribute("memId");
	
	int result = dao.countCart(user_id);
	
	List mylist = null;
	mylist = dao.getCart(user_id);
	
	if(user_id == null){
%>
	<script>
		alert("잘못된 접근입니다.");
		location="/pt1/member/loginForm.jsp";
	</script>
<%} %>

<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">

<title>장바구니</title>        
</head>
	              
<body>        
<%@ include file="../header/listMember.jsp" %>
<b><h2>장바구니</h2></b>    
<script src="/pt1/resources/js/cart.js"></script>       

    <%if(result==0){ %>       
    	<h2> 장바구니에 담긴 상품이 없습니다.</h2>          
    <% }else{ %>         
<form method="post" onsubmit="return chkCart(this);">          
<table  border="1">        
    <tr >      
      <td   width="10"  >							
      <input type="checkbox" value="selectall" name="selectall" onclick="selectAll(this)"/>          
      </td> 
      <td    >이미지</td>         
      <td align="left"   >상품 정보</td>        
      <td    >판매가</td>         
       <td    >수량</td>       
       <td    >배송비</td>         
       <td    >합계</td>         
       <td    >담은 날짜</td>         
       <td    >선택</td>         
    </tr>

<%for(int i = 0; i <mylist.size(); i++){       
	CartDTO dto = (CartDTO)mylist.get(i); %>          
    	<tr >
    	<td  width="10">
    	<input type="checkbox" value="<%=dto.getProduct_id()%>" name="mycap" onclick="checkSelectAll()" />
    	</td>
    	
    	<td  >
          <a href="/pt1/productDetail/pdMainForm.jsp?pnum=<%=dto.getProduct_id()%>">
          <img src="<%= request.getContextPath() %>/uploadpimg/<%= dto.getPimg() %>" alt="Product" height="100" ></a>
    	</td>
    	<td align="left" >
    	<%=dto.getPname() %>
    	</td>
    	
    	<td  >
    	<%= nf.format(dto.getPrice()).replace("₩", "") + "원" %>
    	</td>
    	
    	<form>
	    	
	    	<td  >
	    		<input type="hidden" name="cart_id" value="<%=dto.getCart_id() %>" />
	    		<input type="number" min="1" max="500" step="1" name="quantity" value="<%=dto.getQuantity()%>"/> 
	    		<button type="submit" formaction="/pt1/cart/cartUpdatePro.jsp?cart_id=<%=dto.getCart_id()%>">변경</button>
	    	</td>
    	</form>
    	<%
    	int tot = 0; // 합계 금액 = 갯수 * 가격
    	tot = dto.getQuantity() * dto.getPrice();
    	%>
    	<td  >
    	무료
    	</td>
    	<td  >
    	<%= nf.format(tot).replace("₩", "") + "원" %>
    	</td> 
    	<td><%=sdf.format(dto.getCreated_at())%></td>
    	<td  >
	      <input type="button" value="삭제" onclick="location='/pt1/cart/cartDelete.jsp?cart_id=<%=dto.getCart_id()%>'"/>
	    </td></tr>
    	<%} %>
    	</br>
    	</br>
    </table>

    	</br></br>
    	<button type="submit" formaction="/pt1/cart/cartSelectDelete.jsp"  style="border:1px solid #212121;" >선택삭제</button>
    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	<button type="submit" formaction="/pt1/cart/addPay.jsp"
    	 style="font-size: 1.5em; background-color:#2196F3; border:1px solid #212121;">주문하기</button>
    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	
    	<input type="button" value="전체삭제" onclick="location='/pt1/cart/cartDeleteAll.jsp'" style="background-color:#FA9884; border:1px solid #212121;">

    <%} %>
</body>
</html>