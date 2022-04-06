<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	BoardDao boardDao = new BoardDao();

	request.setCharacterEncoding("utf-8");// 인코딩하기 한글안깨지게
	
	// 요청값 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	
	//디버깅 코드
	System.out.println(boardNo);
	System.out.println(categoryName);
	System.out.println(boardTitle);
	System.out.println(boardContent);
	System.out.println(boardPw);
	
	// 묶어주기 (요청값 가공)
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	board.setBoardPw(boardPw);
	
	int row = boardDao.updateBoard(board);
	
	if(row == 0) { // 수정된 행이 0개라면 삭제 실패
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp?boardNo=" + board.getBoardNo());
	} else if(row == 1) { // 수정된 행이 1개라면 삭제 성공
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	} else { // 수정된 행이 여러개라면? 잘못된 것
		System.out.println("에러");
	}

%>
