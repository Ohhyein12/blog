<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 이름 중복 불가 -->
<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.io.File" %>
<%
	request.setCharacterEncoding("utf-8");

	String path = application.getRealPath("uploadPdf");
	System.out.println(path);
	MultipartRequest multiReq = new MultipartRequest(request, path,1024*1024*100,"utf-8",new DefaultFileRenamePolicy()); // 얠 진행하는 순간 파일은 자동으로 무조건 받아짐
	
	String pdfPw = multiReq.getParameter("pdfPw");
	String writer = multiReq.getParameter("writer");
	
	//<input type="file" name="pdf">에 대한 처리
	String pdfOriginalName = multiReq.getOriginalFileName("pdf"); // 파일 업로드시 원본의 이름
	String pdfName = multiReq.getFilesystemName("pdf"); // new DefaultFileRenamePolicy()객체를 통해 변경된 이름
	String pdfType = multiReq.getContentType("pdf");
	
	//디버깅
	System.out.println(pdfPw + "<--pdfPw");
	System.out.println(writer + "<--writer");
	System.out.println(pdfOriginalName + "<--pdfOriginalName");
	System.out.println(pdfName + "<--pdfName");
	System.out.println(pdfType + "<--pdfType");
	
	if(pdfType.equals("application/pdf")) {
	
		System.out.println("db start!");
		PdfDao pdfDao = new PdfDao();
		Pdf pdf = new Pdf();
		pdf.setPdfName(pdfName);
		pdf.setPdfOriginalName(pdfOriginalName);
		pdf.setPdfType(pdfType);
		pdf.setPdfPw(pdfPw);
		pdf.setWriter(writer);
		
		pdfDao.insertPdf(pdf);
	
		response.sendRedirect(request.getContextPath() + "/pdf/pdfList.jsp");

	} else {
		System.out.println("pdf파일만 업로드!");
		// 잘못들어온 파일이므로
		File file = new File(path+"\\"+pdfName);
		file.delete();
		response.sendRedirect(request.getContextPath()+"/pdf/insertPdfForm.jsp");

	}
%>
