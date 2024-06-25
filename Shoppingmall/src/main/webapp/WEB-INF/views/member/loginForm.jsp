<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>로그인</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#login_form').submit(function(){
		if($('#id').val().trim()==''){
			alert('아이디를 입력하세요');
			$('#id').val('').focus();
			return false;
		}
		if($('#passwd').val().trim()==''){
			alert('비밀번호를 입력하세요');
			$('#passwd').val('').focus();
			return false;
		}
	});
});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>로그인</h2>
		<form id="login_form" action="login.do" method="post">
			<ul>
				<li class="floating-label">
					<input type="text" class="form-input"
					  placeholder="아이디" name="id" id="id"
					  maxlength="12" autocomplete="off">
					<label for="id">아이디</label>
				</li>
				<li class="floating-label">
					<input type="password" class="form-input"
					  placeholder="비밀번호" name="passwd" id="passwd"
					  maxlength="12">
					<label for="passwd">비밀번호</label>
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="로그인">
				<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				<input type="button" value="회원가입" onclick="location.href='${pageContext.request.contextPath}/member/registerUserForm.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>






