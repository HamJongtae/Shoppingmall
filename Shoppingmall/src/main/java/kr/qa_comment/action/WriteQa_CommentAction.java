package kr.qa_comment.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qa.dao.QaDAO;
import kr.qa.dao.Qa_CommentDao;
import kr.qa.vo.Qa_CommentVo;
  
public class WriteQa_CommentAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}else {//로그인 된 경우
			//전송된 데이터 인코딩 타입 지정
			request.setCharacterEncoding("utf-8");
			
			int qa_status = 2;
			int qa_num = Integer.parseInt(request.getParameter("qa_num"));
			QaDAO qaDAO = QaDAO.getDao();
			qaDAO.updateQaStatus(qa_num, qa_status);
			
			//자바빈(VO)을 생성해서 전송된 데이터 저장
			Qa_CommentVo reply = new Qa_CommentVo();
			reply.setQa_comm_content(request.getParameter("qa_comm_content"));
			reply.setQa_num(Integer.parseInt(request.getParameter("qa_num")));
			
			Qa_CommentDao dao = Qa_CommentDao.getDao();
			dao.insertQa_Comment(reply);
			
			mapAjax.put("result", "success");
		}
			//JSON 데이터로 변환
			ObjectMapper mapper = new ObjectMapper();
			String ajaxData = mapper.writeValueAsString(mapAjax);
			request.setAttribute("ajaxData", ajaxData);
			
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
