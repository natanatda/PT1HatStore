<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.CartDTO" %>
<%@ page import="pt1.CartDAO" %>
<%@ page import="java.util.*" %>
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


<%for(int i = 0; i < mylist.size(); i++){
	CartDTO dto = (CartDTO)mylist.get(i); %>
<form>
	<table>
    	<tr height="30">
    	<td align="center" width="10">
    	<input type="checkbox" value="<%=dto.getProduct_id()%>" name="mycap" onclick="checkSelectAll()" />
    	</td>
    	
    	<td align="center" width="100">
    	<a href=""><%=dto.getPimg() %></a>
    	</td>
    	
    	<td align="left" width="300">
    	<%=dto.getPname() %>
    	</td>
    	
    	<td align="center" width="100">
    	<%=dto.getPrice() %>
    	</td>
    	
    	<td align="center" width="50">
    		<select>
    			<option name="quantity" value="<%=dto.getQuantity()%>"><%=dto.getQuantity() %></option>
    		</select>
    	</td>
    	<%
    	int tot = 0; // 합계 금액
    	tot = dto.getQuantity() * dto.getPrice();
    	
    	if(tot > 50000){ // 상품 갯수가 2개 이상이면
    		tot = dto.getQuantity() * dto.getPrice(); // 갯수 * 가격
    	}else{
    		tot = tot + 3000;
    	}
    	if(tot > 50000) {%>
    	<td align="center" width="50">
    	무료
    	</td>
    	<td align="center" width="100">
    	<%=tot %>
    	</td> 
    	<%}else{ %>
    	<td align="center" width="50">
    	3000원
    	</td>
    	<td align="center" width="100">
    	<%=tot %>
    	</td>
    	<td align="center" width="100">
	    <input type="button" value="삭제" onclick="location='cartDelete.jsp?cart_id=<%=dto.getCart_id()%>'"/>
    	<input type="submit" value="주문하기"/><br/></td>
    </table>
</form>
    	<%} %>
    	<%} %>
