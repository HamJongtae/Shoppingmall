<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 문의하기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">
window.onload = function(){
	const myForm = document.getElementById('write_form');
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
			<h2 class="mt-5 mb-5">고객 문의하기</h2>
				<form id="write_form" action="write.do" method="post" enctype="multipart/form-data">
					<ul class="list-unstyled">
						<li class="mb-2">
							<label for="qa_title">제목</label><br>
							<input type="text" class="form-control" name="qa_title" id="qa_title" maxlength="50">
						</li>
						<li class="mt-2">
							<label for="qa_content" class="fs-4 mb-2">내용</label><br>
							<textarea rows="20" cols="70" class="form-control" name="qa_content" id="qa_content"></textarea>
						</li>
						<li>
							<input type="file" class="form-control mt-3 mb-2" name="qa_photo" id="qa_photo" accept="image/gif, image/png, image/jpeg" multiple>
						</li>
					</ul>
					<div class="mt-3 mb-5 row justify-content-center">
					 <div class="col-auto">
						<input type="submit" class="btn btn-warning text-white" value="문의하기">
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