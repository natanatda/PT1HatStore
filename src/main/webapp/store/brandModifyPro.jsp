<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h1>pUploadPro.jsp</h1>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="pt1.BrandPermitDTO" %>
<%@ page import="pt1.BrandPermitDAO" %>
<%@ page import="java.sql.Timestamp" %>

<%
	//관리자 여부 체크
	String stoId = (String)session.getAttribute("stoId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("2"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%}

	request.setCharacterEncoding("utf-8");
	
	//String brandNo = request.getParameter("brandNo");
	String dir = request.getRealPath("uploadbusiness");//파일 저장 경로
	
	int max = 1024*1024*10; //10메가
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, dir, max, "UTF-8", dp);

	String sysName = mr.getFilesystemName("bsave");
	
	Enumeration enu = mr.getFileNames();
	if(enu.hasMoreElements()){
		String key = (String)enu.nextElement();
		sysName = mr.getFilesystemName(key); //업로드한 파일의 이름을 찾음
	}
	
	//multipart/form-data이므로 데이터 직접 대입
	BrandPermitDTO dto = new BrandPermitDTO();
  	//String store_id=mr.getParameter("store_id");
  	String brandNo=mr.getParameter("brandNo");
  	String brand=mr.getParameter("brand");
  	String representative=mr.getParameter("representative");
  	String bNumber=mr.getParameter("bnumber");
  	String sectors=mr.getParameter("sectors");
  	String bLocation=mr.getParameter("blocation");
  	
  	dto.setStore_id(stoId);
  	dto.setBrandNo(Integer.parseInt(brandNo));
  	dto.setBrand(brand);
  	dto.setRepresentative(representative);
  	dto.setbNumber(bNumber);
  	dto.setSectors(sectors);
  	dto.setbLocation(bLocation);
  	dto.setbFile(sysName);
  	dto.setApplication_date(new Timestamp(System.currentTimeMillis()));
  	dto.setPermit(0);
  	
  	BrandPermitDAO dao = BrandPermitDAO.getInstance();
  	int result=dao.applicationBrand(dto);
  	%>
  	
<h1><%=result %></h1>
<%	if(result==1){
%>
	<script>
		alert("신청 성공!");
	</script>
	<meta http-equiv="Refresh" content="0;url=brandList.jsp" >
<% }else{%>
      <script>      
        alert("신청 실패");
        history.go(-1);
     </script>
<%
    }
 %>  
