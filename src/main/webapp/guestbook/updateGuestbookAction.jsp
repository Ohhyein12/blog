<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.GuestbookDao" %>
<%
	request.setCharacterEncoding("utf-8");// 인코딩하기 한글안깨지게

	//요청값 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String writer = request.getParameter("writer");
	String guestbookContent = request.getParameter("guestbookContent");
	String guestbookPw = request.getParameter("guestbookPw");
	
	//디버깅코드
	System.out.println(guestbookNo);
	System.out.println(writer);
	System.out.println(guestbookContent);
	System.out.println(guestbookPw);	
	
	//묶어주기 ( 요청값 가공)
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setWriter(writer);
	guestbook.setGuestbookContent(guestbookContent);
	guestbook.setGuestbookPw(guestbookPw);
	
	GuestbookDao guestbookDao = new GuestbookDao();
	int row = 0;
	row = guestbookDao.updateGuestbook(guestbook);
	
	if(row == 0) { // 수정된 행이 0개라면 수정 실패
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?guestbookNo=" + guestbook.getGuestbookNo());
	} else if(row == 1) { // 수정된 행이 1개라면 수정 성공
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	} else { // 수정된 행이 여러개라면? 잘못된 것
		System.out.println("에러");
	}
%>
