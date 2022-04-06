<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.GuestbookDao" %>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	
	// guestbookOne
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = new Guestbook();
	// GuestbookOne출력하는 method호출해서 guestbook에 저장
	guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
	.jb-wrap { padding: 100px 10px; } /*세로 길이 조절*/
	.text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
</style>
</head>
<body>
<div class = "container-fluid jb-wrap">
	<form method = "post" action= "updateGuestbookAction.jsp">
	<h2 class ="text-center" style="margin-bottom:20px">수정</h2>
	<table class = "table table-bordered">
		<tr>
			<td class = "table-active">방명록 번호</td>
			<td><input type="text" name="guestbookNo" value="<%=guestbook.getGuestbookNo()%>" readonly="readonly" class="form-control"></td>
		</tr>
		<tr>
			<td class = "table-active">작성자</td>
			<td><input type="text" name="writer" value="<%=guestbook.getWriter()%>" class="form-control"></td>
		</tr>
		<tr>
			<td class = "table-active">내용</td>
			<td><textarea rows="5" cols="50" name = "guestbookContent" class="form-control"><%=guestbook.getGuestbookContent()%></textarea></td>
		</tr>
		<tr>
			<td class = "table-active">비밀번호</td>
			<td><input type = "password" name = "guestbookPw" class = "form-control"></td>
		</tr>
	</table>
	<button type="submit" class = "btn btn-outline-info">수정하기</button>
	<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" class="btn btn-info float-right" >뒤로 가기</a>
</form>
</div>
</body>
</html>