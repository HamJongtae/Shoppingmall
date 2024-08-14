package kr.qa.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.qa.vo.Qa_CommentVo;
import kr.util.DBUtil;
import kr.util.DurationFromNow;
import kr.util.StringUtil;

public class Qa_CommentDao {
	//싱글턴 패턴
	private static Qa_CommentDao instance = new Qa_CommentDao();
	
	public static Qa_CommentDao getDao() {
		return instance;
	}
	private Qa_CommentDao() {}
	
	//답글 등록
	public void insertQa_Comment(Qa_CommentVo qa_comment)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try {
			//커넥션 풀에 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO qa_comment(qa_comm_num, qa_comm_content, qa_num)"
					+ "VALUES (qa_comment_seq.nextval, ?, ?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(++cnt, qa_comment.getQa_comm_content());
			pstmt.setInt(++cnt, qa_comment.getQa_num());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {

			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//답글 개수
	public int CountQa_Comment(int qa_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		int cnt = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM qa_comment WHERE qa_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(++cnt, qa_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	
	//답글 목록
	public List<Qa_CommentVo> ListQa_Comment(int start, int end, int qa_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Qa_CommentVo> list = null;
		String sql = null;
		int cnt = 0;
		try {
			//커넥션풀에서 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM qa_comment"
					+ " WHERE qa_num=? ORDER BY qa_comm_num DESC)a) WHERE rnum >=? AND rnum <=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, qa_num);
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			rs = pstmt.executeQuery();
			
			list = new ArrayList<Qa_CommentVo>();
			while(rs.next()) {
				Qa_CommentVo reply = new Qa_CommentVo();
				reply.setQa_comm_num(rs.getInt("qa_comm_num"));
				reply.setQa_comm_reg(DurationFromNow.getTimeDiffLabel(rs.getString("qa_comm_reg")));
				if(rs.getString("qa_comm_modify") != null) {
					reply.setQa_comm_modify(DurationFromNow.getTimeDiffLabel(rs.getString("qa_comm_modify")));
				}
				reply.setQa_comm_content(StringUtil.useBrNoHTML(rs.getString("qa_comm_content")));
				reply.setQa_num(rs.getInt("qa_num"));
				list.add(reply);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//댓글 상세(댓글 수정, 삭제 시 작성자 회원번호 체크 용도로 사용)
	public Qa_CommentVo ListQa_Comment(int qa_comm_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Qa_CommentVo reply = null;
		String sql = null;
		int cnt = 0;
		try {
			//커넥션 풀에 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM qa_comment WHERE qa_comm_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(++cnt, qa_comm_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reply = new Qa_CommentVo();
				reply.setQa_comm_num(rs.getInt("qa_comm_num"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return reply;
	}
	
	//답글 수정
	public void updateQa_Comment(Qa_CommentVo reply)throws Exception{
		System.out.println(reply);
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE qa_comment SET qa_comm_content=?, qa_comm_modify=SYSDATE WHERE qa_comm_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(++cnt, reply.getQa_comm_content());
			pstmt.setInt(++cnt, reply.getQa_comm_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//답글 삭제
	public void deleteQa_Comment(int qa_comm_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "DELETE FROM qa_comment WHERE qa_comm_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(++cnt, qa_comm_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
