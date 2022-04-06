<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//요청값 받아오기
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	System.out.println("pdfNo : " + pdfNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletPdfForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 100px 10px; } /*세로 길이 조절*/
	.text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
</style>
</head>
<body>
<div class = "container-fluid jb-wrap">
<h2 class = "text-center" style = "margin-bottom:20px">삭제</h2>
<form method = "post" action="<%=request.getContextPath() %>/pdf/deletePdfAction.jsp">
	<table class = "table table-bordered ">
		<tr>
			<td class = "table-active">PDF 번호</td>
			<td><input type="text" name="pdfNo" value="<%=pdfNo%>" readonly="readonly" class="form-control"></td>
		</tr>
		<tr>
			<td class = "table-active">비밀번호</td>
			<td><input type="password" name="pdfPw" class="form-control"></td>
		</tr>
	</table>
	<button type="submit" class="btn btn-outline-info">삭제하기</button>
	<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp?pdfNo=<%=pdfNo%>" class= "btn btn-info float-right">뒤로 가기</a>
</form>
</div>
</body>
</html>