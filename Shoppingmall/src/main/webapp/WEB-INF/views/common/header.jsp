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
<!-- bootstrap 아이콘 cdn 링크 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/logo.png"/>
<style>

@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap');
.noto-sans-kr-<uniquifier> {
  font-family: "Noto Sans KR", sans-serif;
  font-optical-sizing: auto;
  font-weight: <weight>;
  font-style: normal;
}
/* 메뉴 hover 방식 */
.dropdown:hover .dropdown-menu {
    display: block;
    margin-top: 0;
}
/* 메뉴 간격 조정 */
.nav-item {
    margin-left: 30px;
}
/* 로고 크기 및 위치 조정 */
.navbar-brand img {
    max-height: 150px;
}
.myLink:link {
  color : white;
}
.myLink:visited {
  color : white;
}
.nav-link{
	cursor: pointer;
}
.myLink{
	text-decoration-line: none;
}
.text-white a,
.text-white i {
    color: white !important;
}

</style>
</head>
<body style="font-family:Noto Sans KR;">
    <!-- continer 기본 padding값 때문에 로그아웃 회원가입이 밀려서 일단 임시조치로 left right 0으로 처리 -->
    <div class="container-fluid rounded-bottom" style="padding-left:0; padding-right:0; background-color:#1C1C1C;">
      <!-- nav태그 상단 고정 -->
      <nav class="navbar navbar-expand-lg" style="height:100px;">
         <div class="container">
            <!-- 로고 시작 -->
           
           
           
           
            <!-- 로고 끝 -->
            <!-- 메뉴 시작 -->
            <div class="collapse navbar-collapse justify-content-between" id="nav">
               <ul class="navbar-nav">
               	  <!-- 첫번째 메뉴 -->
                  <li class="nav-item dropdown"><a class="nav-link text-white px-3 fs-5 fw" data-toggle="dropdown">차량 판매</a>
                     <div class="dropdown-menu">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/sell/mainSell.do">차량 판매</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/s_re/list.do">차량 판매 후기</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/sell/mySellList.do">내 판매 현황</a>
                     </div>
                  </li>
                  <!-- 두번째 메뉴 -->
                  <li class="nav-item dropdown"><a class="nav-link text-white px-3 fs-5 fw" data-toggle="dropdown">차량 구매</a>
                     <div class="dropdown-menu">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/buy/mainBuy.do">차량 구매</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/b_re/list.do">차량 구매 후기</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/fav/myFavList.do">내 관심 차량</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/buy/myBought.do">내 구매 목록</a>
                     </div>
                  </li>
                  <!-- 세번째 메뉴 -->
                  <li class="nav-item dropdown"><a class="nav-link text-white px-3 fs-5 fw" data-toggle="dropdown">커뮤니티</a>
                     <div class="dropdown-menu">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/board/list.do">자유게시판</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/info_board/list.do">정보공유 게시판</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/news/list.do">자동차 뉴스</a>
                     </div>
                  </li>
                  <!-- 네번째 메뉴 -->
                  <li class="nav-item dropdown"><a class="nav-link text-white px-3 fs-5 fw" data-toggle="dropdown">고객 센터</a>
                     <div class="dropdown-menu">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/notice/list.do">공지사항</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/event/list.do">이벤트</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/qa/list.do">고객 문의</a>
                     </div>
                  </li>
                  <!-- 다섯번째 메뉴 -->
                  <li class="nav-item dropdown"><a class="nav-link text-white px-3 fs-5 fw" data-toggle="dropdown" href="${pageContext.request.contextPath}/item/itemList.do">중고거래</a>
                  </li>
                  
                  <c:if test="${!empty user_num && user_auth ==9}">   
                   <li class="nav-item dropdown"><a class="nav-link text-white px-3 fs-5 fw" data-toggle="dropdown">관리자</a>
                     <div class="dropdown-menu">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/sell/adminSellList.do">검수 요청 관리</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/checker/adminCheckerList.do">검수자 정보 관리</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/buy/adminBuyList.do">차량 구매 관리</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/board/adminReportList.do">신고 누적 관리</a>
                     </div>
                  </li>
                  </c:if>
               </ul>
               <!-- 로그인 및 회원가입 시작 -->
               <c:if test="${empty user_num}">
               <div class="d-flex justify-content-center">
                  <i class="bi bi-person-fill pe-3 text-white"> <a class="myLink text-white" href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a></i>
                  <div class="border-end"></div>
                  <i class="bi bi-person-fill-add ps-3 text-white"> <a class="myLink text-white" href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a></i>
               </div>
               </c:if>
               <!-- 로그인 및 회원가입 끝 -->
               <!-- 로그인시 로그인 , 로그아웃 -->
               <c:if test="${!empty user_num}">
               <div class="d-flex justify-content-center">
               	  <c:if test = "${!empty user_num && user_auth != 9}">
                  <i class="bi bi-person-fill-gear pe-3 text-white"><a class="myLink text-white" href="${pageContext.request.contextPath}/member/myPage.do">MyPage</a></i>
                  <div class="border-end"></div>
                  </c:if>
                  <i class="bi bi-person-fill-dash ps-3 text-white"><a class="myLink text-white" href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a></i>
               </div>
               </c:if>
            </div>
         </div>
      </nav>
   </div>
</body>
</html>