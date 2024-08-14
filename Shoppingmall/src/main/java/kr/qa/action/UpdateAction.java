package kr.qa.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.qa.dao.QaDAO;
import kr.qa.vo.QaVO;
import kr.util.FileUtil;

public class UpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		//전송된 데이터 반환
		int qa_num = Integer.parseInt(request.getParameter("qa_num"));
		QaDAO dao = QaDAO.getDao();
		//수정전 데이터
		QaVO db_qa = dao.detailQa(qa_num);
		//로그인한 회원번호와 작성자 회원번호 일치 여부 체크
		if(user_num != db_qa.getMem_num()) {
			request.setAttribute("notice_msg", "회원정보가 일치하지 않습니다.");
			request.setAttribute("notice_url", request.getContextPath() + "/qa/list.do");
			return "/WEB-INF/views/common/alert_view.jsp";
		}
		//로그인한 회원번호와 작성자 회원번호 일치
		QaVO qa = new QaVO();
		qa.setQa_num(qa_num);
		qa.setQa_title(request.getParameter("qa_title"));
		qa.setQa_content(request.getParameter("qa_content"));
		qa.setQa_photo(FileUtil.createFiles(request));
		dao.updateQa(qa);
		
		if(qa.getQa_photo() != null && !"".equals(qa.getQa_photo())) {
			//새 파일로 교체할 때 원래 파일 제거
			if(db_qa.getQa_photo() != null) {
				//사진 삭제
				String[] photos = db_qa.getQa_photo().split(",");
				for(String pho : photos) {
					FileUtil.removeFile(request, pho);
				}
			}
		}
		return "redirect:/qa/detail.do?qa_num=" + qa_num;
	}

}
