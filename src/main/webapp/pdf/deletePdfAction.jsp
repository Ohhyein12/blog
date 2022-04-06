<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<% 
	//요청값 받아오기
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	String pdfPw = request.getParameter("pdfPw");
	
	PdfDao pdfDao = new PdfDao();
	
	//no랑 pw넣어서 pdf삭제하는 메서드 호출해서 삭제된 행 반환된 값 row에 저장
	int row = pdfDao.deletePdf(pdfNo,pdfPw);
	
	if(row  == 0) { // 삭제 실패
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/pdf/deletePdfForm.jsp?pdfNo=" + pdfNo);
	} else if (row == 1) { // 삭제 성공
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/pdf/pdfList.jsp");
	}else { // 수정된 행이 여러개라면? 잘못된 것
		System.out.println("에러");
	}
	
%>
