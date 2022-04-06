<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//요청값 받아오기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	System.out.println("photoNo(selectPhotoOne) : " + photoNo);
	
	PhotoDao photoDao = new PhotoDao();
	Photo photo = new Photo();
	photo = photoDao.selectPhotoOne(photoNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectPhotoOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 100px 10px; } /*세로 가운데 정렬*/
	.text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
</style>
</head>
<body>
<div class = "container-fluid">
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!-- 얘는 컨텍스명(request.getContextPath()) 불가 (프로젝트이름)을 명시하지 않는다 - include는 내부요청이라서! -->
	<!-- 메인 메뉴 끝 -->
	
	<br>
	<br>
	<h2 class = "text-center">Photo 상세보기</h2>
	<div class="row jb-wrap">
		<div class="col-md-5">
			<img src="<%=request.getContextPath()%>/upload/<%=photo.getPhotoName()%>" width="500" height="500">
		</div>
		<div class="col-md-7 ">	
			<table class = "table table-bordered">
				<colgroup>
					<col width="20%">
					<col width="*">
				</colgroup>
				<tr>
					<th class = "table-active">사진 번호</th>
					<td><%=photo.getPhotoNo()%></td>
				</tr>
				<tr>
					<th class = "table-active">사진 이름</th>
					<td><%=photo.getPhotoName()%></td>
				</tr>
				<tr>
					<th class = "table-active">작성자</th>
					<td><%=photo.getWriter()%></td>
				</tr>
				<tr>
					<th class = "table-active">작성 날짜</th>
					<td><%=photo.getCreateDate()%></td>
				</tr>
			</table>
			
			<a href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photo.getPhotoNo()%>" class="btn btn-outline-info">삭제</a>
			<a href="<%=request.getContextPath()%>/photo/photoList.jsp " class= "btn btn-info float-right">뒤로 가기</a>
			
		</div>
	</div>
</div>
</body>
</html>