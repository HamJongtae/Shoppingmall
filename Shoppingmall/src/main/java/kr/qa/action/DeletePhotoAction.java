package kr.qa.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.qa.dao.QaDAO;
import kr.qa.vo.QaVO;
import kr.util.FileUtil;

public class DeletePhotoAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> mapAjax = new HashMap<String, String>();

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		}else {//로그인 된 경우
			//전송된 데이터 인코딩 타입 지정
			request.setCharacterEncoding("utf-8");
			//전송된 데이터 반환
			int qa_num = Integer.parseInt(request.getParameter("qa_num"));
			QaDAO dao = QaDAO.getDao();
			QaVO db_qa = dao.detailQa(qa_num);
			//로그인한 회원번호와 작성자 회원번호 일치 여부 체크 
			if(user_num != db_qa.getMem_num()) {
				mapAjax.put("result", "wrongAccess");
			}else {
				if(db_qa.getQa_photo() != null) {
					dao.deletePhoto(qa_num);
					//사진 삭제
					String[] photos = db_qa.getQa_photo().split(",");
					for(String pho : photos) {
						FileUtil.removeFile(request, pho);
					}
				}
				mapAjax.put("result", "success");
			}
		}
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
