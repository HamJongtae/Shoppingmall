package kr.qa_comment.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qa.dao.Qa_CommentDao;
import kr.qa.vo.Qa_CommentVo;

public class UpdateQa_CommentAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		//댓글 번호 반환
		int qa_comm_num = Integer.parseInt(request.getParameter("qa_comm_num"));
		
		Qa_CommentDao dao = Qa_CommentDao.getDao();
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		Qa_CommentVo reply = new Qa_CommentVo();
		reply.setQa_comm_num(qa_comm_num);
		reply.setQa_comm_content(request.getParameter("qa_comm_content"));
		
		dao.updateQa_Comment(reply);
		mapAjax.put("result", "success");
		
		//JSON 데이터 변환
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
