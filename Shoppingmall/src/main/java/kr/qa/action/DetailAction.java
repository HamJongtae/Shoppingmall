package kr.qa.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.qa.dao.QaDAO;
import kr.qa.vo.QaVO;
import kr.qa.dao.Qa_CommentDao;
import kr.util.StringUtil;

public class DetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//글번호 반환
		int qa_num = Integer.parseInt(request.getParameter("qa_num"));
		QaDAO dao = QaDAO.getDao();
		
		QaVO qa = dao.detailQa(qa_num);
		Qa_CommentDao ddao = Qa_CommentDao.getDao();
		int count = ddao.CountQa_Comment(qa_num);
		//HTML를 허용하지 않음
		qa.setQa_title(StringUtil.useNoHTML(qa.getQa_title()));
		//HTML를 허용하지 않음
		qa.setQa_content(StringUtil.useBrNoHTML(qa.getQa_content()));
		
		request.setAttribute("count", count);
		request.setAttribute("qa", qa);
		return "/WEB-INF/views/qa/detail.jsp";
	}

}
