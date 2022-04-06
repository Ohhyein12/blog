<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%
	BoardDao boardDao = new BoardDao();

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	//디버깅
	System.out.println(boardNo + "<--boardNo");
	System.out.println(boardPw + "<--boardPw");
	
	// vo에서 받아 온 값에 요청받아온 값 넣기
	Board board = new Board(); 
	board.setBoardNo(boardNo);
	board.setBoardPw(boardPw);
	
	//삭제하는 메서드 호출해서 삭제된 행 개수 저장
	int row = boardDao.deleteBoard(board);
	
	if(row == 0) { // 행이 0개라면 삭제 실패 
		System.out.println("삭제 실패!");
		response.sendRedirect(request.getContextPath() +"/board/deleteBoardForm.jsp?boardNo=" + boardNo);
	}else if(row == 1) { //삭제된 행이 1개라면 삭제 성공
		System.out.println("삭제 성공!");
		response.sendRedirect(request.getContextPath() + "/board/boardList.jsp");
	}else { // 삭제된 행이 여러개? 잘못된 것
			System.out.println("에러!");
	}
	
	
%>
