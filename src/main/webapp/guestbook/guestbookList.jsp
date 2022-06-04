<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%
	int currentPage = 1; //현재페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+"<--currentPage"); // 디버깅
	
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	
	GuestbookDao guestbookDao = new GuestbookDao();
	// 담고싶은 행 개수만큼 담는 메서드 호출해서 Guestbook Arraylist에 저장
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow,rowPerPage);
	
	
	// 다음페이징 위함
	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); // math.ceil사용해서 무조건 올림하기 
	// 4.0 / 2.0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0으로 올리기
/* 	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0){
		lastPage++;
	} 얘도 가능*/
	
	int beginPage=1; //페이지 목록의 첫 번호
	if(request.getParameter("beginPage")!=null) {
		beginPage = Integer.parseInt(request.getParameter("beginPage"));
		currentPage = beginPage; // 다음, 이전 버튼 눌러서 들어왔으면 현재 페이지 가장 작은수로 보여주기
	} else { // 이전, 다음 클릭해서 넘어온거 아니라면
		beginPage = (currentPage-1)/10*10+1; // 현재페이지 13이라면 beginPage는 11만들어주기
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestbookList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 60px 10px; } /*세로 길이 조절*/
	.text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
	.up {
		margin-top:20px;
	}
	.pagination-center {
		justify-content: center;
	}
</style>
</head>
<body>
<div class ="container-fluid">
	
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!-- 얘는 컨텍스명(request.getContextPath()) 불가 (프로젝트이름)을 명시하지 않는다 - include는 내부요청이라서! -->
	<!-- 메인 메뉴 끝 -->
	<br>
	<br>
	<h2 class = " text-center">방명록</h2>
	<br>
	<!-- 방명록 입력 -->
	<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
	<button type = "submit" class="btn btn-primary float-right" style= "margin-bottom:10px">방명록 등록</button>
	<table class = "table table-bordered">
		<tr>
			<td>글쓴이</td>
			<td><input type = "text" name="writer" class="form-control"></td>
			<td>비밀번호</td>
			<td><input type = "password" name="guestbookPw" class="form-control"></td>	
		</tr>
		<tr>
			<td colspan="4">
			<textarea name = "guestbookContent" rows="2" cols="70" class="form-control"></textarea>
			</td>
		</tr>
	</table>
	
	</form>
	
	<div class="jb-wrap">
	<!-- 방명록 리스트 출력 -->
	<br>
<%
	for(Guestbook g : list) {
%>
		<table class = "table table-bordered">
			<tr class="table-active">
				<td><%=g.getWriter()%></td>
				<td><%=g.getCreateDate()%></td>
			</tr>
			<tr>
				<td colspan="2"><%=g.getGuestbookContent()%>
				<span class = "btn-group float-right">
				<a href = "<%=request.getContextPath() %>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>" class="btn btn-primary btn-info ">수정</a>
				<a href = "<%=request.getContextPath() %>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>" class="btn btn-primary btn-info ">삭제</a>
				</span>
				</td>
			</tr>
		</table>
	<%
		}
	%>
	<div class="up">
		<ul class="pagination pagination-center">
		<%
			if(beginPage > 10){ // 이전버튼 페이징 첫 숫자가 11이상일때부터 출력 
		%>
				<li class="page-item">
					<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?beginPage=<%=beginPage-10%>" class="page-link">이전</a>
				</li>
		<%
			}
			//목록 사이 숫자 출력
			for(int i=beginPage; i<beginPage+10; i+=1) {
				if(i<=lastPage) { // 총 페이지 수 10 미만일땐?
		%>
					<li class="page-item">
						<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
					</li>
		<%
				}
			}
		
			if(lastPage - beginPage > 10) {
		%>	
				<li class="page-item">
					<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?beginPage=<%=beginPage+10%>" class="page-link">다음</a>
				</li>
		<%
			}
		%>
		</ul>
	</div>
	
	</div>
</div>
</body>
</html>