<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="pt1.ProductDAO" %>
<%@ page import="pt1.BrandDAO" %>
<%@ page import="pt1.ProductDTO" %>
<%@ page import="java.sql.Timestamp" %>

<h1>productModifyPro.jsp</h1>
<%
	request.setCharacterEncoding("utf-8");
	
	String dir = request.getRealPath("uploadpimg");//파일 저장 경로
	
	int max = 1024*1024*10; //10메가
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, dir, max, "UTF-8", dp);

	String sysName = mr.getFilesystemName("save");
	
	Enumeration enu = mr.getFileNames();
	if(enu.hasMoreElements()){
		String key = (String)enu.nextElement();
		sysName = mr.getFilesystemName(key); //업로드한 파일의 이름을 찾음
	}
	//String name = mr.getParameter("name");
	
	//multipart/form-data이므로 데이터 직접 대입
	ProductDTO dto = new ProductDTO();
  	String category=mr.getParameter("category");
  	String pnum=mr.getParameter("pnum");
  	String pname=mr.getParameter("pname");
  	Integer brandNo=Integer.parseInt(mr.getParameter("brandNo"));
  	String color=mr.getParameter("color");
  	String psize=mr.getParameter("psize");
  	String stock=mr.getParameter("stock");
  	String price=mr.getParameter("price");
  	String pdetail=mr.getParameter("pdetail");
  	String onsale=mr.getParameter("onsale");
  	
  	BrandDAO branddao = BrandDAO.getInstance();
  	String brandName = branddao.getStoreBrandName(brandNo);
 
  	dto.setCategory(category);
  	dto.setPname(pname);
  	dto.setBrandNo(brandNo);
  	dto.setBrand(brandName);
  	dto.setColor(color);
  	dto.setPsize(psize);
  	dto.setStock(Integer.parseInt(stock));
  	dto.setPrice(Integer.parseInt(price));
  	dto.setReg(new Timestamp(System.currentTimeMillis()));
  	dto.setPdetail(pdetail);
  	dto.setOnsale(Integer.parseInt(onsale));
  	dto.setPimg(sysName);
  	
  	ProductDAO dao = ProductDAO.getInstance();
  	int result=dao.updateProduct(dto, Integer.parseInt(pnum));
  	%>
  	
<h1><%=result %></h1>
<%	if(result==1){
%>
	<script>
		alert("수정성공!");
	</script>
	<meta http-equiv="Refresh" content="0;url=/pt1/store/productList.jsp" >
<% }else{%>
      <script>      
        alert("수정실패");
        history.go(-1);
     </script>
<%
    }
 %>  
