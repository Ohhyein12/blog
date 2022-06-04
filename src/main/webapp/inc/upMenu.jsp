<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 다른 페이지의 부분으로 사용되는 페이지-->
   <!-- 메인 메뉴 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

<style>
   .nav-wrap { display:inline-block; padding:5px 20px; box-shadow: 0 6px 20px 0 rgb(0 0 0 / 19%); }
   .logo-a { color:#000087; font-size:2em; font-weight:500;}
   .logo-a:hover { color:#000087; text-decoration:none; }
   .nav-a { color:#787878; margin:0 10px; }
</style>

</head>
<body>
   <div class="container-fluid nav-wrap">
      <a href="<%=request.getContextPath()%>/index.jsp" class="logo-a">Hyein`s Blog</a>
      
      <div style="display:inline-block; margin:15px; " class="float-right">
         <a href="<%=request.getContextPath()%>/board/boardList.jsp" class="nav-a" >게시판</a>
         <a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="nav-a" >사진</a>
         <a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" class="nav-a" >방명록</a>
         <a href="<%=request.getContextPath()%>/pdf/pdfList.jsp" class="nav-a" >PDF자료실</a>
      </div>
   </div>
   
</body>
</html>