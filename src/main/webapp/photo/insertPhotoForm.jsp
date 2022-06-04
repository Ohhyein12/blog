<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPhotoForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 70px 10px; } /*세로 길이 조절*/
	.bottom {margin-bottom:40px;}
</style>
</head>
<body>
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!-- 얘는 컨텍스명(request.getContextPath()) 불가 (프로젝트이름)을 명시하지 않는다 - include는 내부요청이라서! -->
	<!-- 메인 메뉴 끝 -->
	<div class = "container jb-wrap">
		<h2 class = "text-center bottom">이미지 등록</h2>
		<br>
		<!-- 
			1) form태그안에 값을 넘기는 기본값(enctype)은 무조건 문자열.  
			2) 그래서 파일을 넘길수 없음. 기본값(application/x-www-form-urlencoded)(디폴트값)을 변경해야 한다
			3) 기본값을 "multipart/form-data"로 변경하면 기본값이 문자열에서 바이너리(이진수)로 변경된다
			4) 같은 폼안에 모든 값이 바이너리로 넘어간다. 그래서 글자를 넘겨받는 request.getParameter();을 사용할수가 없다
			5) 복잡한 코드를 통해서만 바이너리의 내용을 넘겨받을 수 있다
			6) 그래서 조금이라도 편하려고 외부 라이브러리(cos.jar)를 사용해서 복잡한 코드를 간단하게 구현하자
		-->
		<form action="<%=request.getContextPath()%>/photo/insertPhotoAction.jsp" method="post" enctype="multipart/form-data"><!-- 파일 올릴때 무조건 post로 올려야함 get불가능 -->
			<table class ="table table-bordered">
				<colgroup>
					<col width = "20%">
					<col width = "*">
				</colgroup>
				<tr>
					<th class = "table-active">이미지파일</th>
					<td><input type="file" name="photo" ></td>
				</tr>
				<tr>
					<th class = "table-active">글쓴이</th>
					<td><input type = "text" name = "writer" class = "form-control"></td>
				</tr>
				<tr>
					<th class = "table-active">비밀번호</th>
					<td><input type="password" name="photoPw" class = "form-control"></td>
				</tr>
			</table>
			<button type = "submit" class="btn btn-info float-right">이미지등록</button>
			<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class= "btn btn-secondary">뒤로 가기</a>		
		</form>
	</div>
</body>
</html>