<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pt1.RefundDAO" %>
<%@ page import="pt1.RefundDTO" %>
<%@ page import="java.text.NumberFormat"  %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>

<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">

    <%
	RefundDAO dao = RefundDAO.getInstance();
	String user_id = (String) session.getAttribute("memId");
	NumberFormat nf = NumberFormat.getCurrencyInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String level_num=(String)session.getAttribute("level_num");   //level세션(관리자/점주/회원 구분 위함)
	List mmylist=null;
	RefundDTO dto = new RefundDTO();
	mmylist = dao.getRefund(user_id);
%>
<%
   if(session.getAttribute("memId")==null){    //세션 값 꺼냈을때 그게 널 = 로그인 안된 거 %>
   		 로그인 필요<input type="button" value="로그인하기" onclick="javascript:window.location='/pt1/member/loginForm.jsp'">
  <%}else{ %>

	<body>
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
   <h3>환불신청내역</h3>
   <%if(mmylist==null){
	   %>
	   <table border="1">
	   	<tr>
	   		<td>
	   			환불 내역이 없습니다.
	   		</td>
	   	</tr>
	   </table>
   <%
   }else{
	   %>
        <table border="1" cellpadding="8">
        <a href="/pt1/main/main.jsp">메인</a>
            <thead>
                <tr>
                	
                    <th>상품번호</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>수량</th>
                    <th>환불신청 일자</th>
                    <th>환불사유</th>
                    <th>환불완료 일자</th>
                    <th>처리상태</th>
    
        </tr>
            </thead>
            <tbody>
           
         
     <% //for (int i = 0; i < mmylist.size(); i++) {
    //dto = (Payment_HistoryDTO)mmylist.get(i);
   //List productList = null;
   //String pname = dto.getPname(); 
    //productList = ddao.searchProduct(pname);
%>
<% for (int i = 0; i < mmylist.size(); i++) {

    dto = (RefundDTO)mmylist.get(i);
    List productList = null;
 
%>
    <tr>
    <%-- <td><input type="button" value="환불신청" onclick="location='repay.jsp'"/></td>--%>
        <td><%= dto.getProduct_id() %></td>
        <td><%= dto.getPname() %></td>
        <td><%=nf.format(dto.getPrice()).replace("₩", "") + "원" %></td>
        <td><%= dto.getQuantity() %></td>
        <td><%= sdf.format(dto.getAdded_at()) %></td>
        <td><a href="/pt1/cart/repayContent.jsp?c_num=<%=dto.getRefund_id()%>&status=<%=dto.getStatus()%>"><%= dto.getRefundwhy() %></a></td>
        <td>
        <%if(dto.getFin_at() != null){ %>
        <%= sdf.format(dto.getFin_at()) %>
        <%}else{ %>
        	처리 대기중
        <%} %>
        </td>
        <td>
        <%if(dto.getStatus().equals("5")){ %>환불신청<%} %>
        <%if(dto.getStatus().equals("6")){ %>환불중<%} %>
        <%if(dto.getStatus().equals("7")){ %>환불실패<%} %>
        <%if(dto.getStatus().equals("8")){ %>환불완료<%} %>
        </td>
    <%  } %>
<% 	}
   }%>

      
          

    </tr>
    