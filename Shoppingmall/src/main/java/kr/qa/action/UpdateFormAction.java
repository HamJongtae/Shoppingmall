package kr.qa.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qa.dao.QaDAO;
import kr.qa.vo.QaVO;
import kr.util.StringUtil;

public class UpdateFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		int qa_num = Integer.parseInt(request.getParameter("qa_num"));
		QaDAO dao = QaDAO.getDao();
		QaVO qa = dao.detailQa(qa_num);
		
		//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
		if(user_num != qa.getMem_num()) {
			request.setAttribute("notice_msg", "회원정보가 일치하지 않습니다.");
			request.setAttribute("notice_url", request.getContextPath() + "/qa/list.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		
		//큰따옴표 처리
		//수정폼의 input 태그에서 큰 따옴표 오류 보정
		qa.setQa_title(StringUtil.parseQuot(qa.getQa_title()));
		
		//로그인이 되어있고 로그인한 회원번호와 작성자 회원번호 일치
		request.setAttribute("qa", qa);
		return "/WEB-INF/views/qa/updateForm.jsp";
	}

}
