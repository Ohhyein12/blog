<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.io.*" %>
<%	
	//1) 테이블 데이터 삭제 <-- photoNo 필요
	//2) upload폴더에 이미지 삭제 <-- photoName 
	//요청값 받아오기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	//디버깅
	System.out.println("photoNo(deletePhotoAction) :" + photoNo);
	System.out.println("photoPw(deletePhotoAction) :" + photoPw);
	
	PhotoDao photoDao = new PhotoDao();

	String photoName = photoDao.selectPhotoName(photoNo);
	
	//1) 테이블 데이터 삭제
	//받아올 삭제된 행 개수 저장하는 변수 선언
	int row = 0;
	//이미지삭제하고 삭제된 행 개수 받아오는 메서드 실행해서 row에 개수 저장
	row = photoDao.deletePhoto(photoNo,photoPw);
	
	if(row  == 0) { // 삭제 실패
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp?photoNo=" + photoNo);
	} else if (row == 1) { // 삭제 성공
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
	}else { // 수정된 행이 여러개라면? 잘못된 것
		System.out.println("에러");
	}
	
	//2) 폴더 이미지 삭제
	if(row == 1) {
		String path = application.getRealPath("upload");
		File file = new File(path+"\\"+photoName);
		if(file.exists()){
			file.delete();
		}
		
		System.out.println("폴더 이미지 삭제 성공");
	} else {
		System.out.println("폴더 이미지 삭제 실패!");
	}

%>
