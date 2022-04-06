<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 다른 페이지의 부분으로 사용되는 페이지-->
	<!-- 메인 메뉴 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="list-group list-group-horizontal">
		<a href="<%=request.getContextPath()%>/index.jsp" class="list-group-item list-group-item list-group-item-action list-group-item-info">홈으로</a>
		<a href="<%=request.getContextPath()%>/board/boardList.jsp" class="list-group-item list-group-item list-group-item-action list-group-item-info">게시판</a>
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="list-group-item list-group-item list-group-item-action list-group-item-info">사진</a>
		<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" class="list-group-item list-group-item list-group-item-action list-group-item-info">방명록</a>
		<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp" class="list-group-item list-group-item list-group-item-action list-group-item-info">PDF자료실</a>
	</div>
</body>
</html>