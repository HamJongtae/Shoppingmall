package kr.qa.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qa.dao.QaDAO;
import kr.qa.vo.QaVO;
import kr.util.FileUtil;

public class DeleteAction implements Action{

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
		QaVO db_qa = dao.detailQa(qa_num);

		//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
		if(user_num != db_qa.getMem_num()) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		//로그인한 회원번호와 작성자 회원번호 일치
		dao.deleteQa(qa_num);
		if(db_qa.getQa_photo() != null) {
			//사진 삭제
			String[] photos = db_qa.getQa_photo().split(",");
			for(String pho : photos) {
				FileUtil.removeFile(request, pho);
			}
		}
		request.setAttribute("notice_msg", "문의글이 정상적으로 삭제되었습니다.");
		request.setAttribute("notice_url", request.getContextPath() + "/qa/list.do");
		return "/WEB-INF/views/common/alert_view.jsp";
	}

}
