package kr.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import kr.board.vo.BoardVO;

public class BoardDAO {
	//싱글턴 패턴
	private static BoardDAO instance = new BoardDAO();
	
	public static BoardDAO getInstance() {
		return instance;
	}
	private BoardDAO() {}
	
	//글 등록
	public void insertBoard(BoardVO board) throws Exception{
		
	}
	
	//총 글의 개수, 검색 개수
	public int getBoardCount(String keyfield, String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		
		return count;
	}
	
	//글 목록, 검색 글 목록
	public List<BoardVO> getListBoard(int start, int end, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardVO> list = null;
		String sql = null;
		String sub_sql = "";
		
		return list;
	}
	
	//글 상세
	public BoardVO getBoard(int board_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVO board = null;
		String sql = null;
		
		return board;
	}
	
	//조회수 증가
	public void updateReadcount(int board_num)throws Exception{
		
	}
	
	//파일 삭제
	public void deleteFile(int board_num)throws Exception{
		
	}
	
	//글 수정
	public void updateBoard(BoardVO board) throws Exception{
		
	}
	
	//글 삭제
	public void deleteBoard(int board_num)throws Exception{
		
	}
}
