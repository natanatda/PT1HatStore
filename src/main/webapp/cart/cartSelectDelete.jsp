<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.CartDAO" %>
  <!DOCTYPE html>
    
<%
	CartDAO dao = CartDAO.getInstance();
	String user_id = (String)session.getAttribute("memId"); // 회원 세션 불러옴 
	String[] mycaps = request.getParameterValues("mycap"); // cartForm에서 넘겨받은 체크박스 값들 문자열 배열에 저장
	
	int[] product_id = new int[mycaps.length]; // 넘겨받은 값들 길이만큼 정수형 배열 선언
		
	for(int i = 0; i < mycaps.length; i++){
		product_id[i] = Integer.parseInt(mycaps[i]); // 문자열 배열 값들 형변환해서 정수형 배열에 저장
	}
	for(int i = 0; i < product_id.length; i++){ 
		 dao.selectDelete(product_id[i]); // 배열 길이만큼 해당 인덱스에 있는 값들로 메서드 동작
	}
	
	if(user_id == null){%>
		<script>
			alert("잘못된 접근입니다.");
			location="/pt1/member/loginForm.jsp";
		</script>
<%	}%>
	<script>
		alert("삭제되었습니다.");
		location="/pt1/cart/cartForm.jsp";
	</script>
	
	
	
	