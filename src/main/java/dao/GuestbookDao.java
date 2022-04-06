package dao;
import java.util.*;

import org.mariadb.jdbc.client.result.Result;

import vo.Guestbook;
import java.sql.*;
public class GuestbookDao {
	//생성자 메서드
	public GuestbookDao() {}
	
	//입력 ===========================================================================================
	// GuestbookDao guestbookDao = new GuestbookDao();
	// Guestbook guestbook = new Guestbook();
	// guestbookDao.insertGuestbook(guestbook); 호출
	public void insertGuestbook(Guestbook guestbook) throws Exception { 
		
		// 값 제대로 들어온지 확인
		System.out.println(guestbook.getWriter());
		System.out.println(guestbook.getGuestbookContent());
		System.out.println(guestbook.getGuestbookPw());
		
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		//데이터 베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		// insert문 쿼리 저장
		String sql = "insert into guestbook(guestbook_content, writer, guestbook_pw, create_date, update_date)values(?,?,?,now(),now())"; 
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println("conn : " + conn);
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.getGuestbookContent());
		stmt.setString(2, guestbook.getWriter());
		stmt.setString(3, guestbook.getGuestbookPw());
		
		
		int row = stmt.executeUpdate();
		
		//디버깅
		if(row == 1) {
			System.out.println(row +"행 입력성공");
		} else {
			System.out.println("입력실패");
		}

		//데이터베이스 자원들 반환
		stmt.close();
		conn.close();
		
	}
	
	//수정(guestbookOne, updateGuestbook)===========================================================================================
	// updateGuestbookForm.jsp에서 호출 - guestbookOne =====================================================================
	public Guestbook selectGuestbookOne(int guestbookNo)  throws Exception {
		Guestbook guestbook = null;
		
		//드라이버 로딩
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);

		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent,writer FROM guestbook WHERE guestbook_no = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		System.out.println("stmt : " + stmt);
		
		rs = stmt.executeQuery();
			
		if(rs.next()) { 
			guestbook = new Guestbook(); // 생성자메서드
			guestbook.setGuestbookNo(rs.getInt("guestbookNo"));
			guestbook.setGuestbookContent(rs.getString("guestbookContent"));
			guestbook.setWriter(rs.getString("writer"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return guestbook;
	}
	// 이름 updateGuestbook
	// 반환타입 int 수정한 행 개수 반환 -> 0 수정실패, 1 수정성공 
	// 입력매개변수 guestbookNo, guestbookContent, guestbookPw 3개 -> 하나의 타입 매개변수로 받고 싶다 -> Guestbook 타입 사용
	public int updateGuestbook(Guestbook guestbook) throws Exception {
		int row = 0; // 수정한 행 개수
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);

		String sql = "UPDATE guestbook SET guestbook_content = ? WHERE guestbook_no=? and guestbook_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.getGuestbookContent());
		stmt.setInt(2, guestbook.getGuestbookNo());
		stmt.setString(3, guestbook.getGuestbookPw());
		System.out.println("stmt : " + stmt);
		
		//디버깅
		row = stmt.executeUpdate();
	
		stmt.close();
		conn.close();
		
		return row;
	}
	
	//삭제 (deleteGuestbook) 프로세스 deleteGuestbookAction.jsp 호출============================================================================================
	// 이름 - deleteGuestbook
	// 반환값 - 삭제한 행의 수 반환 -> 0 수정실패, 1 수정성공 -> int
	// 입력 매개값 - guestbookNo, guestbookPw 2개 -> int, String (Guestbook타입을 사용해도 된다)
	public int deleteGuestbook(int guestbookNo, String guestbookPw) throws Exception {
		int row = 0;
		
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		Connection conn = null;
		PreparedStatement stmt = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		
		String sql = "DELETE FROM guestbook WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		stmt.setString(2, guestbookPw);
		System.out.println("stmt : " + stmt);
		
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// guestbook 전체 행의 수를 반환 메서드 ==================================================================
	public int selectGuestbookTotalRow() throws Exception {
		int row =0;
		
		//구현
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		//데이터 베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		String sql = "SELECT COUNT(*) cnt FROM guestbook";
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		
		stmt = conn.prepareStatement(sql);

		rs = stmt.executeQuery();
		if(rs.next()) { 
			row = rs.getInt("cnt");
		}
		
		return row;
	}
	
	// guestbook 10행씩 반환하는 메서드 필요 =============================================================================
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage) throws Exception { 
		ArrayList<Guestbook> list = new ArrayList<Guestbook> ();
		
		//guestbook 10행 반환되도록 구현
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		//데이터 베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent,guestbook_pw guestbookPw, writer, create_date createDate From guestbook order by create_date desc LIMIT ?,?"; 
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--conn"); // 디버깅 코드
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		
		//데이터 변환(가공)
		while(rs.next()) { 
			Guestbook g = new Guestbook();
			g.setGuestbookNo(rs.getInt("guestbookNo"));
			g.setGuestbookContent(rs.getString("guestbookContent"));
			g.setWriter(rs.getString("writer"));
			g.setCreateDate(rs.getString("createDate"));
			g.setGuestbookPw(rs.getString("guestbookPw"));
			list.add(g);
		}
		
		//데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
}
