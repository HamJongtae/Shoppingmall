<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">
	window.onload = function(){
		const myForm = document.getElementById('update_form');
		//이벤트 연결
		myForm.onsubmit = function(){
			const title = document.getElementById('qa_title');
			if(title.value.trim()==''){
				alert('제목을 입력하세요');
				title.value = '';
				title.focus();
				return false;
			}
			const content = document.getElementById('qa_content');
			if(content.value.trim()==''){
				alert('내용을 입력하세요');
				content.value = '';
				content.focus();
				return false;
			}
		};
	};
</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="container">
			<h2 class="mt-5 mb-5">문의글 수정</h2>
				<form id="update_form" action="update.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="qa_num" value="${qa.qa_num}"> 
					<ul class="list-unstyled">
						<li class="mb-2">
							<label for="qa_title" class="fs-4 mt-3 mb-2">제목</label>
							<input type="text" class="form-control" name="qa_title" id="qa_title" value="${qa.qa_title}" maxlength="50">
						</li>
						<li class="mt-2">
							<label for="qa_content" class="fs-4 mb-2">내용</label>
							<textarea rows="20" cols="70" class="form-control" name="qa_content" id="qa_content">${qa.qa_content}</textarea>
						</li>
						<li>
							<input type="file" name="qa_photo" class="form-control mt-3 mb-2" id="qa_photo" accept="image/gif, image/png, image/jpeg" multiple>
							<c:if test="${!empty qa.qa_photo}">
								<div id="photo_detail">
									<img src="${pageContext.request.contextPath}/upload/${qa.qa_photo}" width="100">
									<br>
									<input type="button" class="btn btn-warning mb-4 text-white" value="사진 삭제" id="photo_del">
								</div>
								<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
								<script type="text/javascript">
									$(function(){
										$('#photo_del').click(function(){
											let choice = confirm('삭제하시겠습니까?');
											if(choice){
												//서버와 통신
												$.ajax({
													url: 'deletePhoto.do',
													type: 'post',
													data: {qa_num: ${qa.qa_num}},
													dataType: 'json',
													success: function(param){
														if(param.result == 'logout'){
															alert('로그인 후 사용하세요');
														}else if(param.result == 'success'){
															$('#photo_detail').hide();
														}else if(param.result == 'wrongAccess'){
															alert('잘못된 접속입니다.');
														}else{
															alert('파일 삭제 오류 발생');
														}
													},
													error: function(){
														alert('네트워크 오류 발생');
													}
												});
											}
										});
									});
								</script>
							</c:if>
						</li>
					</ul>
					<div class="mt-3 mb-5 row justify-content-center">
					 <div class="col-auto">
						<input type="submit" class="btn btn-warning text-white" value="수정">
					 </div>
					 <div class="col-auto">
						<input type="button" class="btn btn-warning text-white" value="목록" onclick="location.href='list.do'">
					 </div>
					</div>
				</form>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>