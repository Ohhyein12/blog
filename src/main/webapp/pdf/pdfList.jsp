<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//이전 페이지 구현
	int beginRow = 0;
	int rowPerPage = 10; //  한 페이지에 내가 보고싶은 행 개수
	int currentPage = 1; // 현재페이지
	
	if((request.getParameter("currentPage")) != null)  {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	beginRow = (currentPage-1)*rowPerPage; 
	
	PdfDao pdfDao = new PdfDao();
	ArrayList<Pdf> list = pdfDao.selectPdfListByPage(beginRow,rowPerPage);
	
	//다음 페이지 구현
	int lastPage = 0;
	
	int total = pdfDao.selectPhotoTotalRow();
	lastPage = total/ rowPerPage;
	if(total % rowPerPage != 0) {
		lastPage++;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pdfList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 시작 -->
	<jsp:include page ="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텐츠명(프로젝트이름)을 명시하지 않는다 -->
	<!-- 메인 메뉴 끝 -->
	<br>
	<br>
	<h2 class="inline text-center" style = "margin-bottom:70px">PDF 자료실</h2>
	<div class ="container">
		<a href="<%=request.getContextPath()%>/pdf/insertPdfForm.jsp" class="btn btn-primary float-right" style = "margin-bottom:10px">PDF 등록</a>	
		<table class = "table table-bordered">
			<tr class="table-active">
				<td>PDF 자료명</td>
				<td>작성자</td>
				<td>작성날짜</td>
			</tr>
			<%
				for(Pdf p : list) {
			%>
				<tr>
					<td>
						<a href="<%=request.getContextPath()%>/uploadPdf/<%=p.getPdfName()%>"><%=p.getPdfName()%></a>
					</td>
					<td><%=p.getWriter()%></td>
					<td><%=p.getCreateDate()%>
						<a href="<%=request.getContextPath()%>/pdf/deletePdfForm.jsp?pdfNo=<%=p.getPdfNo()%>" class="btn btn-secondary float-right">삭제</a>
					</td>
				</tr>
			<%
				}
			%>
		</table>
		
		<ul class="pagination">
		<%
			if(currentPage > 1){
		%>
				<li class="page-item"><a href = "<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>	
		<%
			}
				
			if(currentPage < lastPage) {
		%>
				<li class="page-item"><a href = "<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
		<%
			}
		%>	
		</ul>
	</div>
</body>
</html>