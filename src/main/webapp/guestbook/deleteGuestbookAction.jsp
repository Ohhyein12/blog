<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//요청값 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");

	GuestbookDao guestbookDao = new GuestbookDao();
	
	//삭제된 행 받을 변수 생성
	int row = 0;
	//deleteGuestbook 메서드 호출해서 삭제된 행 개수 row에 저장
	row = guestbookDao.deleteGuestbook(guestbookNo,guestbookPw);
	
	if(row  == 0) { // 삭제 실패
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp?guestbookNo=" + guestbookNo);
	} else if (row == 1) { // 삭제 성공
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	}else { // 수정된 행이 여러개라면? 잘못된 것
		System.out.println("에러");
	}
%>
