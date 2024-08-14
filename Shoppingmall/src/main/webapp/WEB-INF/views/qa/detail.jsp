<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 문의 상세</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/qa_comment.js"></script>
</head>
<body>
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="container">
			<h2 class="pt-5 pb-3">고객 문의</h2>
			
		<hr size="1" noshade="noshade" width="100%">
			<div class="mt-4 mb-4 d-flex justify-content-between align-items-center">
				<!-- 제목 -->
				<div class="text-start fs-3 mt-1">${qa.qa_title}</div>					
			</div>	
		
		<hr size="1" noshade="noshade" width="100%">
			<div class="mt-1 mb-1 d-flex justify-content-between align-items-center">
				<!-- 작성자 정보 -->
        		<div class="d-flex align-items-center">
					<div class="me-3 d-inline">
						<img src="${pageContext.request.contextPath}/upload/${qa.mem_photo}" width="30" height="30" class="my-photo rounded-circle me-1">
					</div>
					<div class="me-4 d-inline">${qa.mem_id}</div>
				</div>	
				<!-- 작성일 -->
				<div class="text-end" style="margin-right: 30px;">
					<c:if test="${!empty qa.qa_modify}">
						${fn:substring(qa.qa_modify,0,10)}
					</c:if>
					<c:if test="${empty qa.qa_modify}">
						${fn:substring(qa.qa_reg,0,10)}
					</c:if>
				</div>	
			</div>
			
		<hr size="1" noshade="noshade" width="100%">
			<!-- 사진 첨부 -->
			<c:if test="${!empty qa.qa_photo}">
				<div class="text-center mb-5">
					<c:forEach var="photo" items="${fn:split(qa.qa_photo,',')}">
						<img src="${pageContext.request.contextPath}/upload/${photo}" class="detail-img" width="600px" height="400px"><br>
					</c:forEach>
				</div>
			</c:if>
			<!-- 상세 내용 -->
			<p>
				${qa.qa_content} 
			</p>
		<hr size="1" noshade="noshade" width="100%">
			<!-- 내용 하단 버튼 -->
			<div class="text-end mb-1">
			<ul class="detail-sub list-unstyled">
					<li>
						<input type="button" class="btn btn-warning text-white" value="목록" onclick="location.href='list.do'">	
						<%-- 로그인한 회원번호와 작성자 회원번호가 일치해야 수정, 삭제 가능 --%>
						<c:if test="${user_num == qa.mem_num}">
						<input type="button" class="btn btn-warning text-white" value="수정" onclick="location.href='updateForm.do?qa_num=${qa.qa_num}'">
						<input type="button" class="btn btn-warning text-white" value="삭제" id="delete_btn" >
						<script type="text/javascript">
							const delete_btn = document.getElementById('delete_btn');
							//이벤트 연결
							delete_btn.onclick = function(){
								let choice = confirm('정말 삭제하시겠습니까?');
								if(choice){
									location.replace('delete.do?qa_num=${qa.qa_num}');
								}
							};
						</script>
					</c:if>
				</li>
			</ul>
			</div>
			<!-- 댓글 목록 출력 시작 -->
			<h4>관리자 답변</h4>
			<c:if test="${count == 0}">
				<div class="result-display" id="answer">
					아직 답변이 등록되지 않았습니다.
				</div>
			</c:if>
			<div id="output">
			<!-- ajax로 답변 정보가 추가되는 공간 -->
			</div>
			<div class="paging-button" style="display: none;">
				<input type="button" value="다음글 보기">
			</div>
			<div id="loding" style="display: none;">
				<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
			</div>			
			<!-- 댓글 목록 출력 끝 -->	
			<!-- 답글 시작 -->		
			<div id="reply_div"  class="mt-3 mb-5">
				<form id="re_form">
					<input type="hidden" name="qa_num" value="${qa.qa_num}" id="qa_num">
					<c:if test="${user_auth == 9 && count == 0}">
					<div class="input-group">
					<textarea rows="3" cols="150" placeholder="답변을 등록해주세요" name="qa_comm_content" <c:if test="${user_auth != 9}">disabled="disabled"</c:if> id="re_content" 
					class="form-control rep-content"></textarea>								
						<div id="re_second" class="input-group-append">
							<input type="submit" value="답변 등록" class="btn btn-warning text-white pt-5 pb-5">
						</div>
					</div>
						<div id="re_first" class="text-end mt-2" style="margin-right: 90px;">
							<span class="letter-count">300/300</span>
						</div>
					</c:if>
				</form>	
			</div>			
			<!-- 답글 끝 -->	
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>