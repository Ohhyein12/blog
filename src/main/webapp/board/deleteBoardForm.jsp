<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 100px 10px; } /*세로 길이 조절*/
	.text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
</style>
</head>
<body>
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!-- 얘는 컨텍스명(request.getContextPath()) 불가 (프로젝트이름)을 명시하지 않는다 - include는 내부요청이라서! -->
	<!-- 메인 메뉴 끝 -->
	<div class = "container-fluid jb-wrap">
		<h2 class="text-center">삭제</h2>
		<br>
		<form method="post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp"> 
			<table class = "table table-bordered ">
				<tr>
					<td class = "table-active">boardNo</td>
					<td><input type = "text" name="boardNo" value="<%=boardNo%>" readonly="readonly" class="form-control"> <!-- 넘기는 방법 3 읽기전용으로 넘기는거 --></td>
				</tr>
				<tr>
					<td class = "table-active">boardPw</td>
					<td><input type = "password" name = "boardPw" class="form-control"></td>
				</tr>
			</table>
			<button type = "submit" class="btn btn-outline-info">삭제하기</button>
			<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo%>" class= "btn btn-info float-right">뒤로 가기</a>
		</form>
	</div>
</body>
</html>