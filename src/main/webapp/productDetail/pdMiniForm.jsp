<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.ProductDAO"  %>
<%@ page import="pt1.ProductDTO"  %>
<%@ page import="java.util.ArrayList"  %>
<%@ page import="java.text.NumberFormat"  %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<jsp:useBean id="dto" class="pt1.ProductDTO" />
<jsp:setProperty name="dto" property="*" />

<style>
	img{
		width:200px;
		height: 200px;
	}
</style>

<%
	//로그인 한 아이디 확인
	String admid=(String)session.getAttribute("admId");	//관리자
	String store_id=(String)session.getAttribute("stoId");	//점주
	String memid=(String)session.getAttribute("memId");	//고객
	//상품에 대한 데이터 가져오기
	ProductDAO pdao = ProductDAO.getInstance(); 
	ArrayList<ProductDTO> list=pdao.checkProduct(dto.getPnum());
	
	session.setAttribute("pnum",dto.getPnum());
	
	for(ProductDTO dto1 : list){ %>
<body>
	<table width="800">
		<tr>
			<td>
				<%-- div는 레이아웃 나누기 / margin-top : 상단 여백 --%>
				<div id="image" style="width: 500px; margin-top: 30px;">
					<%-- 만약 지정한 경로에 이미지가 없다면 alt 속성에 있는 값이 출력.--%>
					<img src="/pt1/product/pimg/<%=dto1.getPimg() %>" alt="Product">
				</div>
			</td>
		</tr>
		<tr>
			<td width="300">
				<h3>선택상품: <%=dto1.getCategory() %> <%=dto1.getBrand() %> <%=dto1.getPname() %> <%=dto1.getColor() %> <%=dto1.getPsize()%></h3>
				<%NumberFormat nf = NumberFormat.getCurrencyInstance();%>
				가격: <%= nf.format(dto1.getPrice()).replace("₩", "") + "원" %>
				
				
					<%-- 구매수량 선택 --%>
					<form action="/pt1/productDetail/pdMainPro.jsp?pnum=<%=dto1.getPnum() %>">
						수량 : [<input type="number" min="1" max="500" step="1" name="quantity" value="1">]
						<input type="hidden" name="pnum" value="<%=dto1.getPnum()%>">
						<input type="hidden" name="memId" value=<%=memid%>/>
						<input type="submit" value="구매 or 장바구니에 담기">
	               	</form>
				
				
			</td>
		</tr>
		<tr>
			수량 : <input type="hidden" name="sell_price" value="<%=dto1.getPrice()%>">
			<input type="text" name="amount" value="1" size="3" max="">
			<input type="button" value=" + " name="add">
			<input type="button" value=" - " name="minus"><br>
			금액 : <input type="text" name="sum" size="11" readonly>원
<script>
			const formform=document.getElementsByname("form1"),
				sell_price = document.form1.sell_price,
				amount = document.form1.amount,
				add = document.form1.add,
				minus = document.form1.minus,
				sum = document.form1.sum;
			if(formform){
				sum.value = sell_price.value;
				
				let amountval = amount.value,
					sumval = sum.value,
					priceval = sell_price.value;
				
				if(add){
					add.addEventListener('click',function(){
						amountval++;
						sumval = amountval * priceval;
						amount.value = amountval;
						sum.value = sumval;
						console.log(amountval,sumval,priceval);
					})
				}
				
				if(minus){
					minus.addEventListener('click',function(){
						if(amountval > 1){
							amountval--;
							sumval = amountval * priceval;
							amount.value = amountval;
							sum.value = sumval;
							console.log(amountval,sumval,priceval);
						}else{
							amountval = 1;
						}
					})
				}
			}
			
</script>	
		
		<%}%>
	</table>
</body>	
	