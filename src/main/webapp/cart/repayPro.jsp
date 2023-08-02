<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="pt1.RefundDAO"%>

<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="refund" class="pt1.RefundDTO">
	<jsp:setProperty name="refund" property="*" />
</jsp:useBean>
<%@ page import="pt1.Payment_HistoryDTO"%>
<%@ page import="pt1.Payment_HistoryDAO"%>

<%
String user_id = (String) session.getAttribute("memId");
int product_id = Integer.parseInt(request.getParameter("product_id"));
String pname = request.getParameter("pname");
int price = Integer.parseInt(request.getParameter("price"));
int quantity = Integer.parseInt(request.getParameter("quantity"));
String refundwhy = request.getParameter("refundwhy");
RefundDAO dao = RefundDAO.getInstance();

//int payment_id = Integer.parseInt(request.getParameter("payment_id"));
int result = dao.addRefund(refund);

	if(result == 1) {
%>
<script>
	alert("환불신청이 완료되었습니다");
	location = "/pt1/main/main.jsp";
</script>

<%
	} else{
%>
<script>
	alert("환불신청이 실패하였습니다.");
	history.go(-1);
</script>
<%
	}
%>