<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%
	//boardNo 요청받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));	
	
	BoardDao boardDao = new BoardDao();
	
	//해당번호 넣어서 그 번호의 보드 정보 받아오기 메서드 호출해서 board에 저장
	Board board = boardDao.updateBoardOne(boardNo);
	
	//카테고리 목록 띄우기 위한 메서드 호출
	ArrayList<String> list = boardDao.insertBoardCategoryName();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 70px 10px; } /*세로 길이 조절*/
	.text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
	.bottom {margin-bottom:40px;}
</style>
</head>
<body>
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!-- 얘는 컨텍스명(request.getContextPath()) 불가 (프로젝트이름)을 명시하지 않는다 - include는 내부요청이라서! -->
	<!-- 메인 메뉴 끝 -->
	<div class = "container jb-wrap">
		<h2 class ="text-center bottom">게시글 수정</h2>
		<br>
		<form method = "post" action= "<%=request.getContextPath()%>/board/updateBoardAction.jsp">
			<table class = "table table-bordered ">
			<colgroup>
				<col width="20%">
				<col width="*">
			</colgroup>
				<tr>
					<th class = "table-active">게시글 번호</th>
					<td><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly" class="form-control"></td>
				</tr>
				<tr>
					<th class = "table-active">카테고리</th>
					<td>
						<select name="categoryName">
							<%
								for(String s : list) { 
									if(s.equals(board.getCategoryName())) {
							%>
										<option selected = "selected" value="<%=s%>"><%=s%></option>
							<%
									}else {
							%>
										<option value ="<%=s%>"><%=s%></option>
							<%
									}
								}
							%>
						
						</select>
					</td>
				</tr>
				<tr>
					<th class = "table-active">제목</th>
					<td>
						<input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>" class="form-control">
					</td>
				</tr>
				<tr>
					<th class = "table-active">내용</th>
					<td>
						<textarea rows="5" cols="50" name = "boardContent" class="form-control"><%=board.getBoardContent()%></textarea>
					</td>
				</tr>
				<tr>
					<th class = "table-active">비밀번호</th>
					<td>
						<input type="password" name="boardPw" class="form-control">
					</td>
				</tr>
			</table>
			<button type="submit" class="btn btn-info float-right">수정하기</button>
			<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo%>" class= "btn btn-secondary">뒤로 가기</a>
		</form>
	</div>
</body>
</html>