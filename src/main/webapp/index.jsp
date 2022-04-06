<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 100px 10px; } /*세로 길이 조절*/
	.text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
</style>
</head>
<body> 
<div class = "container jb-wrap">
<h2 class="text-center" style="margin-bottom:20px">Home</h2>
<ul class="list-group list-group-flush">
	<li class="list-group-item"><a href = "<%=request.getContextPath()%>/board/boardList.jsp">게시판</a></li>
	<li class="list-group-item"><a href = "<%=request.getContextPath()%>/photo/photoList.jsp">사진</a></li>
	<li class="list-group-item"><a href = "<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a></li>
	<li class="list-group-item"><a href = "<%=request.getContextPath()%>/pdf/pdfList.jsp">PDF 자료실</a></li>
</ul>
</div>
</body>
</html>