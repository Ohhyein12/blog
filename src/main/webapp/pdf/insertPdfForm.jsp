<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPdfForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 70px 10px; } /*세로 길이 조절*/
</style>
</head>
<body>
	<div class = "container-fluid jb-wrap">
		<h2 class = "text-center" style = "margin-bottom:20px">PDF 등록</h2>
		<form method="post" action = "<%=request.getContextPath() %>/pdf/insertPdfAction.jsp"  enctype="multipart/form-data">
			<table class ="table table-bordered">
				<colgroup>
					<col width = "20%">
					<col width = "*">
				</colgroup>
				<tr>
					<th class = "table-active">pdf</th>
					<td><input type="file" name="pdf"></td>
				</tr>
				<tr>
					<th class = "table-active">작성자</th>
					<td><input type="text" name="writer" class = "form-control"></td>
				</tr>
				<tr>
					<th class = "table-active">비밀번호</th>
					<td><input type="password" name="pdfPw" class= "form-control"></td>
				</tr>
			</table>
			<button type = "submit" class="btn btn-secondary">PDF 등록</button>
			<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class= "btn btn-info float-right">뒤로 가기</a>	
		</form>
	</div>
</body>
</html>