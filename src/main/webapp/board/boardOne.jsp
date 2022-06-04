<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	BoardDao boardDao = new BoardDao();
	CategoryDao categoryDao = new CategoryDao();

	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // boardNo값 받아오기

	System.out.println(boardNo + "<--boardNo"); //디버깅

	//목록 받아오기 -------------------------------------------------------------------------
	ArrayList<HashMap<String,Object>> categoryList = categoryDao.categoryCnt();
	
	//boardOne 호출하는 메서드 호출해서 board에 저장----------------------------------------------
	Board board = boardDao.boardOne(boardNo);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 100px 10px; } /*세로 가운데 정렬*/
	.text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
</style>
</head>
<body>
<div class = "container-fluid">
	<div class="row">
		<div class="col-md-2 jb-wrap">
			<!-- category별 게시글 링크 메뉴 -->
				<ul class="list-group">
					<%
						for(HashMap<String, Object> m : categoryList) { 
					%>
					<li class = "list-group-item list-group-item-action list-group-item-secondary">
							<a href = "<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" >
							<%=m.get("categoryName")%>
							<span class="badge badge-primary badge-pill">(<%=m.get("cnt") %>)</span>
							</a> 
							<!-- blog들고오기 저렇게 해두면 나중에  content명 바껴도 바꿔줄 필요 없음 -->
					</li>
					<%	
						}
					%>
				</ul>
		</div>
		<div class="col-md-10 jb-wrap">
			<br>
			<h2 class = "text-center">상세 정보</h2>
			<br>
			<table class = "table table-bordered">
				<tr>
					<td class = "table-active">게시글 번호</td>
					<td><%= board.getBoardNo()%></td>
				</tr>
				<tr>
					<td class = "table-active">카테고리</td>
					<td><%= board.getCategoryName()%></td>
				</tr>
				<tr>
					<td class = "table-active">제목</td>
					<td><%= board.getBoardTitle()%></td>
				</tr>
				<tr>
					<td class = "table-active">내용</td>
					<td><%= board.getBoardContent()%></td>
				</tr>
				<tr>
					<td class = "table-active">작성일</td>
					<td><%= board.getCreateDate()%></td>
				</tr>
				<tr>
					<td class = "table-active">마지막 수정일</td>
					<td><%= board.getUpdateDate()%></td>
				</tr>
			</table>
			<div>
			<span class="float-right">
				<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-outline-info">수정하기</a>
				<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-outline-info">삭제하기</a>
			</span>
			
				
				<a href="<%=request.getContextPath()%>/board/boardList.jsp " class= "btn btn-info">뒤로 가기</a>
			</div>
		</div>
	</div>
</div>
</body>
</html>