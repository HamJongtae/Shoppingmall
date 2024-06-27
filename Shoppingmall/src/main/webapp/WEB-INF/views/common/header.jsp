<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<title>Header</title>
<!-- bootstrap css cdn 링크 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
/* 메뉴 hover 방식 */
.dropdown:hover .dropdown-menu {
    display: block;
    margin-top: 0;
}
/* 메뉴 간격 조정 */
.nav-item { 
    margin-left: 30px;
}
.nav-link{
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container-fluid rounded-bottom" style="padding-left:0; padding-right:0; background-color:#82F9B7;">
		<!-- nav태그 상단 고정 -->
		<nav class="navbar navbar-expand-lg" style="height:100px;"> 
			<div class="container">
			<!-- 로고 시작 -->
			<div>
			
			</div>
			<!-- 로고 끝 -->
			<!-- 메뉴 시작 -->
			<div class="collapse navbar-collapse justify-content-between">
				<ul class="nav justify-content-center">
					<!-- 첫 번째 메뉴 -->
					<li class="nav-item dropdown"><a>상의</a>
						<div class="dropdown-menu">
							<a class="dropdown-item">아우터</a>
							<a class="dropdown-item">긴소매 티셔츠</a>
							<a class="dropdown-item">반소매 티셔츠</a>	
						</div>
					</li>
					<!-- 두 번째 메뉴 -->
					<li class="nav-item dropdown"><a>하의</a>
						<div class="dropdown-menu">
							<a class="dropdown-item">데님 팬츠</a>
							<a class="dropdown-item">슈트 팬츠/슬랙스</a>
							<a class="dropdown-item">숏팬츠</a>
						</div>
					</li>
					<!-- 세 번째 메뉴 -->
					<li class="nav-item dropdown"><a>모자/가방</a>
						<div class="dropdown-menu">
							<a class="dropdown-item">모자</a>
							<a class="dropdown-item">가방</a>
						</div>
					</li>
					<!-- 네 번째 메뉴 -->
					<li class="nav-item dropdown"><a>악세서리</a>
						<div class="dropdown-menu">
							<a class="dropdown-item">안경</a>
							<a class="dropdown-item">팔찌</a>
							<a class="dropdown-item">목걸이</a>
						</div>
					</li>
					<!-- 다섯 번째 메뉴 -->
					<li class="nav-item dropdown"><a>커뮤니티</a>
						<div class="dropdown-menu">
							<a class="dropdown-item">자유게시판</a>
							<a class="dropdown-item">이벤트</a>
						</div>
					</li>
					<!-- 여섯 번째 메뉴 -->
					<li class="nav-item dropdown"><a>고객센터</a>
						<div class="dropdown-menu">
							<a class="dropdown-item">공지사항</a>
							<a class="dropdown-item">자주하는 질문</a>
						</div>
					</li>
				</ul>
				<!-- 로그인 시작 -->
				<c:if test="${empty user_num}">
				<div class="d-flex justify-content-center">
					<a class="myLink" href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a>
				</div>
				</c:if>
				<c:if test="${!empty user_num}">
					<div class="d-flex justify-content-center">
						<a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a>
					</div>
					<div class="d-flex justify-content-center">
						<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
					</div>
				</c:if>	
				
				<!-- 로그인 끝 -->
			</div>
			<!-- 메뉴 끝 -->	
			</div>	
		</nav>
	</div>
</body>
</html>