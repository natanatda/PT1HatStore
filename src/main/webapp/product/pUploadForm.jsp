<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pt1.BrandDAO" %>
<%@ page import="pt1.BrandDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

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

	List brandNameList=null; //브랜드명 리스트에 저장
	BrandDAO dao = BrandDAO.getInstance();
	brandNameList = dao.getStoreBrandNameList(stoId);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품 등록</title>
	<link rel="stylesheet" type="text/css" href="/pt1/resources/css/listTable.css">
	<script src="/pt1/resources/js/pUpload.js"></script>
</head>

<%@ include file="../header/listStore.jsp" %>
<h3>상품 등록</h3>
<form name="userinput" method="post" action="pUploadPro.jsp" enctype="multipart/form-data" onsubmit="return checkInput()">
  <table border="1">
    <tr> 
      <td><b>상품 카테고리</b></td>
      <td>
      	<select name="category">
      		<option value="">카테고리 선택</option>
      		<option value="cap">cap</option>
      		<option value="hat">hat</option>
      		<option value="snapback">snapback</option>
      		<option value="beret">beret</option>
      		<option value="beanie">beanie</option>
      		<option value="etc">etc</option>
      	</select>
      </td>
    </tr>  
    <tr> 
      <td>상품명</td>
      <td><input type="text" name="pname"></td>
    </tr>
    <tr> 
      <td>브랜드명</td>
      <td>
	      <select name="brandNo">
	      	<option value="">브랜드 선택</option>
	      	<%for(int i=0; i<brandNameList.size();i++){
	      		BrandDTO brand = (BrandDTO)brandNameList.get(i); %>
				<option value="<%= brand.getBrandNo() %>"><%=brand.getBrand() %></option>
			<%} %>
	      	</select>
      	</td>
    </tr>
    <tr>
      <td>색상</td>
      <td><input type="text" name="color" maxlength="20"></td>
    </tr>
    <tr> 
      <td>사이즈</td>
      <td><input type="text" name="psize" maxlength="10"></td>
    </tr>
    <tr> 
      <td>재고</td>
      <td><input type="number" name="stock" onkeyup="inputNumberFormat(this)"></td>
    </tr>
    <tr> 
      <td>가격</td>
      <td><input type="number" name="price" onkeyup="inputNumberFormat(this)"></td>
    </tr>
    <tr>
      <td>상품이미지</td>
      <td><input type="file" name="save"></td>
     </tr>
    <tr> 
      <td>상품설명</td>
      <td><textarea name="pdetail" rows="13" cols="40"></textarea></td>
    </tr>
    <tr> 
      <td>
      	판매 여부 <br>
      	Y 선택 시 상품 등록과 동시에 판매페이지에 노출됩니다.
      </td>
      <td>
      	<input type="radio" name="onsale" value="1">Y
		<input type="radio" name="onsale" value="0">N
      </td>
    </tr>
    <tr>
      <td colspan="2"> 
          <input type="button" value="취 소" onclick="javascript:window.location='/pt1/main/main.jsp'">
          <input type="submit" value="등 록" >
      </td>
    </tr>
  </table>
</form>
</body>
</html>
