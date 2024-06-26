package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;



public class RegisterUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		//자바빈(VO)생성
		MemberVO member = new MemberVO();
		
		member.setId(request.getParameter("id"));
		member.setName(request.getParameter("name"));
		member.setPasswd(request.getParameter("passwd"));
		member.setPhone(request.getParameter("phone"));
		member.setEmail(request.getParameter("email"));
		member.setZipcode(request.getParameter("zipcode"));
		member.setAddress1(request.getParameter("address1"));  
		member.setAddress2(request.getParameter("address2"));
		
		MemberDAO dao = MemberDAO.getInstance();
		dao.insertMember(member);
		
		//회원 등록 후에 회원 번호 다시 가져오기
        member = dao.getMemberByMemId(member.getId());
		
		 
		//로그인 처리
        HttpSession session = request.getSession();
        session.setAttribute("user_num", member.getMem_num());
        session.setAttribute("user_name",member.getName());
        session.setAttribute("user_id", member.getId());
        session.setAttribute("user_auth", member.getAuth());
        session.setAttribute("user_photo", member.getPhoto());
		
		request.setAttribute("notice_msg", "회원 가입이 완료되었습니다.");
		request.setAttribute("notice_url", request.getContextPath()+"/main/main.do");
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
