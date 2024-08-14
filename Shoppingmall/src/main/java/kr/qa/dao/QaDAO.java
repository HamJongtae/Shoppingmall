package kr.qa.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.qa.vo.QaVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class QaDAO {
	//싱글턴 패턴
	private static QaDAO instance = new QaDAO();
	
	public static QaDAO getDao() {
		return instance;
	}
	private QaDAO() {}
	
	//글 등록
	public void insertQa(QaVO qa)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO qa (qa_num, mem_num, qa_title, qa_content, qa_photo)"
					+ " VALUES(qa_seq.nextval, ?, ?, ?, ?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터바인딩
			pstmt.setInt(++cnt, qa.getMem_num());
			pstmt.setString(++cnt, qa.getQa_title());
			pstmt.setString(++cnt, qa.getQa_content());
			pstmt.setString(++cnt, qa.getQa_photo());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//총 글의 개수, 검색 개수
	public int getQaCount(String keyfield, String keyword)throws Exception{
		  Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      String sub_sql = "";
	      int count = 0;
	      try {
	         //커넥션풀로부터 커넥션 할당
	         conn = DBUtil.getConnection();
	         
	         if(keyword != null && !"".equals(keyword)) {
	        	 //검색 처리
	        	 if(keyfield.equals("1")) sub_sql += "WHERE qa_title LIKE '%' || ? || '%'";
	        	 else if(keyfield.equals("2")) sub_sql += "WHERE mem_id LIKE '%' || ? || '%'";
	        	 else if(keyfield.equals("3")) sub_sql += "WHERE qa_content LIKE '%' || ? || '%'";
	         }
	         //SQL문 작성
	         sql="SELECT COUNT(*) FROM qa JOIN hmember USING(mem_num) " + sub_sql;
	         //PreparedStatment 객체 생성
	         pstmt = conn.prepareStatement(sql);
	         if(keyword != null && !"".equals(keyword)) {
	        	 pstmt.setString(1, keyword);
	         }
	         //SQL문 실행
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	        	 count = rs.getInt(1);
	         }
	      }catch(Exception e) {
	         throw new Exception(e);
	      }finally {
	         DBUtil.executeClose(null, pstmt, conn);
	      }
	      return count;
	}
	//글 목록
	public List<QaVO> getListQa(int start, int end, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QaVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();		
			if(keyword != null && !"".equals(keyword)) {
				//검색처리
				if(keyfield.equals("1")) sub_sql += "WHERE qa_title Like '%' || ? || '%'";
				else if(keyfield.equals("2")) sub_sql += "WHERE mem_id Like '%' || ? || '%'";
				else if(keyfield.equals("3")) sub_sql += "WHERE qa_content Like '%' || ? || '%'";
			}		
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM qa JOIN hmember USING(mem_num) " + sub_sql
					+ " ORDER BY qa_num DESC)a) WHERE rnum >=? AND rnum <=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, keyword);
			}		
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<QaVO>();
			while(rs.next()) {
				QaVO qa = new QaVO();
				qa.setQa_num(rs.getInt("qa_num"));
				qa.setQa_status(rs.getInt("qa_status"));
				qa.setQa_title(StringUtil.useNoHTML(rs.getString("qa_title")));
				qa.setMem_id(rs.getString("mem_id"));
				qa.setQa_reg(rs.getString("qa_reg"));
				qa.setMem_num(rs.getInt("mem_num"));
				qa.setQa_modify(rs.getString("qa_modify"));
				list.add(qa);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//글 상세
	public QaVO detailQa(int qa_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QaVO qa = null;
		String sql = null;
		int cnt = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM qa JOIN hmember USING(mem_num) LEFT OUTER JOIN hmember_detail USING(mem_num) WHERE qa_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(++cnt, qa_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				qa = new QaVO();
				qa.setQa_num(rs.getInt("qa_num"));
				qa.setMem_id(rs.getString("mem_id"));
				qa.setQa_title(rs.getString("qa_title"));
				qa.setQa_content(rs.getString("qa_content"));
				qa.setQa_status(rs.getInt("qa_status"));
				qa.setQa_reg(rs.getString("qa_reg"));
				qa.setQa_modify(rs.getString("qa_modify"));
				qa.setMem_num(rs.getInt("mem_num"));
				qa.setQa_photo(rs.getString("qa_photo"));
				qa.setMem_photo(rs.getString("mem_photo"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return qa;
	}	
	//파일 삭제
	public void deletePhoto(int qa_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE qa SET qa_photo='' WHERE qa_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(++cnt, qa_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//처리상태여부 변경 (답변 등록 시: 미처리 → 처리)
	public void updateQaStatus(int qa_num, int qa_status)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int cnt = 0;
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE qa SET qa_status=? WHERE qa_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, qa_status);
			pstmt.setInt(++cnt, qa_num);
			pstmt.executeUpdate();
		}catch(Exception e){
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	
	//글 수정
	public void updateQa(QaVO qa)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(qa.getQa_photo() != null && !"".equals(qa.getQa_photo())) {
				sub_sql += ",qa_photo=?";
			}
			//SQL문 작성
			sql = "UPDATE qa SET qa_title=?, qa_content=?, qa_modify=SYSDATE" + sub_sql
					+ " WHERE qa_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(++cnt, qa.getQa_title());
			pstmt.setString(++cnt, qa.getQa_content());
			if(qa.getQa_photo() != null && !"".equals(qa.getQa_photo())) {
				pstmt.setString(++cnt, qa.getQa_photo());
			}
			pstmt.setInt(++cnt, qa.getQa_num());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//글 삭제
	public void deleteQa(int qa_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		try {
			//커넥션풀로 커넥션 할당
			conn = DBUtil.getConnection();
			//오토커밋 해제
			conn.setAutoCommit(false);
			
			//답변 삭제
			sql = "DELETE FROM qa_comment WHERE qa_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qa_num);
			pstmt.executeUpdate();
			
			//부모글 삭제
			sql = "DELETE FROM qa WHERE qa_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, qa_num);
			pstmt2.executeUpdate();
			
			//예외 발생 없이 정상적으로 SQL문 실행
			conn.commit();
		}catch(Exception e) {
			//예외 발생 시 롤백 
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
