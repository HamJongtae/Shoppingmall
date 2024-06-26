package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class MyPageAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		//회원 정보
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(user_num);
		
		//관심 게시물 정보
		
		//구매상품 정보
		
		request.setAttribute("member", member);
		
		//JSP 경로 반환
		return "/WEB-INF/views/member/myPage.jsp";
	}

}
