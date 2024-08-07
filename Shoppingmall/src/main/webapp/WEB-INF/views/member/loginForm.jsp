<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#login_form').submit(function() {
			if ($('#id').val().trim() == '') {
				alert('아이디를 입력하세요');
				$('#id').val('').focus();
				return false;
			}
			if ($('#passwd').val().trim() == '') {
				alert('비밀번호를 입력하세요');
				$('#passwd').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container pt-5 text-center" style="margin-bottom: 150px;">
		<div class="row justify-content-center">
			<div class="col-md-6">

				<!-- 로그인 폼 -->
				<form id="login_form" action="login.do" method="post" class="p-3 rounded-4 bg-light">
					<h2 class="text-center mt-2 mb-3" style="color: #CC66FF">
						<b>로그인</b>
					</h2>
					<div>
						<div class="form-group">
							<input type="text"class="form-control" placeholder="아이디" name="id" id="id"
								maxlength="12" autocomplete="off" style="width: 80%; margin: 0 auto;">
							<label for="id"></label>
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호" name="passwd" id="passwd"
								maxlength="12" style="width: 80%; margin: 0 auto;"> <label for="passwd"></label>
						</div>
					</div>
					<div class="align-center">
						<input class="btn btn-dark" style="color: #CC66FF" type="submit" value="로그인"> 
						<input class="btn btn-dark" style="color: #CC66FF" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
						<input class="btn btn-dark" style="color: #CC66FF" type="button" value="회원가입" onclick="location.href='${pageContext.request.contextPath}/member/registerUserForm.do'">
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>






