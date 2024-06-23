package kr.member.dao;

import kr.member.vo.MemberVO;

public class MemberDAO {
	//싱글턴 패턴
	private static MemberDAO dao = new MemberDAO();
	
	public static MemberDAO getDAO() {
		return dao;
	}
	
	private MemberDAO() {};
	
	//회원가입
	public void insertMember(MemberVO member) throws Exception{
		
	}
	//ID 중복 체크 및 로그인 처리 
	//회원 상세 정보 
	//회원 정보 수정
	//프로필 사진 수정
	//회원 탈퇴 
	
	
	//관리자- 전체 내용 개수, 검색 내용 개수
	//관리자- 목록, 검색 목록
	//관리자- 회원등급 수정
	//관리자- 아이디 찾기
	//관리자- 비밀번호 찾기
	//관리자- 회원ID로 회원 정보를 가져오는 메서드
}
