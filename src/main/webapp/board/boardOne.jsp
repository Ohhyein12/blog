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
	.jb-wrap { padding: 150px 10px; } /*세로 가운데 정렬*/
	.text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
	.up {margin-top:100px;}
	.bottom { margin-bottom:20px;}
</style>
</head>
<body>
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!-- 얘는 컨텍스명(request.getContextPath()) 불가 (프로젝트이름)을 명시하지 않는다 - include는 내부요청이라서! -->
	<!-- 메인 메뉴 끝 -->
	<div class = "container">
		<div class="row">
			<div class="col-md-2 jb-wrap">
				<!-- category별 게시글 링크 메뉴 -->
				<ul class="list-group">
					<%
						for(HashMap<String, Object> m : categoryList) { 
					%>
							<li class = "list-group-item list-group-item-action list-group-item-secondary">
								<a href = "<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>">
									<%=m.get("categoryName")%>
									<span class="badge badge-primary badge-pill">(<%=m.get("cnt")%>)</span>
								</a> 
								<!-- blog들고오기 저렇게 해두면 나중에  content명 바껴도 바꿔줄 필요 없음 -->
							</li>
					<%	
						}
					%>
				</ul>
			</div>
			<div class="col-md-10 up">
				<br>
				<h2 class = "text-center bottom">게시글 상세 정보</h2>
				<br>
				<table class = "table table-bordered">
				<colgroup>
					<col width = "20%">
					<col width = "*">
				</colgroup>
					<tr>
						<th class = "table-active">게시글 번호</th>
						<td><%= board.getBoardNo()%></td>
					</tr>
					<tr>
						<th class = "table-active">카테고리</th>
						<td><%= board.getCategoryName()%></td>
					</tr>
					<tr>
						<th class = "table-active">제목</th>
						<td><%= board.getBoardTitle()%></td>
					</tr>
					<tr>
						<th class = "table-active">내용</th>
						<td><%= board.getBoardContent()%></td>
					</tr>
					<tr>
						<th class = "table-active">작성일</th>
						<td><%= board.getCreateDate()%></td>
					</tr>
					<tr>
						<th class = "table-active">마지막 수정일</th>
						<td><%= board.getUpdateDate()%></td>
					</tr>
				</table>
				<div>
					<span class="float-right">
						<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-info">수정하기</a>
						<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=board.getBoardNo()%>" class="btn btn-info">삭제하기</a>
					</span>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp " class= "btn btn-secondary">뒤로 가기</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>