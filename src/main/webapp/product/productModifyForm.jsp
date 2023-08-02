<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.ProductDAO" %>
<%@ page import="pt1.ProductDTO" %>
    
<%
	//점주여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))||stoId==null){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}

	Integer pnum=Integer.parseInt(request.getParameter("pnum"));
	String pageNum = request.getParameter("pageNum");

	//상품 정보 불러오기
	ProductDAO dao = ProductDAO.getInstance();
	ProductDTO product = dao.getProduct(pnum);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 정보 수정</title>
	<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	<script src="/pt1/resources/js/pUpload.js"></script>
</head>
<body>
	<%@ include file="../header/listStore.jsp" %>
	<h2>상품 정보 수정</h2>
	<form name="userinput" action="productModifyPro.jsp" method="post" enctype="multipart/form-data" onsubmit="return checkInput()">
		<input type="hidden" name="pnum" value="<%=pnum%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="brandNo" value="<%=product.getBrandNo()%>">
		<table border="1">
			<tr>
				<td>상품 카테고리</td>
				<td><%=product.getCategory()%>
					<input type="hidden" name="category" value="<%=product.getCategory()%>">
				</td>
			</tr>
			<tr>
				<td>브랜드명</td>
				<td><%=product.getBrand()%>
					<input type="hidden" name="brand" value="<%=product.getBrand()%>">
				</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="pname" value="<%=product.getCategory()%>"></td>
			</tr>
			<tr>
				<td>색상</td>
				<td><input type="text" name="color" value="<%=product.getColor()%>"></td>
			</tr>
			<tr>
				<td>사이즈</td>
				<td><input type="text" name="psize" value="<%=product.getPsize()%>"></td>
			</tr>
			<tr>
				<td>재고</td>
				<td><input type="number" name="stock" value="<%=product.getStock()%>"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="number" name="price" value="<%=(int)product.getPrice()%>"></td>
			</tr>
			<tr>
				<td>상품이미지 첨부(이미지만 가능)</td>
				<td>
					<input type="file" name="save" accept="image/*">
				</td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td><textarea name="pdetail" rows="13" cols="40" ><%=product.getPdetail() %></textarea></td>
			</tr>
			<tr>
				<td>판매 여부 <br> Y 선택 시 상품 등록과 동시에 판매페이지에 노출됩니다.
				</td>
				<td>
					<input type="radio" name="onsale" value="1">Y
					<input type="radio" name="onsale" value="0">N
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정">
					<input type="button" value="취소" onclick="location='/pt1/store/productList.jsp?pageNum=<%=pageNum%>'">					
				</td>
			</tr>
		</table>
	</form>
</body>
</html>