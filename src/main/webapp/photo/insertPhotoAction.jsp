<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 이름 중복 불가 -->
<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.io.File" %>
<%
	//insertPhotoAciton.jsp
	
	// form태그의 enctype="multipart/form-data"로 넘겨줘서 request.getParameter() API를 사용할 수 없다.
	// getParameter() API 대신 다른 API를 사용해야하는데 너무 복잡
	// -->request를 단순하게 사용하게 해주는 cos.jar같은 API(외부라이브러리)를 사용하자
	
	request.setCharacterEncoding("utf-8");
	// DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy();
	// MultipartRequest multiReq = new MultipartRequest(request, "파일이 저장될 폴더 위치","사이즈(특정 크기까지만 저장할 수 있게 하겠다)","utf-8",new DefaultFielRenamePolicy());
	// 2^10 byte = 1 kbyte 1024 byte = 1 kbyte
	// 2^10 kbyte = 1 mbyte
	// 100 mbyte = 1024*1024*100 byte = 104857600 byte 곱셈을 계산해서 코딩하면 가독성이 떨어진다
	String path = application.getRealPath("upload"); // application변수는 tomcat자체를 가르킴 tomcat안의 upload라는 변수의 위치값을 찾아달란뜻 
	System.out.println(path);
	MultipartRequest multiReq = new MultipartRequest(request, path,1024*1024*100,"utf-8",new DefaultFileRenamePolicy()); // 얠 진행하는 순간 파일은 자동으로 무조건 받아짐
	// 실제경로는 \로 표현 \\두번써야 \하나와 같이 표현됨
	String photoPw = multiReq.getParameter("photoPw");
	String writer = multiReq.getParameter("writer");
	
	//<input type="file" name="photo">에 대한 처리
	String photoOriginalName = multiReq.getOriginalFileName("photo"); // 파일 업로드시 원본의 이름
	String photoName = multiReq.getFilesystemName("photo"); // new DefaultFileRenamePolicy()객체를 통해 변경된 이름
	String photoType = multiReq.getContentType("photo");
	
	//디버깅
	System.out.println(photoPw + "<--photoPw");
	System.out.println(writer + "<--writer");
	System.out.println(photoOriginalName + "<--photoOriginalName");
	System.out.println(photoName + "<--photoName");
	System.out.println(photoType + "<--photoType");
	
	
	//()파일업로드의 경우 100byte 이하의 image/gif, image/jpeg 3가지 이미지만 허용
	if(photoType.equals("image/gif") || photoType.equals("image/png") || photoType.equals("image/jpeg")) {
		//db에 저장....
		System.out.println("db 고고!");
		PhotoDao photoDao = new PhotoDao();
		Photo photo = new Photo();
		photo.setPhotoName(photoName);
		photo.setPhotoOriginalName(photoOriginalName);
		photo.setPhotoType(photoType);
		photo.setPhotoPw(photoPw);
		photo.setWriter(writer);
		
		photoDao.insertPhoto(photo); // 메서드 구현
		
		response.sendRedirect(request.getContextPath() + "/photo/photoList.jsp");
		
	} else {
		System.out.println("이미지파일만 업로드!");
		// 잘못들어온 파일이므로 
		File file = new File(path+"\\"+photoName);
		file.delete(); // 잘못업로드된 파일을 삭제
		response.sendRedirect(request.getContextPath()+"/photo/insertPhotoForm.jsp");
		
	}
%>
