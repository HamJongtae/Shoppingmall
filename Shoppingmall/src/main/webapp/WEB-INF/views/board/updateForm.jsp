<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('update_form');
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
		<h2 class="ms-5 mt-5 mb-5">게시판 글수정</h2>
		<form id="update_form" action="update.do" method="post" enctype="multipart/form-data" class="p-5 rounded-5 bg-light mb-5" style="width: 80%; margin: 0 auto;">
			<input type="hidden" name="board_num"  value="${board.board_num}">
			<ul class="list-unstyled">
				<li class="mb-2">
					<label for="title" class="fs-4 mb-2 ms-5">제목</label>
					<input class="form-control" type="text" name="title" id="title" value="${board.title}" maxlength="50" style="width: 80%;margin: 0 auto;">
				</li>
				<li class="mt-2">
					<label for="content" class="fs-4 mb-2 ms-5">내용</label>
					<textarea class="form-control" rows="5" cols="40" name="content" id="content" style="width: 80%;margin: 0 auto;">${board.content}</textarea>
				</li>
				<li>
					<input class="form-control mt-3 mb-2" type="file" name="filename" id="filename" accept="image/gif,image/png,image/jpeg" style="width: 80%;margin: 0 auto;">
					<c:if test="${!empty board.filename}">
					<div id="file_detail">
					<img src="${pageContext.request.contextPath}/upload/${board.filename}" width="100">
					<br>
					<input class="btn btn-dark" style="color: #CC66FF" type="button" value="파일 삭제" id="file_del">
					</div>
					<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
					<script type="text/javascript">
						$(function(){
							$('#file_del').click(function(){
								let choice = confirm('삭제하시겠습니까?');
								if(choice){
									//서버와 통신
									$.ajax({
										url:'deleteFile.do',
										type:'post',
										data:{board_num:${board.board_num}},
										dataType:'json',
										success:function(param){
											if(param.result == 'logout'){
												alert('로그인 후 사용하세요');
											}else if(param.result == 'success'){
												$('#file_detail').hide();
											}else if(param.result == 'wrongAccess'){
												alert('잘못된 접속입니다.');
											}else{
												alert('파일 삭제 오류 발생');
											}
										},
										error:function(){
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
			<div class="text-center">
				<input class="btn btn-dark" style="color: #CC66FF" type="submit" value="수정">
				<input class="btn btn-dark" style="color: #CC66FF" type="button" value="목록" onclick="location.href='list.do'">
			</div>                     
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>







