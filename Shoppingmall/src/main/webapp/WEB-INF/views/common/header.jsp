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
	<div class="container-fluid rounded-bottom" style="padding-left:0; padding-right:0; background-color:#000;">
		<!-- nav태그 상단 고정 -->
		<nav class="navbar navbar-expand-lg" style="height:100px;"> 
			<div class="container">
			<!-- 로고 시작 -->
			<div>
				<a href="${pageContext.request.contextPath}/main/main.do" class="navbar-brand"><img src="${pageContext.request.contextPath}/images/쇼핑몰로고.png" height="100" width="200"></a>
			</div>
			<!-- 로고 끝 -->
			<!-- 메뉴 시작 -->
			<div class="collapse navbar-collapse justify-content-between" style="color: #CC66FF">
				<ul class="nav justify-content-center">
					<!-- 첫 번째 메뉴 -->
					<li class="nav-item dropdown"><a><b>상의</b></a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/item/itemList.do">아우터</a>
							<a class="dropdown-item">긴소매 티셔츠</a>
							<a class="dropdown-item">반소매 티셔츠</a>	
						</div>
					</li>
					<!-- 두 번째 메뉴 -->
					<li class="nav-item dropdown"><a><b>하의</b></a>
						<div class="dropdown-menu">
							<a class="dropdown-item">데님 팬츠</a>
							<a class="dropdown-item">슈트 팬츠/슬랙스</a>
							<a class="dropdown-item">숏팬츠</a>
						</div>
					</li>
					<!-- 세 번째 메뉴 -->
					<li class="nav-item dropdown"><a><b>모자/가방</b></a>
						<div class="dropdown-menu">
							<a class="dropdown-item">모자</a>
							<a class="dropdown-item">가방</a>
						</div>
					</li>
					<!-- 네 번째 메뉴 -->
					<li class="nav-item dropdown"><a><b>악세서리</b></a>
						<div class="dropdown-menu">
							<a class="dropdown-item">안경</a>
							<a class="dropdown-item">팔찌</a>
							<a class="dropdown-item">목걸이</a>
						</div>
					</li>
					<!-- 다섯 번째 메뉴 -->
					<li class="nav-item dropdown"><a><b>커뮤니티</b></a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/board/list.do">자유게시판</a>
						</div>
					</li>
					<!-- 여섯 번째 메뉴 -->
					<li class="nav-item dropdown"><a><b>고객센터</b></a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="${pageContext.request.contextPath}/qa/list.do">고객 문의</a>
						</div>
					</li>
					<c:if test="${user_auth == 9}">
						<li class="nav-item dropdown"><a><b>관리자</b></a>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="${pageContext.request.contextPath}/item/adminList.do">상품관리</a>
							</div>
						</li>
					</c:if>
				</ul>
				<!-- 로그인 시작 -->
				<c:if test="${empty user_num}">
				<div class="d-flex justify-content-center" style="color: #CC66FF">
					<a class="text-decoration-none myLink" style="color: #CC66FF" href="${pageContext.request.contextPath}/member/loginForm.do"><b>로그인</b></a>
				</div>
				</c:if>
				<c:if test="${!empty user_num}">
					<div class="d-flex justify-content-center">
						<a class="text-decoration-none me-5" style="color: #CC66FF" href="${pageContext.request.contextPath}/member/myPage.do"><b>MY페이지</b></a>
						<a class="text-decoration-none" style="color: #CC66FF" href="${pageContext.request.contextPath}/member/logout.do"><b>로그아웃</b></a>
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