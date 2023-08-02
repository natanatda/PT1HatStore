<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.CartDTO" %>
<%@ page import="pt1.CartDAO" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="pt1.CartDTO" />
<jsp:setProperty name="dto" property="*" />
<%
	CartDAO dao = CartDAO.getInstance();
	
	String user_id = (String)session.getAttribute("memId"); // 회원 세션 불러옴
	
	int product_id = Integer.parseInt(request.getParameter("pnum")); // 상품 디테일 페이지에서 넘겨받은 값 변수에 대입
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	int result=0;
	
	if(quantity > 0){ // 수량이 1이상일때만 메서드 동작
		result=dao.addCart(product_id, user_id, quantity);
		if(result==2){%>
	<script>
		var result = window.confirm("중복된 상품을 장바구니에 담아 수량이 증가하였습니다. 장바구니로 이동할까요?");
		if (result) {
			// 예 버튼을 클릭한 경우
			window.location.href = "/pt1/cart/cartForm.jsp";
		} else {
			history.go(-1);
		}
	</script>
<%
		}else if(result==1){
%>

<script>
	var result = window.confirm("장바구니에 담겼습니다.  장바구니로 이동할까요?");
	if (result) {
	  // 예 버튼을 클릭한 경우
	   window.location.href = "/pt1/cart/cartForm.jsp";
	 
	} else {
		 history.go(-1);
	  
	}
</script>
<%
		}
}else{ %>
	<script>
		alert("수량을 조절해 주세요.");
		history.go(-1);
	</script>
<%} %>
