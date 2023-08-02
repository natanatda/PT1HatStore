<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.FileInputStream" %>   
<%@ page import="java.io.BufferedOutputStream" %> 
<%@ page import="java.io.File" %> 
<%@ page import="java.io.IOException" %>         

<%
	request.setCharacterEncoding("utf-8");

	//관리자 여부 체크
	String admId = (String)session.getAttribute("admId");
	String level_num = (String)session.getAttribute("level_num");
	if(!(level_num.equals("3"))){%>
	<script>
		alert("잘못된 경로입니다.");
		location="/pt1/main/main.jsp";
	</script>
<%} 
	FileInputStream fis = null;
	BufferedOutputStream bos = null;
	
	//아래 두줄의 초기화 코드를 넣지 않으면 'java.lang.IllegalStateException' 발생 
	out.clear();
	out = pageContext.pushBody();


	try{
	    //String fileName = "D:\\dev\\pt1\\src\\main\\webapp\\store\\business\\testp1.pdf";
	    String dir = request.getRealPath("uploadbusiness");
	    String bfile = request.getParameter("bfile");
	    String fileName=dir+'\\'+bfile;
	    File file = new File(fileName);
	    
	    // 보여주기
	    //response.setContentType("application/pdf");
	    //response.setHeader("Content-Description", "JSP Generated Data");
	    // 다운로드
	    response.addHeader("Content-Disposition", "attachment; filename = " + file.getName() + ".pdf");
	 
	    fis = new FileInputStream(file);
	    int size = fis.available();
	    
	    byte[] buf = new byte[size];
	    int readCount = fis.read(buf);
	 
	    response.flushBuffer();
	 
	    bos = new BufferedOutputStream(response.getOutputStream());
	    bos.write(buf, 0, readCount);
	    bos.flush();
	} catch(Exception e) {
	    out.println("<script>alert('파일 오픈 중 오류가 발생하였습니다.');</script>");
	    e.printStackTrace();
	} finally{
        if(fis != null) fis.close();
        if(bos != null) bos.close();
	}
	
%>