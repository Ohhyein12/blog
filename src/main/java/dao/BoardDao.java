package dao;
import vo.*;
import java.sql.*;
import java.util.*;
public class BoardDao {
	
	public BoardDao() {} // 생성자메서드 선언
	
	//출력(boardList 10행씩 반환하는 메서드)=========================
	public ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage,String categoryName) throws Exception {
	
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--conn"); // 디버깅 코드
		
		String boardSql = null;	// boardSql - select문 넣을 변수 선언
		PreparedStatement boardStmt = null; // stmt 변수 선언
		
		if(categoryName.equals("")) { // categoryName이 널이면
			boardSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate from board order by create_date desc limit ?,?"; 
			boardStmt = conn.prepareStatement(boardSql); // if문에서 넣은 쿼리 실행
			boardStmt.setInt(1, beginRow);
			boardStmt.setInt(2, rowPerPage);
			
		}else {
			boardSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate from board where category_name = ? order by create_date desc limit ?,?"; 
			boardStmt = conn.prepareStatement(boardSql); // if문에서 넣은 쿼리 실행
			boardStmt.setString(1,categoryName); // null값이 아닐경우 선택한 categoryName 넣어서 실행
			boardStmt.setInt(2, beginRow);
			boardStmt.setInt(3, rowPerPage);
		}
		
		System.out.println(boardStmt + "<--boardStmt"); // stmt 디버깅
		
		ResultSet boardRs = boardStmt.executeQuery(); // boardRs에 boardSql 쿼리로 들고온 값 저장
		System.out.println(boardRs + "<--boardRs"); // 디버깅

		ArrayList<Board> boardList = new ArrayList<Board> (); // boardList 넣을 ArrayList 생성
		while(boardRs.next()) { // true값일때만 커서 옮기면서
			Board b = new Board(); 
			b.setBoardNo(boardRs.getInt("boardNo"));
			b.setCategoryName(boardRs.getString("categoryName"));
			b.setBoardTitle(boardRs.getString("boardTitle"));
			b.setCreateDate(boardRs.getString("createDate"));
			boardList.add(b);
			// 값들 넣기
		}

		System.out.println(boardList.size() + "<--listsize"); // 디버깅

		//데이터베이스 자원들 반환
		boardRs.close();
		boardStmt.close();
		conn.close();
		
		return boardList;
	
	}
	// boardList 전체 행 개수 반환 메서드===========================
	public int selectBoardListTotalRow(String categoryName) throws Exception {
		int totalRow = 0; // select count(*) from board; 전체 행 개수
		
		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--conn"); // 디버깅 코드
		
		String totalRowSql = null;
		PreparedStatement totalRowStmt = null;
		if(categoryName.equals("")) { // categoryName이 널이면
			totalRowSql = "select count(*) cnt from board"; // 행 개수 받아오기;
			totalRowStmt = conn.prepareStatement(totalRowSql);
		} else {
			totalRowSql = "select count(*) cnt from board where category_name = ?"; 
			totalRowStmt = conn.prepareStatement(totalRowSql);
			totalRowStmt.setString(1, categoryName);
		}
		
		ResultSet totalRowRs = totalRowStmt.executeQuery();
		
		if(totalRowRs.next()) { 
			totalRow = totalRowRs.getInt("cnt"); // 행 개수 저장한 cnt 넣기
		}

		//데이터베이스 자원들 반환
		totalRowRs.close();
		totalRowStmt.close();
		conn.close();
		
		return totalRow;
	}
	
	//입력폼에 categoryName 목록 띄우기 위한 메서드 ============
	public ArrayList<String> insertBoardCategoryName() throws Exception {
		
		//마리아 db 연동 
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn + "<--conn"); // 디버깅 코드
		
		String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		ArrayList<String> list = new ArrayList<String>();
		while(rs.next()) {
			list.add(rs.getString("categoryName"));
		}
		
		//데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	// boardOne =======================================================
	public Board boardOne(int boardNo) throws Exception {

		// 마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--conn"); // 디버깅 코드
		
		String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate from board WHERE board_no = ?";
		PreparedStatement stmt = conn.prepareStatement(boardOneSql);
		stmt.setInt(1,boardNo); // 요청받아온 boardNo값 넣기
		
		ResultSet boardOneRs = stmt.executeQuery(); // boardOneRs boardSql 쿼리로 들고온 값 저장
		System.out.println(boardOneRs + "<--boardOneRs"); // 디버깅
		
		Board board = null;
		if(boardOneRs.next()) { // true값일때만 커서 옮기면서
			board = new Board(); // board값 담을 새로운 리스트 생성
			board.setBoardNo(boardOneRs.getInt("boardNo"));
			board.setCategoryName(boardOneRs.getString("categoryName"));
			board.setBoardTitle(boardOneRs.getString("boardTitle"));
			board.setBoardContent(boardOneRs.getString("boardContent"));
			board.setCreateDate(boardOneRs.getString("createDate"));
			board.setUpdateDate(boardOneRs.getString("updateDate"));
		}

		return board;
	}
	
	//입력 ======================================================
	public int insertBoard(Board board) throws Exception {
		
		//입력한 행 개수 넣을 row변수 선언
		int row = 0;
		
		//값 제대로 들어온지 확인
		System.out.println(board.getCategoryName());
		System.out.println(board.getBoardTitle());
		System.out.println(board.getBoardContent());
		System.out.println(board.getBoardPw());
		
		//마리아 db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("insertBoardAction 드라이버 로딩 성공");
		
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--insertBoardAction conn"); // 디버깅
		
		//쿼리 실행문
		String Sql = "INSERT INTO board(category_name, board_title,board_content,board_pw,create_date,update_date) VALUES(?,?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(Sql); // stmt에 저장한 쿼리 실행
		System.out.println(stmt + "<--insertBoardAction stmt"); // 디버깅
		
		stmt.setString(1, board.getCategoryName()); 
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setString(4, board.getBoardPw());
		
		row = stmt.executeUpdate(); //몇 행 입력했는지 return

		//데이터베이스 자원들 반환
		stmt.close();
		conn.close();
		
		return row;
	}
	
	//수정 ======================================================
	//수정의 boardOne 정보 받아오기
	public Board updateBoardOne(int boardNo) throws Exception {
		
		//maira DB에 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--conn"); // 디버깅
		
		//해당번호의 board정보 받아오기
		String boardOneSql = "select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate from board WHERE board_no = ?";
		PreparedStatement stmt = conn.prepareStatement(boardOneSql);
		stmt.setInt(1,boardNo); // 요청받아온 boardNo값 넣기
		
		ResultSet boardOneRs = stmt.executeQuery(); // boardOneRs boardSql 쿼리로 들고온 값 저장
		System.out.println(boardOneRs + "<--boardOneRs"); // 디버깅
		
		Board board = null;
		if(boardOneRs.next()) { // true값일때만 커서 옮기면서
			board = new Board(); // board값 담을 새로운 리스트 생성
			board.setBoardNo(boardOneRs.getInt("boardNo"));
			board.setCategoryName(boardOneRs.getString("categoryName"));
			board.setBoardTitle(boardOneRs.getString("boardTitle"));
			board.setBoardContent(boardOneRs.getString("boardContent"));
			board.setCreateDate(boardOneRs.getString("createDate"));
			board.setUpdateDate(boardOneRs.getString("updateDate"));
		}
		
		return board;
	}
	// 수정 Action ===============================================
	public int updateBoard(Board board) throws Exception {

		int row = 0;
		
		//값 제대로 들어온지 확인
		System.out.println(board.getCategoryName() + "board.categoryName");
		System.out.println(board.getBoardTitle() + "board.boardTitle");
		System.out.println(board.getBoardContent() + "board.boardContent");
		System.out.println(board.getBoardNo() + "board.boardNo");
		System.out.println(board.getBoardPw() + "board.boardPw");
		
		//maria db 연동하기
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공");
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비밀번호 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--conn"); 
		
		// 쿼리 작성하고 입력
		String Sql = "update board set category_name = ?, board_title =?, board_content = ?, update_date = now() where board_no =? and board_pw =?";
		PreparedStatement stmt = conn.prepareStatement(Sql);	
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setInt(4, board.getBoardNo());
		stmt.setString(5, board.getBoardPw());
	
		row = stmt.executeUpdate(); // 몇 행 입력한지 리턴
	
		//데이터베이스 자원들 반환
		stmt.close();
		conn.close();
		
		return row;
	}

	//삭제 =======================================================
	public int deleteBoard(Board board) throws Exception { 
		
		int row = 0;
		
		// maria db 연동
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.println("드라이버 로딩 성공"); // 디버깅
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소저장
		String dbuser = "root"; // 아이디 저장
		String dbpw = "java1234"; // 비번 저장
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--conn"); // 디버깅
		
		//쿼리 저장
		String Sql = "delete from board where board_no=? and board_pw=?";
		PreparedStatement stmt = conn.prepareStatement(Sql);
		stmt.setInt(1, board.getBoardNo());
		stmt.setString(2, board.getBoardPw());
		
		row = stmt.executeUpdate();
		
		//데이터베이스 자원들 반환
		stmt.close();
		conn.close();
		
		return row;
	}
}
