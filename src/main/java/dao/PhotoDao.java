package dao;
import java.sql.*;
import java.util.*;
import vo.*;
public class PhotoDao {
	//생성자 메서드
	public PhotoDao() {}
	
	//이미지 이름 반환하는 메서드
	public String selectPhotoName(int photoNo) throws Exception {
		
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		//데이터 베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "mariadb1234"; // 비번 저장

		String photoName = "";
		String sql = "SELECT photo_name photoName FROM photo WHERE photo_no = ?";
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println("conn : " + conn);
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1,photoNo);

		return photoName;
	}
	
	//이미지 입력
	public void insertPhoto(Photo photo) throws Exception {
		
		//값 제대로 들어온지 확인
		System.out.println(photo.getPhotoName());
		System.out.println(photo.getPhotoOriginalName());
		System.out.println(photo.getPhotoType());
		System.out.println(photo.getPhotoPw());
		System.out.println(photo.getWriter());
		
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		//데이터 베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "mariadb1234"; // 비번 저장
		// insert문 쿼리 저장
		String sql = "INSERT into photo(photo_name, photo_original_name,photo_type, photo_pw, writer,create_date,update_date) values (?,?,?,?,?,now(),now())"; 
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println("conn : " + conn);
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,photo.getPhotoName());
		stmt.setString(2,photo.getPhotoOriginalName());
		stmt.setString(3,photo.getPhotoType());
		stmt.setString(4,photo.getPhotoPw());
		stmt.setString(5,photo.getWriter());
		
		int row = stmt.executeUpdate();
		
		if(row == 1) { 
			System.out.println(row + "행 입력성공");
		} else {
			System.out.println("행 입력실패");
		}
		
		//데이터베이스 자원들 반환
		stmt.close();
		conn.close();
	}
	
	//이미지 삭제
	public int deletePhoto(int photoNo, String photoPw) throws Exception { // photoNo, photoPw 입력받아서 삭제하기 
		int row = 0;
		
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		//데이터 베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "mariadb1234"; // 비번 저장
		//delete 쿼리 문 저장
		String sql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		System.out.println("stmt : " + stmt);
		
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	//전체 행의 수
	public int selectPhotoTotalRow() throws Exception {
		int total = 0;
		
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
				
		//데이터 베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "mariadb1234"; // 비번 저장
		// 총 개수 반환하기
		String sql = "SELECT COUNT(*) cnt FROM photo";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		stmt = conn.prepareStatement(sql);
		
		rs = stmt.executeQuery();
		if(rs.next()) {
			total = rs.getInt("cnt");
		}
		
		return total;
	}
	
	//이미지 리스트 출력
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo> ();
		
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		//데이터 베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "mariadb1234"; // 비번 저장
		String sql = "SELECT photo_no photoNo, photo_name photoName FROM photo ORDER BY create_date LIMIT ?,?";
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		rs= stmt.executeQuery();
		while(rs.next()) {
			Photo photo = new Photo();
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			list.add(photo);
		}
		return list;
	}
	
	//이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception { 
		Photo photo = null;
		
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		//데이터 베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "mariadb1234"; // 비번 저장
		String sql = "SELECT photo_no photoNo, photo_name photoName, writer, create_date createDate FROM photo WHERE photo_no =?";
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		rs= stmt.executeQuery();
		
		if(rs.next()) {
			photo = new Photo();
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
		
	}
		return photo;

	//수정은 삭제 후 새로 입력
}
	
}
