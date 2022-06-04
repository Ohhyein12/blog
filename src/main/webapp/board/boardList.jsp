<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%	
	BoardDao boardDao = new BoardDao();
	CategoryDao categoryDao = new CategoryDao();

	int currentPage = 1; // 현재페이지의 기본값이 1페이지
	if(request.getParameter("currentPage") != null) { // 값이 들어왔단건 이전, 다음 링크를 통해서 들어온 것 들어왔다면 
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // currentPage에 요청받은 currentPage 넣기
	}
	System.out.println(currentPage+"<--currentPage"); // 디버깅
	// 페이지만 바뀌면 끝이 아니고 실제로 가지고 오는 데이터가 변경되어야 한다.
	
	//밑에서 categoryName추가해서 
	String categoryName = ""; 
	if(request.getParameter("categoryName") != null) { 
		categoryName = request.getParameter("categoryName"); // 클릭한 categoryName값 받아와서 저장
	}
	
	System.out.println(categoryName + "<--categoryName"); // 확인 디버깅
	
	int rowPerPage = 10; // 한 페이지에 내가 보고싶은 행의 개수
	if(request.getParameter("rowPerPage") != null) { // 5개, 10개 골라서 출력하기 위함
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		
	}


	/*
	알고리즘 
	select ... LIMIT ?,10
	
	currentPage       beginRow(시작 번호)
	1페이지일때 ->        0
	2페이지일때 ->        10
	3페이지일때 ->        20
	4페이지일때 ->        30
	9페이지일때 -> 	    80
	
	?  = (currentPage-1)*10
*/
	
	
	int beginRow = (currentPage-1)*rowPerPage; // 시작하는 페이지의 숫자 현재페이지가 변경되면 beginRow가 변경된다 -> 가져오는 데이터 변경됨
	System.out.println(beginRow + "<--beginRow");
	
	// 카테고리 이름과 목차별 개수 구해서 ArrayList categoryList에 저장
	ArrayList<HashMap<String,Object>> categoryList = categoryDao.categoryCnt();

	//출력(boardList 10행씩 반환하는 메서드)호출해서 boardList에 저장 
	ArrayList<Board> boardList = boardDao.selectBoardListByPage(beginRow,rowPerPage,categoryName); 

	int totalRow = 0;
	
	// 총 개수 구하는 메서드 호출해서 저장할건데 categoryName선택했으면 그 카테고리의 게시글 수 만큼 받아오기
	totalRow = boardDao.selectBoardListTotalRow(categoryName);
	System.out.println(totalRow+"<--totalRow");
	//다음버튼 페이징 위함
	int lastPage = 0; // 마지막 페이지
	if(totalRow % rowPerPage == 0) {
		lastPage = totalRow / rowPerPage; 
	} else {
		lastPage = (totalRow / rowPerPage) + 1;  // ex) 11,12,13 등등은 rowPerPage로 나눠도 딱 나눠떨어지지않으니 + 1 해줘야함 11/10 = 1 but 11~19 행의 마지막 페이지는 2어야 하니 + 1 해준거
	}
	
	/*
			  마지막 페이지는?
			  전체행				마지막 페이지?
			  10개 					1
			  11,12,13~ 20   		2
			  21 ~ 30				3
			  31 ~ 40				4
			  
			  마지막 페이지 = 전체행 / rowPerPage(한 페이지에 내가 보고싶은 행 개수)
	*/
	
	int beginPage=1; // 페이지목록의 첫 페이지
	if(request.getParameter("beginPage")!=null) { 
		beginPage = Integer.parseInt(request.getParameter("beginPage"));
		currentPage=beginPage; // 다음, 이전 버튼 눌렀을때 현재 페이지를 가장 작은 수로 보여주기
	} else { // 이전, 다음 말고 그냥 숫자 클릭해서 넘어왔을때		
		beginPage = (currentPage-1)/10*10+1;  // 현재페이지 13이라면 beginPage는 11만들어주기
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
	.jb-wrap { padding: 150px 10px; } /*세로 길이 조절*/
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
	<!-- 메인 메뉴 시작 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include> <!-- 얘는 컨텍스명(request.getContextPath()) 불가 (프로젝트이름)을 명시하지 않는다 - include는 내부요청이라서! -->
	<!-- 메인 메뉴 끝 -->
	<div class = "container">	
		<div class="row">
			<div class="col-md-2 jb-wrap">
				<!-- category별 게시글 링크 메뉴 -->
					<ul class="list-group">
						<%
							for(HashMap<String, Object> m : categoryList) { 
						%>
								<li class = "list-group-item list-group-item-action list-group-item-secondary">
										<a href = "<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" >
										<%=m.get("categoryName")%>
										<span class="badge badge-primary badge-pill">(<%=m.get("cnt") %>)</span>
										</a> 
										<!-- blog들고오기 저렇게 해두면 나중에  content명 바껴도 바꿔줄 필요 없음 -->
								</li>
						<%	
							}
						%>
					</ul>
					<br>
					<div>
					<% 
						if(!categoryName.equals("")) {
					%>
							<a href = "<%=request.getContextPath()%>/board/boardList.jsp" class="btn btn-outline-success">전체 목록 보기 출력</a>
					<%
						}
					%>
					</div>
			</div>
			<div class="col-md-10">
				<!--  게시글 리스트 -->
				<br>
				<br>
				<h2 class = "inline text-center">게시글 목록(total : <%=totalRow%>)</h2>
				<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp" class="btn btn-primary float-right">게시글 입력</a>
				<br>
				<!-- rowPerPage -->
	         	<div class="dropdown">
	            	 <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">
	              	   몇 행씩
	             	 </button>
		             <div class="dropdown-menu">
		               <a class="dropdown-item" href="<%=request.getContextPath()%>/board/boardList.jsp?rowPerPage=5&categoryName=<%=categoryName%>"> 5 </a>
		               <a class="dropdown-item" href="<%=request.getContextPath()%>/board/boardList.jsp?rowPerPage=10&categoryName=<%=categoryName%>"> 10 </a>
		               <a class="dropdown-item" href="<%=request.getContextPath()%>/board/boardList.jsp?rowPerPage=15&categoryName=<%=categoryName%>"> 15 </a>
		               <a class="dropdown-item" href="<%=request.getContextPath()%>/board/boardList.jsp?rowPerPage=20&categoryName=<%=categoryName%>"> 20 </a>
		            </div>
	           </div>
	  	
				<table class = "table table-bordered ">
					<colgroup>
						<col width="20%">
						<col width="55%">
						<col width="*">
					</colgroup>
					<thead class = "table-active">
						<tr>
							<th>categoryName</th>
							<th>boardTitle</th>
							<th>createDate</th>
						</tr>
					</thead>
					<tbody>
						 <%
						 	for(Board b : boardList) { 
						 %>
						 <tr>
						 		<td><%=b.getCategoryName() %></td>
						 		<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
								<td><%=b.getCreateDate()%></td>
						 </tr>
						 <%	
						 	}
						 %>
					</tbody>	
				</table>
			
				<div class="up">
					<ul class="pagination pagination-center">
						
						<%
							if(beginPage > 10)	 { // 페이지가 1보다 작을때 이전페이지가 존재해선 안되고 페이징 첫 숫자가 11이상일때부터 이전 글자가 출력되야함
						%>
								 <li class="page-item">
								 	<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=categoryName%>&rowPerPage=<%=rowPerPage%>&beginPage=<%=beginPage-10%>">
								 		이전
								 	</a>
								 </li>
						<%
							}
							
							// 목록 사이 숫자 출력
							for(int i=beginPage; i<beginPage+10; i+=1) {
								if(i<=lastPage) { // 총 페이지수가 10개도 안될 수 있으니까 
						%>
									<li class="page-item">
									 	<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=categoryName%>&rowPerPage=<%=rowPerPage%>&currentPage=<%=i%>">
									 		<%=i%>
									 	</a>
									</li>
						<%
								}
							}
							
							if(lastPage - beginPage > 10) { // 마지막페이지에서 시작페이지를 뺀 숫자가 10보다 크다면 다음이 존재해야함
						%>
							  <li class="page-item">
							  	<a class="page-link" href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=categoryName%>&rowPerPage=<%=rowPerPage%>&beginPage=<%=beginPage+10%>">
							 		 다음
							  	</a>
				 			  </li>
						<%
							}
						%>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>