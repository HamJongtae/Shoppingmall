<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('write_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		const title = document.getElementById('title');
		if(title.value.trim()==''){
			alert('제목을 입력하세요');
			title.value = '';
			title.focus();
			return false;
		}
		const content = document.getElementById('content');
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
		<h2 class="ms-5 mt-5 mb-5">게시판 글쓰기</h2>
		<form id="write_form" action="write.do" method="post" enctype="multipart/form-data" class="p-5 rounded-5 bg-light mb-5" style="width: 80%; margin: 0 auto;">
			<ul class="list-unstyled">
				<li class="mb-2">
					<label for="title" class="fs-4 mb-2 ms-5">제목</label>
					<input class="form-control" type="text" name="title" id="title" maxlength="50" style="width: 80%;margin: 0 auto;">
				</li>
				<li class="mt-2">
					<label for="content" class="fs-4 mb-2 ms-5">내용</label>
					<textarea class="form-control" rows="5" cols="40" name="content" id="content" style="width: 80%;margin: 0 auto;"></textarea>
				</li>
				<li>
					<input type="file" class="form-control mt-3 mb-2" name="filename" id="filename" accept="image/gif,image/png,image/jpeg"
								style="width: 80%;margin: 0 auto;">
				</li>
			</ul>   
			<div class="text-center">
				<input class="btn btn-dark" style="color: #CC66FF" type="submit" value="등록">
				<input class="btn btn-dark" style="color: #CC66FF" type="button" value="목록" onclick="location.href='list.do'">
			</div>                     
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>







