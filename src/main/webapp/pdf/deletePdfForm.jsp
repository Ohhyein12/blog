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
	.bottom {margin-bottom:40px;}
</style>
</head>
<body>
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!-- 얘는 컨텍스명(request.getContextPath()) 불가 (프로젝트이름)을 명시하지 않는다 - include는 내부요청이라서! -->
	<!-- 메인 메뉴 끝 -->
	<div class = "container jb-wrap">
		<h2 class = "text-center bottom" >PDF 삭제</h2>
		<form method = "post" action="<%=request.getContextPath() %>/pdf/deletePdfAction.jsp">
			<table class = "table table-bordered ">
				<tr>
					<th class = "table-active">PDF 번호</th>
					<td><input type="text" name="pdfNo" value="<%=pdfNo%>" readonly="readonly" class="form-control"></td>
				</tr>
				<tr>
					<th class = "table-active">비밀번호</th>
					<td><input type="password" name="pdfPw" class="form-control"></td>
				</tr>
			</table>
			<button type="submit" class="btn btn-success float-right">삭제하기</button>
			<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp?pdfNo=<%=pdfNo%>" class= "btn btn-outline-secondary">뒤로 가기</a>
		</form>
	</div>
</body>
</html>