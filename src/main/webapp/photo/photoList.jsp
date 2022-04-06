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

	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
	
	// 다음 페이지 구현
	int lastPage = 0;
	
	// 총개수        마지막 페이지
	// 0, -10           1
	// 11, - 20         2
	
	int total = photoDao.selectPhotoTotalRow();
	lastPage = total/ rowPerPage;
	if(total % rowPerPage != 0) {
		lastPage++;
	}
	
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 시작 -->
	<jsp:include page ="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텐츠명(프로젝트이름)을 명시하지 않는다 -->
	<!-- 메인 메뉴 끝 -->
	
	<br>
	<br>
	<h2 class="inline text-center" >이미지 목록</h2>
	<div style = "margin-bottom:120px">
		<a href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp" class="btn btn-primary float-right">이미지 등록</a>
	</div>
	<div class = "container">
	<table class = "table-bordered">
		<tr>
	<%
		// 한행에 5개의 이미지 출력(tr안에 td가 5개)
		// 이미지가 3개 - tr 1에 td 5개
		// 이미지가 5개 - tr 1에 td 5개
		// 이미지가 10개 - tr 2에 td 10개
		// 이미지가 9개 -  tr 2에 td 10개
		
		// td의 개수가 5의 배수가 되도록 하려면
		// list.size()가 1~5 - td는 5개
		// list.size()가 6~10 - td는 10개
		System.out.println(list.size() + "<--list.size()");
		
		int endIdx = (((list.size()-1)/5)+1)*5; // 5의 배수가 되야함(한 줄에 5개씩 보기로 했으니까)
		System.out.println(endIdx + "<--지금은 아마 10");
		
		// for(Photo p : list) {  // size()만큼 반복되므로 5의배수가 아닌경우도 생긴다. 그래서 무조건 5의 배수로 만들어주기
		for(int i=0; i<endIdx; i++) { //01234, 0123456789
			// tr을 닫고 새로운 tr 시작
			if(i!=0 && i%5==0) { // 0을 제외한 5의 배수일때
	%>
				</tr><tr>
	<%
			}
			if(i<list.size()) {
	%>
				<td> <!-- 클릭하면 원본 이미지 크기로 보이게 -->
					<a href="<%=request.getContextPath()%>/photo/selectPhotoOne.jsp?photoNo=<%=list.get(i).getPhotoNo()%>">
						<img src="<%=request.getContextPath()%>/upload/<%=list.get(i).getPhotoName()%>" width="200" height="200">
					</a>
				</td>
	<%
			} else { // 리스트 사이즈가 같다면
	%>
				<td>&nbsp;</td>
	<%
			} 
		}
		
	%>
		</tr>
	</table>
	</div>
<%-- <ul class="pagination">
	<%
		if(currentPage > 1){
	%>
			<li class="page-item"><a href = "<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>	
	<%
		}
			
		if(currentPage < lastPage) {
	%>
			<li class="page-item"><a href = "<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
	<%
		}
	%>	
	</ul> --%>
</body>
</html>