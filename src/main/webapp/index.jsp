<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
   
   int beginRow = 0;
   //한 페이지에 볼 행 개수 
   int boardRowPerPage = 7;
   int guestBookRowPerPage = 7;
   // selectBoardListByPage메서드 쓰기 위한 매개변수 값 선언
   String categoryName = "";
   
   BoardDao boardDao = new BoardDao();
   GuestbookDao guestbookDao = new GuestbookDao();
   
   ArrayList<Board> boardList = boardDao.selectBoardListByPage(beginRow, boardRowPerPage, categoryName);

   ArrayList<Guestbook> guestBookList = guestbookDao.selectGuestbookListByPage(beginRow,guestBookRowPerPage);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<style>
   .jb-wrap { padding: 100px 10px; } /*세로 길이 조절*/
   .text-center {float:none; margin:0 auto;} /* 가운데 정렬 */
   .left { width:49%; 
   		border:1px solid #ccc; 
   		border-radius:5px; 
   		float:left; 
   		padding:25px;
   	}
   .right { width:49%;
   		border:1px solid #ccc; 
   		border-radius:5px; 
   		float:right; 
   		padding:25px;
   	}
</style>
</head>
<body> 
   <!-- 메인 메뉴 시작 -->
   <jsp:include page ="/inc/upMenu.jsp"></jsp:include>
   <!-- include시 컨텐츠명(프로젝트이름)을 명시하지 않는다 -->
   <!-- 메인 메뉴 끝 -->
   <div class="container" style="margin-top:150px;">
      <div class="left">
         <h3>최근 게시물</h3>
         <a href="<%=request.getContextPath()%>/board/boardList.jsp" class="float-right">더보기</a>
         <table class = "table">
            <%
               for(Board b : boardList) {
            %>
            <tr>
               <td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
               <td><%=b.getCreateDate()%></td>
            </tr>
            <%
               }
            %>
         </table>
      </div>
      
      <div class="right">
         <h3>최근 방명록</h3>
         <a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" class="float-right">더보기</a>
         <table class="table">
            <%
               for(Guestbook g : guestBookList) {
            %>
            <tr>
               <td><%=g.getWriter()%></td>
               <td><%=g.getGuestbookContent()%></td>
               <td><%=g.getCreateDate()%></td>
            </tr>
            <%
               }
            %>
         </table>
      </div>
   </div>
   
</body>
</html>