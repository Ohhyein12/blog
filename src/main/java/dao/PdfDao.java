package dao;

import java.sql.*;
import java.util.*;
import vo.Pdf;

public class PdfDao {
	
	//생성자 메서드
	public PdfDao() {}
	
	//입력 ===========================================
	public void insertPdf(Pdf pdf) throws Exception {
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
		String sql = "INSERT INTO pdf(pdf_name, pdf_original_name, pdf_type, pdf_pw, writer, create_date, update_date) values(?,?,?,?,?,now(),now())";
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println("conn : " + conn);
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,pdf.getPdfName());
		stmt.setString(2,pdf.getPdfOriginalName());
		stmt.setString(3,pdf.getPdfType());
		stmt.setString(4,pdf.getPdfPw());
		stmt.setString(5,pdf.getWriter());

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
	
	//pdf 삭제
	public int deletePdf(int pdfNo, String pdfPw) throws Exception {
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
		String sql = "DELETE FROM pdf WHERE pdf_no=? AND pdf_pw=?";
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		stmt.setString(2, pdfPw);
		System.out.println("stmt : " + stmt);
		
		row = stmt.executeUpdate();
		
		//데이터 베이스 자원들 반환
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
		String sql = "SELECT COUNT(*) cnt FROM pdf";
		
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		stmt = conn.prepareStatement(sql);
		
		rs = stmt.executeQuery();
		if(rs.next()) {
			total = rs.getInt("cnt");
		}
		
		return total;
	}
	
	//pdf 리스트 출력
	public ArrayList<Pdf> selectPdfListByPage(int beginRow,int rowPerPage) throws Exception {
		ArrayList<Pdf> list = new ArrayList<Pdf> ();
		
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
		
		String sql = "SELECT pdf_no pdfNo,pdf_name pdfName, writer,create_date createDate FROM pdf ORDER BY create_date DESC LIMIT ?,?";
		
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		rs= stmt.executeQuery();
		while(rs.next()) {
			Pdf pdf = new Pdf();
			pdf.setPdfNo(rs.getInt("pdfNo"));
			pdf.setPdfName(rs.getString("pdfName"));
			pdf.setWriter(rs.getString("writer"));
			pdf.setCreateDate(rs.getString("createDate"));
			list.add(pdf);
		}
		return list;
	}
	

}
