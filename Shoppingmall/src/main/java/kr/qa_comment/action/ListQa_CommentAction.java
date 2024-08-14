package kr.qa_comment.action;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qa.dao.Qa_CommentDao;
import kr.qa.vo.Qa_CommentVo;
import kr.util.PagingUtil;


public class ListQa_CommentAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 타입 지정
		request.setCharacterEncoding("utf-8");
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		String rowCount = request.getParameter("rowCount");
		if(rowCount == null) {
			rowCount = "10";
		}

		int qa_num = Integer.parseInt(request.getParameter("qa_num"));
		Qa_CommentDao dao = Qa_CommentDao.getDao();
		int count = dao.CountQa_Comment(qa_num);
		
		PagingUtil page = new PagingUtil(Integer.parseInt(pageNum), count, Integer.parseInt(rowCount));
		List<Qa_CommentVo> list = null;
		list = Collections.emptyList();
		if(count > 0) {
			list = dao.ListQa_Comment(page.getStartRow(), page.getEndRow(), qa_num);
		}else {
			list = Collections.emptyList();
		}

		Map<String, Object> mapAjax = new HashMap<String, Object>();
		mapAjax.put("count", count);
		mapAjax.put("list", list);
			

		HttpSession session = request.getSession();
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth!=null) {
			mapAjax.put("auth", user_auth);
		}
		
		
		
		//JSON 문자열로 변환
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);

		
		
		request.setAttribute("ajaxData", ajaxData);
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
