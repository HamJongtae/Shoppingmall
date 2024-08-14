package kr.qa.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qa.dao.QaDAO;
import kr.qa.vo.QaVO;
import kr.util.FileUtil;

public class WriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		//자바빈(VO)를 생성한 후 전송된 데이터를 저장
		QaVO qa = new QaVO();
		qa.setQa_title(request.getParameter("qa_title"));
		qa.setQa_content(request.getParameter("qa_content"));
		qa.setQa_photo(FileUtil.createFiles(request));
		qa.setMem_num(user_num);
		QaDAO dao = QaDAO.getDao();
		dao.insertQa(qa);
		
		request.setAttribute("notice_msg", "문의 신청 완료");
		request.setAttribute("notice_url", request.getContextPath() + "/qa/list.do");
		//JSP 경로 반환
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
