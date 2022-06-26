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
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
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
			<table class = "table"> <!--  boardNo는 자동으로 들어갈거라 입력안함 -->
				<colgroup>
					<col width="20%">
					<col width="*">
				</colgroup>
				<tr>
					<th>카테고리</th>
					<td>
						<select name = "categoryName" class = "custom-select">
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
					<th>제목</th>
					<td>
						<input type = "text" name = "boardTitle" class = "form-control">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="summernote" name="boardContent"></textarea>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input name = "boardPw" type= "password" class = "form-control">
					</td>
				</tr>
			</table>
			<button type= "submit" class="btn btn-success float-right">게시글 입력</button>
			<a href="<%=request.getContextPath()%>/board/boardList.jsp " class= "btn btn-outline-secondary">뒤로 가기</a>		
		</form>
	</div>
</body>
<script>
	$('#summernote').summernote({
	  tabsize: 2,
	  height: 400
	});
	$(".note-editor button[aria-label='Picture']").hide();
	$(".note-editor button[aria-label='Video']").hide();
</script>
</html>