<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="dao.*"%>
<%@ page import ="java.util.*" %>
<%
	BoardDao boardDao = new BoardDao();
	
	// categoryName목록 받아오는 메서드 호출해서 arrayList에 저장
	ArrayList<String> list = boardDao.insertBoardCategoryName();

 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm</title>
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
		<h2 class="text-center bottom">게시글 입력</h2>
		<br>
		<form method="post" action="<%=request.getContextPath()%>/board/insertBoardAction.jsp">
			<table class = "table table-bordered "> <!--  boardNo는 자동으로 들어갈거라 입력안함 -->
				<tr>
					<th class = "table-active">카테고리</th>
					<td>
						<select name = "categoryName" class = "form-select">
							<%
								for(String s : list) {
							%>
									<option value="<%=s%>"><%=s%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th class = "table-active">제목</th>
					<td>
						<input type = "text" name = "boardTitle" class = "form-control">
					</td>
				</tr>
				<tr>
					<th class = "table-active">내용</th>
					<td>
						<textarea name= "boardContent" rows="5" cols="80" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<th class = "table-active">비밀번호</th>
					<td>
						<input name = "boardPw" type= "password" class = "form-control">
					</td>
				</tr>
			</table>
			<button type= "submit" class="btn btn-info float-right">게시글 입력</button>
			<a href="<%=request.getContextPath()%>/board/boardList.jsp " class= "btn btn-secondary">뒤로 가기</a>		
		</form>
	</div>
</body>
</html>