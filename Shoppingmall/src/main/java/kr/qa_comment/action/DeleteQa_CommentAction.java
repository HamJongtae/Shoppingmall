package kr.qa_comment.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qa.dao.QaDAO;
import kr.qa.dao.Qa_CommentDao;

public class DeleteQa_CommentAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		
		int qa_num = Integer.parseInt(request.getParameter("qa_num"));
		System.out.println(qa_num);
		
		//댓글 번호
		int qa_comm_num = Integer.parseInt(request.getParameter("qa_comm_num"));
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		Qa_CommentDao dao = Qa_CommentDao.getDao();
		
		dao.deleteQa_Comment(qa_comm_num);
		
		QaDAO qaDAO = QaDAO.getDao();
		qaDAO.updateQaStatus(qa_num, 1);
		
		mapAjax.put("result", "success");
		
				
		//JSON 데이터로 변환
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
