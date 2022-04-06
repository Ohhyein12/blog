<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.Board" %>
<%@ page import = "dao.*" %>
<%
	// maria db는 자동으로 들어가니까 시퀀스 필요없음

	request.setCharacterEncoding("utf-8"); //인코딩하기
	
	BoardDao boardDao = new BoardDao();

	// 작성한 값 받아오기
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");

	// 디버깅 코드
	System.out.println(categoryName+"<--categoryName");
	System.out.println(boardTitle+"<--boardTitle");
	System.out.println(boardContent+"<--boardContent");
	System.out.println(boardPw+"<--boardPw");
	
	//하나의 변수로 넘기기위해 가공
	Board board = new Board();
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	board.setBoardPw(boardPw);
	
	// 입력한 행 개수 받아오는 메서드 호출해서 row 변수에 저장
	int row = boardDao.insertBoard(board);
	
	
	// 디버깅
	if(row==1) { 
		System.out.println(row+"행 입력성공");
	} else { 
		System.out.println("입력실패");
	}
	// 입력 실패 or 성공 후 boardList.jsp로 이동
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp"); // 보여줄수 있는 페이지로 이동

%>
