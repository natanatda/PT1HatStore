<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.PaymentDAO" %>
<%@ page import="pt1.PaymentDTO" %>
<%@ page import="pt1.Payment_HistoryDTO" %>
<%@ page import="pt1.Payment_HistoryDAO" %>

<%
	PaymentDAO dao = PaymentDAO.getInstance();
	Payment_HistoryDAO ddao = Payment_HistoryDAO.getInstance();
	
	String user_id = (String)session.getAttribute("memId");
	
	String[] mycaps = request.getParameterValues("mycap");
	// name이 mycap이란 체크박스 중 체크해서 넘어온 요소들을 모두 불러와서 문자열 타입 배열에 저장
	
	int[] product_id = new int[mycaps.length];
	// 문자열 배열 크기만큼 정수형 배열 선언 (체크박스 안에 값이 상품 번호라 정수형으로 형번환 시켜주기 위해서)
	
	for(int i = 0; i < mycaps.length; i++){ 
		product_id[i] = Integer.parseInt(mycaps[i]);
		// 문자열 타입 배열들 정수형 타입 배열에 형변환해서 대입
	}
	for(int i = 0; i < product_id.length; i++){
		dao.addPayment(user_id, product_id[i]);
		// 반복문으로 인덱스별 다른 상품번호 DB테이블에 저장
	}
	
%>
	<script>
		location="payForm.jsp";
	</script>

	
	