<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>카카오션</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<style>
	#carouselExampleIndicators {
		width: 100%;
		align:center: ;
	}
	.card-text{
	overflow:hidden; 
	text-overflow:ellipsis; 
	display: -webkit-box; 
	-webkit-line-clamp: 4; 
	-webkit-box-orient: vertical;
	}
</style>
</head>
<body>

	<!-- 배경색 -->
	<div style="background-color:#f7f7f7;">
	<!-- 메인 컨텐츠 시작 -->
	
		<!-- 표지화면 시작 -->
      <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
         <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="0" class="active btn btn-dark" aria-current="true" aria-label="Slide 1" ></button>
            <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="1" class="btn btn-dark" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExample" data-bs-slide-to="2" class="btn btn-dark" aria-label="Slide 3"></button>
         </div>
         <div class="carousel-inner">
            <div class="carousel-item active">
               <img src="${pageContext.request.contextPath}/images/carousel (1).jpg" class="detail-img mx-auto d-block w-20" style="width:100%; height: 450px;" alt="1화면" data-bs-toggle="modal" data-bs-target="#imageModal">
            </div>
            <div class="carousel-item">
               <img src="${pageContext.request.contextPath}/images/carousel (2).jpg" class="detail-img mx-auto d-block w-20" style="width:100%; height: 450px;" alt="2화면" data-bs-toggle="modal" data-bs-target="#imageModal">
            </div>
            <div class="carousel-item">
               <img src="${pageContext.request.contextPath}/images/carousel (3).jpg" class="detail-img mx-auto d-block w-20" style="height: 450px;" alt="3화면" data-bs-toggle="modal" data-bs-target="#imageModal">
            </div>
         </div>
         <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
             <span class="carousel-control-prev-icon" aria-hidden="true" style="filter: invert(100%) sepia(0%) saturate(7500%) hue-rotate(0deg) brightness(100%) contrast(100%);"></span>
             <span class="visually-hidden">Previous</span>
         </button>
         <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
             <span class="carousel-control-next-icon" aria-hidden="true" style="filter: invert(100%) sepia(0%) saturate(7500%) hue-rotate(0deg) brightness(100%) contrast(100%);"></span>
             <span class="visually-hidden">Next</span>
         </button>
      </div>
      <div class="container">
      <!-- 표지화면 끝 -->
		<!-- 모델검색 시작 -->
		<section id="model-find">
			<div class="container p-4">
				<h2>모델검색</h2>
				<div class="row" style="border: 2px solid #000; padding: 50px; margin: 50px 0;">
					<div class="input-group mb-3 row">
						<form id="search_form" action="${pageContext.request.contextPath}/buy/mainBuy.do" method="get" class="d-flex justify-content-center">
							<select id="keyfield" name="keyfield" class="form-select" style="width: auto;">
								<option value="1">제조사</option>
								<option value="2">차량</option>
							</select>
							<input type="search" id="keyword" name="keyword" class="form-control text-center" placeholder="원하는 제조사/차량을 검색하세요." aria-label="Search" aria-describedby="search-addon">
							<button type="submit" class="btn btn-warning fw-bold text-white btn-lg"><i class="bi bi-search"></i></button>
						</form>
					</div>
				</div>
			</div>
		</section>
		<!-- 모델검색 끝 -->
		 
		<!-- 공지사항시작 -->
		<section id="notice">
		<div class="container">
		<div class="row row-cols-1 row-cols-md-4 g-4">
			<div class="col">
			<a href="${pageContext.request.contextPath}/notice/list.do" class="text-decoration-none text-dark">
				<strong class="fs-3">공지사항</strong></a>
				<!-- 글이 없는 경우 -->
					<c:if test="${empty noticeList}">
						<div class="card" style="width: 18rem;">
							<a href="${pageContext.request.contextPath}/notice/list.do" class="d-flex justify-content-center align-items-center" style="height: 200px;">
	                        <i class="bi bi-megaphone" style="font-size: 5rem;"></i>
	                        </a>
	                        <div class="card-body" style="height: 160px;">
	                         	<h5 class="card-title text-truncate">공지사항이 없습니다</h5>
                            	<p class="card-text">현재 공지사항이 없습니다.</p> 
	                        </div>
	                    </div>
					</c:if>
					<!-- 글이 있는 경우 -->
					<c:if test="${!empty noticeList}">
					<c:forEach var="notice" items="${noticeList}" varStatus="status">
					<c:if test="${status.index == 0}">
						<div class="card" style="width: 18rem;">
							<c:if test="${!empty notice.notice_photo && fn:contains(notice.notice_photo, ',')}">
                            <c:set var="photoList" value="${fn:split(notice.notice_photo, ',')}" />
                            <c:set var="firstPhoto" value="${photoList[0]}" />
                            <a href="${pageContext.request.contextPath}/notice/detail.do?notice_num=${notice.notice_num}">
                            <img src="${pageContext.request.contextPath}/upload/${firstPhoto}" class="card-img-top" style="width:286px; height:200px;">
                            </a>
                        </c:if>
                        <c:if test="${!empty notice.notice_photo && !fn:contains(notice.notice_photo, ',')}">
                            <c:set var="firstPhoto" value="${notice.notice_photo}" />
                            <a href="${pageContext.request.contextPath}/notice/detail.do?notice_num=${notice.notice_num}">
                            <img src="${pageContext.request.contextPath}/upload/${notice.notice_photo}" class="card-img-top" style="width:286px; height:200px;">
                            </a>
                        </c:if>
                        <!-- 사진이 없는경우 -->
						<c:if test="${empty notice.notice_photo}">
                        	<a href="${pageContext.request.contextPath}/notice/detail.do?notice_num=${notice.notice_num}" class="d-flex justify-content-center align-items-center" style="height: 200px;">
                        	<i class="bi bi-megaphone" style="font-size: 5rem;"></i>
                        	</a>
                        </c:if>
							<div class="card-body" style="height: 160px;">
								<h5 class="card-title text-truncate">
								<a href="${pageContext.request.contextPath}/notice/detail.do?notice_num=${notice.notice_num}" class="text-decoration-none text-dark">
								${notice.notice_title}</a></h5>
								<p class="card-text" style="max-width:500px;">${notice.notice_content}</p>
							</div>
							<ul class="list-group list-group-flush">
								<c:forEach var="notice" items="${noticeList}" varStatus="status">
									<c:if test="${status.index > 0}">
										<li class="list-group-item text-truncate">
										<a href="${pageContext.request.contextPath}/notice/detail.do?notice_num=${notice.notice_num}" class="text-decoration-none text-dark">
										${notice.notice_title}
										</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</c:if>
				</c:forEach>
			</c:if>
				
		</div>
			<!-- 공지사항 끝 -->
			<!-- 이벤트 시작 -->
			<div class="col">
			<a href="${pageContext.request.contextPath}/event/list.do" class="text-decoration-none text-dark">
				<strong class="fs-3">이벤트</strong></a>
				<!-- 이벤트가 없을 경우 -->
				<c:if test="${empty EventList}">
					<div class="card" style="width: 18rem;">
							<a href="${pageContext.request.contextPath}/event/list.do" class="d-flex justify-content-center align-items-center" style="height: 200px;">
	                        <i class="bi bi-calendar-event" style="font-size: 5rem;"></i>
	                        </a>
	                        <div class="card-body" style="height: 160px;">
	                         	<h5 class="card-title text-truncate">이벤트가 없습니다</h5>
                            	<p class="card-text">현재 이벤트가 없습니다.</p> 
	                        </div>
	                    </div>
				</c:if>
				<!-- 이벤트가 있을 경우 -->
				<c:if test="${!empty EventList}">
				<c:forEach var="event" items="${EventList}" varStatus="status">
					<c:if test="${status.index == 0}">
						<div class="card" style="width: 18rem;">
                        <!-- 사진이 여러장일 경우 -->
						<c:if test="${!empty event.event_photo && fn:contains(event.event_photo, ',')}">
                            <c:set var="photoList" value="${fn:split(event.event_photo, ',')}" />
                            <c:set var="firstPhoto" value="${photoList[0]}" />
                            <a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event.event_num}">
                            <img src="${pageContext.request.contextPath}/upload/${firstPhoto}" class="card-img-top" style="width:286px; height:200px;">
                            </a>
                        </c:if>
                        <!-- 사진이 한 장일 경우 -->
                        <c:if test="${!empty event.event_photo && !fn:contains(event.event_photo, ',')}">
                            <c:set var="firstPhoto" value="${event.event_photo}" />
                            <a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event.event_num}">
                            <img src="${pageContext.request.contextPath}/upload/${event.event_photo}" class="card-img-top" style="width:286px; height:200px;">
                            </a>
                        </c:if>
                        <!-- 사진이 없는경우 -->
						<c:if test="${empty event.event_photo}">
                        	<a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event.event_num}" class="d-flex justify-content-center align-items-center" style="height: 200px;">
                        	<i class="bi bi-calendar-event" style="font-size: 5rem;"></i>
                        	</a>
                        </c:if>
							<div class="card-body" style="height: 160px;">
								<h5 class="card-title text-truncate">
								<a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event.event_num}" class="text-decoration-none text-dark">
								${event.event_title}</a></h5>
								<span class="card-text" style="max-width:500px;">
								${event.event_content}</span>
							</div>
							<ul class="list-group list-group-flush">
								<c:forEach var="event" items="${EventList}" varStatus="status">
									<c:if test="${status.index > 0}">
										<li class="list-group-item text-truncate">
										<a href="${pageContext.request.contextPath}/event/detail.do?event_num=${event.event_num}" class="text-decoration-none text-dark">
										${event.event_title}
										</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</c:if>
				</c:forEach>
			</c:if>
		</div>
			<!-- 이벤트 끝 -->
			<!-- 	 시작 -->
			<div class="col">
			<a href="${pageContext.request.contextPath}/news/list.do" class="text-decoration-none text-dark">
				 <strong class="fs-3">뉴스</strong></a>
				 <!-- 뉴스가 없을 경우 -->
				<c:if test="${empty NewsList}">
					<div class="card" style="width: 18rem;">
							<a href="${pageContext.request.contextPath}/news/list.do" class="d-flex justify-content-center align-items-center" style="height: 200px;">
	                        <i class="bi bi-newspaper" style="font-size: 5rem;"></i>
	                        </a>
	                        <div class="card-body" style="height: 160px;">
	                         	<h5 class="card-title text-truncate">뉴스가 없습니다</h5>
                            	<p class="card-text">현재 뉴스가 없습니다.</p> 
	                        </div>
	                    </div>
				</c:if>
				<!-- 뉴스가 있을 경우 -->
				<c:if test="${!empty NewsList}">
		            <c:forEach var="news" items="${NewsList}" varStatus="status">
		               <c:if test="${status.index == 0}">
		                  <div class="card" style="width: 18rem;">
		                     <c:if test="${!empty news.news_photo && fn:contains(news.news_photo, ',')}">
		                            <c:set var="photoList" value="${fn:split(news.news_photo, ',')}" />
		                            <c:set var="firstPhoto" value="${photoList[0]}" />
		                            <a href="${pageContext.request.contextPath}/news/detail.do?news_num=${news.news_num}">
		                            <img src="${pageContext.request.contextPath}/upload/${firstPhoto}" class="card-img-top" style="width:260px; height:200px;">
		                            </a>
		                        </c:if>
		                        <c:if test="${!empty news.news_photo && !fn:contains(news.news_photo, ',')}">
		                            <c:set var="firstPhoto" value="${news.news_photo}" />
		                            <a href="${pageContext.request.contextPath}/news/detail.do?news_num=${news.news_num}">
		                            <img src="${pageContext.request.contextPath}/upload/${news.news_photo}" class="card-img-top" style="width:286px; height:200px;">
		                            </a>
		                        </c:if>
		                         <!-- 사진이 없는경우 -->
								<c:if test="${empty news.news_photo}">
		                        	<a href="${pageContext.request.contextPath}/news/detail.do?news_num=${news.news_num}" class="d-flex justify-content-center align-items-center" style="height: 200px;">
		                        	<i class="bi bi-newspaper" style="font-size: 5rem;"></i>
		                        	</a>
		                        </c:if>
		                     <div class="card-body" style="height: 160px;">
		                        <h5 class="card-title text-truncate">
		                        <a href="${pageContext.request.contextPath}/news/detail.do?news_num=${news.news_num}" class="text-decoration-none text-dark">
		                        ${news.news_title}</a></h5>
		                        <span class="card-text" style="max-width:500px;">
		                        ${news.news_content}</span>
		                     </div>
		                     <ul class="list-group list-group-flush">
		                        <c:forEach var="news" items="${NewsList}" varStatus="status">
		                           <c:if test="${status.index > 0}">
		                              <li class="list-group-item text-truncate">
		                              <a href="${pageContext.request.contextPath}/news/detail.do?news_num=${news.news_num}" class="text-decoration-none text-dark">
		                              ${news.news_title}
		                              </a>
		                              </li>
		                           </c:if>
		                        </c:forEach>
		                     </ul>
		                  </div>
		               </c:if>
		            </c:forEach>
    			</c:if>
			</div>
			<!-- 뉴스 끝 -->
			<!-- 자유게시판 시작 -->
         <div class="col">
         <a href="${pageContext.request.contextPath}/board/list.do" class="text-decoration-none text-dark">
            <strong class="fs-3">자유게시판</strong></a>
             <!-- 자유게시판이 없을 경우 -->
				<c:if test="${empty BoardList}">
					<div class="card" style="width: 18rem;">
							<a href="${pageContext.request.contextPath}/board/list.do" class="d-flex justify-content-center align-items-center" style="height: 200px;">
	                        <i class="bi bi-people-fill" style="font-size: 5rem;"></i>
	                        </a>
	                        <div class="card-body" style="height: 160px;">
	                         	<h5 class="card-title text-truncate">자유게시판이 없습니다</h5>
                            	<p class="card-text">현재 자유게시판이 없습니다.</p> 
	                        </div>
	                    </div>
				</c:if>
				<!-- 자유게시판이 있을 경우 -->
				<c:if test="${!empty BoardList}">
		            <c:forEach var="board" items="${BoardList}" varStatus="status">
		               <c:if test="${status.index == 0}">
		                  <div class="card" style="width: 18rem;">
		                     <c:if test="${!empty board.board_photo && fn:contains(board.board_photo, ',')}">
		                            <c:set var="photoList" value="${fn:split(board.board_photo, ',')}" />
		                            <c:set var="firstPhoto" value="${photoList[0]}" />
		                            <a href="${pageContext.request.contextPath}/board/detail.do?board_num=${board.board_num}">
		                            <img src="${pageContext.request.contextPath}/upload/${firstPhoto}" class="card-img-top" style="width:286px; height:200px;">
		                            </a>
		                        </c:if>
		                        <c:if test="${!empty board.board_photo && !fn:contains(board.board_photo, ',')}">
		                            <c:set var="firstPhoto" value="${board.board_photo}" />
		                            <a href="${pageContext.request.contextPath}/board/detail.do?board_num=${board.board_num}">
		                            <img src="${pageContext.request.contextPath}/upload/${board.board_photo}" class="card-img-top" style="width:286px; height:200px;">
		                            </a>
		                        </c:if>
		                         <!-- 사진이 없는경우 -->
								<c:if test="${empty board.board_photo}">
		                        	<a href="${pageContext.request.contextPath}/board/detail.do?board_num=${board.board_num}" class="d-flex justify-content-center align-items-center" style="height: 200px;">
		                        	<i class="bi bi-people-fill" style="font-size: 5rem;"></i>
		                        	</a>
		                        </c:if>
		                     <div class="card-body" style="height: 160px;">
		                        <h5 class="card-title text-truncate">
		                        <a href="${pageContext.request.contextPath}/board/detail.do?board_num=${board.board_num}" class="text-decoration-none text-dark">
		                        ${board.board_title}</a></h5>
		                        <span class="card-text" style="max-width:500px;">
		                        ${board.board_content}</span>
		                     </div>
		                     <ul class="list-group list-group-flush">
		                        <c:forEach var="board" items="${BoardList}" varStatus="status">
		                           <c:if test="${status.index > 0}">
		                              <li class="list-group-item text-truncate">
		                              <a href="${pageContext.request.contextPath}/board/detail.do?board_num=${board.board_num}" class="text-decoration-none text-dark">
		                              ${board.board_title}
		                              </a>
		                              </li>
		                           </c:if>
		                        </c:forEach>
		                     </ul>
		                  </div>
		               </c:if>
		            </c:forEach>
		            </c:if>
         		</div>
         <!-- 자유게시판 끝 -->
		</div>
		</div>
		</section>
		<!-- 공지사항부터 자유게시판까지 끝 -->
		<!-- 구매 이용후기 시작 -->
		<section id="b_re">
			<div class="p-4 mt-4">
       		<a href="${pageContext.request.contextPath}/b_re/list.do" class="text-decoration-none text-dark"><strong class="fs-3">구매 이용후기</strong></a>
          	<!-- 구매이용후기이 없을 경우 -->
	        <c:if test="${empty list}">
	        	<div class="px-5 py-3 border rounded-3">구매 후기가 없습니다!</div>
			</c:if>
			<!-- 구매이용후기가 있을 경우 -->
       		<c:if test="${!empty list}">
       		<%
			    List<Object> list1 = new ArrayList<>();
			    List<Object> list2 = new ArrayList<>();
			    List<Object> list3 = new ArrayList<>();
			
			    List<Object> originalList = (List<Object>) request.getAttribute("list");
			    if (originalList != null) {
			        for (int i = 0; i < originalList.size(); i++) {
			            if (i < 3) {
			                list1.add(originalList.get(i));
			            } else if (i < 6) {
			                list2.add(originalList.get(i));
			            } else {
			                list3.add(originalList.get(i));
			            }
			        }
			    }
			    request.setAttribute("list1", list1);
			    request.setAttribute("list2", list2);
			    request.setAttribute("list3", list3);
			%>
			
			
			<!-- 첫번째 캐러셀 -->
           	<div id="cardCarousel" class="carousel slide row" data-bs-ride="carousel">
	           		<button class="carousel-control-prev" type="button" data-bs-target="#cardCarousel" data-bs-slide="prev">
			            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			            <span class="visually-hidden">Previous</span>
			        </button>
	        	<div class="carousel-inner">
	            	<div class="carousel-item active">
	                	<div class="row p-2">
	                		<c:forEach var="b_re" items="${list1}" varStatus="status">
								<c:if test="${fn:contains(b_re.car_photo, ',')}">
				 					<c:set var="photoList" value="${fn:split(b_re.car_photo, ',')}" />
					   				<c:set var="firstPhoto" value="${photoList[0]}"/>
					   			</c:if>
								<c:if test="${!fn:contains(b_re.car_photo, ',')}">
									<c:set var="firstPhoto" value="${b_re.car_photo}" />
								</c:if>
								<div class="col-md-4">
		                        	<div class="card" style="width:370px; height: 370px;">
	                            		<a href="${pageContext.request.contextPath}/b_re/detail.do?b_re_num=${b_re.b_re_num}">
	                            			<img src="${pageContext.request.contextPath}/upload/${firstPhoto}" class="card-img-top" style="height:200px; !important">
	                            		</a>
		                            	<div class="card-body" style="overflow:hidden;">
		                                	<h5 class="card-title" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="${pageContext.request.contextPath}/b_re/detail.do?b_re_num=${b_re.b_re_num}" class="text-decoration-none text-dark fw-bold">${b_re.b_re_title}</a></h5>
		                                	<div class="card-text" style="height:70px; heiwhite-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="${pageContext.request.contextPath}/b_re/detail.do?b_re_num=${b_re.b_re_num}" class="text-decoration-none text-dark">${b_re.b_re_content }</a></div>
		                            		<div class="card-text small text-secondary mt-2">${fn:substring(b_re.b_re_reg,0,11)}</div>
		                            	</div>
	                        		</div>
		                    	</div>
							</c:forEach>
	                	</div>
	            	</div>
	            	
	            	<!-- 2번째 케러셀 -->
	            	<c:if test="${count>2}">
	            	<div class="carousel-item">
	                	<div class="row p-2">
	                		<c:forEach var="b_re" items="${list2}" varStatus="status">
								<c:if test="${fn:contains(b_re.car_photo, ',')}">
				 					<c:set var="photoList" value="${fn:split(b_re.car_photo, ',')}" />
					   				<c:set var="firstPhoto" value="${photoList[0]}"/>
					   			</c:if>
								<c:if test="${!fn:contains(b_re.car_photo, ',')}">
									<c:set var="firstPhoto" value="${b_re.car_photo}" />
								</c:if>
								<div class="col-md-4">
		                        	<div class="card" style="width:370px; height: 370px;">
	                            		<a href="${pageContext.request.contextPath}/b_re/detail.do?b_re_num=${b_re.b_re_num}">
	                            			<img src="${pageContext.request.contextPath}/upload/${firstPhoto}" class="card-img-top" style="height:200px; !important">
	                            		</a>
		                            	<div class="card-body" style="overflow:hidden;">
		                                	<h5 class="card-title" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="${pageContext.request.contextPath}/b_re/detail.do?b_re_num=${b_re.b_re_num}" class="text-decoration-none text-dark fw-bold">${b_re.b_re_title}</a></h5>
		                                	<div class="card-text" style="height:70px; heiwhite-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="${pageContext.request.contextPath}/b_re/detail.do?b_re_num=${b_re.b_re_num}" class="text-decoration-none text-dark">${b_re.b_re_content }</a></div>
		                            		<div class="card-text small text-secondary mt-2">${fn:substring(b_re.b_re_reg,0,11)}</div>
		                            	</div>
	                        		</div>
		                    	</div>
							</c:forEach>
	                	</div>
	            	</div>
	            	</c:if>
	            	
     		        <!-- 3번째 케러셀 -->
	            	<c:if test="${count>6}">
	            	<div class="carousel-item">
	                	<div class="row p-2">
	                		<c:forEach var="b_re" items="${list3}" varStatus="status">
								<c:if test="${fn:contains(b_re.car_photo, ',')}">
				 					<c:set var="photoList" value="${fn:split(b_re.car_photo, ',')}" />
					   				<c:set var="firstPhoto" value="${photoList[0]}"/>
					   			</c:if>
								<c:if test="${!fn:contains(b_re.car_photo, ',')}">
									<c:set var="firstPhoto" value="${b_re.car_photo}" />
								</c:if>
								<div class="col-md-4">
		                        	<div class="card" style="width:370px; height: 370px;">
	                            		<a href="${pageContext.request.contextPath}/b_re/detail.do?b_re_num=${b_re.b_re_num}">
	                            			<img src="${pageContext.request.contextPath}/upload/${firstPhoto}" class="card-img-top" style="height:200px; !important">
	                            		</a>
		                            	<div class="card-body" style="overflow:hidden;">
		                                	<h5 class="card-title" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="${pageContext.request.contextPath}/b_re/detail.do?b_re_num=${b_re.b_re_num}" class="text-decoration-none text-dark fw-bold">${b_re.b_re_title}</a></h5>
		                                	<div class="card-text" style="height:70px; heiwhite-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="${pageContext.request.contextPath}/b_re/detail.do?b_re_num=${b_re.b_re_num}" class="text-decoration-none text-dark">${b_re.b_re_content }</a></div>
		                            		<div class="card-text small text-secondary mt-2">${fn:substring(b_re.b_re_reg,0,11)}</div>
		                            	</div>
	                        		</div>
		                    	</div>
							</c:forEach>
	                	</div>
	            	</div>
	            	</c:if>
	        	</div>
		        <button class="carousel-control-next" type="button" data-bs-target="#cardCarousel" data-bs-slide="next">
		            <span class="carousel-control-next-icon" aria-hidden="true"></span>
		            <span class="visually-hidden">Next</span>
		        </button>
        	</div>
     		</c:if>
     		</div>
		</section>
<!-- 구매 이용후기 끝-->

   <!-- 판매 이용후기 시작 -->
<section id="s_re1">
    <div class="p-4">
        <a href="${pageContext.request.contextPath}/s_re/list.do" class="text-decoration-none text-dark">
            <strong class="fs-3">판매이용후기</strong>
            <span class="float-end text-warning">더보기<i class="bi bi-chevron-right text-warning"></i></span>
        </a>
        <!-- 판매 이용후기가 없을 때 -->
        <c:if test="${empty S_relist}">
	       <div class="border rounded-4 bg-white">
	        	<div class="d-flex justify-content-start">
	        		<p class="border rounded mt-2 ms-2 mb-4 me-4 bg-light p-2" style="font-size:13px;">&nbsp</p>
	        	</div>
	        	<div class="d-flex justify-content-between">
	        		<div class="ms-5">
	        			<h5 class="fw-bold">후기 제목 없음</h5>
	        		</div>
	        		<div class="me-5">
	        			<p>&nbsp</p>
	        		</div>
	        	</div>
	        	<div class="fw-bold mx-5 p-1 mb-3" style="height:100px; overflow: hidden;">
	        		후기 내용 없음
	        	</div>
	        	<div class="small mx-5 my-3 text-secondary">
	        		&nbsp
	        	</div>
	        </div>
        </c:if>
        <!-- 판매 이용후기가 있을 때 -->
        <c:if test="${!empty S_relist}">
        <c:forEach var="s_re" items="${S_relist}" varStatus="loop">
            <div class="border rounded-4 bg-white my-2">
	        	<div class="d-flex justify-content-start">
	        		<p class="border rounded mt-2 ms-2 mb-4 me-4 bg-light p-2" style="font-size:13px;"><a href="${pageContext.request.contextPath}/s_re/detail.do?s_re_num=${s_re.s_re_num}" class="text-decoration-none text-secondary">${s_re.sell_maker} ${s_re.sell_cname}</a></p>
	        	</div>
	        	<div class="d-flex justify-content-between">
	        		<div class="ms-5">
	        			<h5 class="fw-bold"><a href="${pageContext.request.contextPath}/s_re/detail.do?s_re_num=${s_re.s_re_num}" class="text-decoration-none text-dark fw-bold">${s_re.s_re_title}</a></h5>
	        		</div>
	        		<div class="me-5">
	        			<p><a href="${pageContext.request.contextPath}/s_re/detail.do?s_re_num=${s_re.s_re_num}" class="text-decoration-none text-dark">${s_re.mem_id}</a></p>
	        		</div>
	        	</div>
	        	<div class="fw-bold mx-5 p-1 mb-3" style="height:100px; overflow: hidden;">
	        		<a href="${pageContext.request.contextPath}/s_re/detail.do?s_re_num=${s_re.s_re_num}" class="text-decoration-none text-dark fw-bold">${s_re.s_re_content}</a>
	        	</div>
	        	<div class="small mx-5 my-3 text-secondary">
	        		${fn:substring(s_re.s_re_reg,0,10)}
	        	</div>
	        </div>
        </c:forEach>
        </c:if>
    </div>
</section>
<!-- 판매 이용후기 끝 -->

<!-- 중고거래 인기매물순 시작 -->
<section id="item">
	<div class="container p-4 position-relative">
		<strong class="fs-3">중고거래 인기매물</strong>
            <a href="${pageContext.request.contextPath}/item/itemList.do" class="text-decoration-none text-warning">
            	<span class="float-end">더 구경하기<i class="bi bi-chevron-right"></i>
            	</span>
            </a>
		<!-- 중고거래가 없을 때 -->
        <c:if test="${empty itemList}">
	        <div class="table-responsive rounded-4 border border-secondary-subtle">
	                <table class="table table-borderless mb-0">
	                    <tbody>
	                    	<tr>
                                <td class="m-1 p-1">
                                    <a href="${pageContext.request.contextPath}/item/itemList.do" class="text-decoration-none text-dark ms-5">
                                        <strong class="fs-5">판매중인 중고가 없습니다</strong>
                                    </a>
                                </td>
                                <td colspan="2" class="text-end">
                                    <a href="${pageContext.request.contextPath}/item/itemList.do" class="text-decoration-none text-dark me-5">
                                        [중고를 판매하려는 작성자가 없습니다]
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="me-5 pe-5">
                                    <a href="${pageContext.request.contextPath}/item/itemList.do" class="text-decoration-none text-dark ms-5 card-text">
                                        <b>판매중인 중고가 없습니다</b>
                                    </a>
                                </td>
                            </tr>
	                    </tbody>
	                </table>
	        </div>
        </c:if>
        <!-- 중고거래가 있을 때 -->
        <c:if test="${!empty itemList}">
        	<div class="row justify-content-start my-3 px-3 rounded" style="background-color:white; border: 1px solid #c5c7c9;">
				<c:forEach var="item" items="${itemList}" varStatus="loop">
					<c:if test="${fn:contains(item.item_photo, ',')}">
						<c:set var="photoList" value="${fn:split(item.item_photo, ',')}" />
						<c:set var="firstPhoto" value="${photoList[0]}"/>
					</c:if>
					<c:if test="${!fn:contains(item.item_photo, ',')}">
						<c:set var="firstPhoto" value="${item.item_photo}" />
					</c:if>
					<div class="col-3 mx-5 my-3">
						<div class="text-center px-3">
							<c:if test="${empty firstPhoto}">
								<a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}"><img src="${pageContext.request.contextPath}/images/logo.png" style="width:270px; height:200px;" class="border rounded-4 image-container"></a>
							</c:if>
							<c:if test="${!empty firstPhoto}">
								<a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}"><img src="${pageContext.request.contextPath}/upload/${firstPhoto}" style="width:270px; height:200px;" class="border rounded-4 image-container"></a>
							</c:if>
						</div>
						<div class="px-3">
							<div class="float-start"><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}" class="text-decoration-none text-secondary fw-bold small">${fn:substring(item.item_reg, 0, 10)}</a></div>
							<div class="text-end"><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}" class="text-decoration-none text-dark fw-bold small">${item.member.mem_id}</a></div>
							<div class="overflow-hidden my-1" style="height:30px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><c:if test="${fn:contains(item.item_reg,'초미만') or fn:contains(item.item_reg,'초 전') or fn:contains(item.item_reg,'분 전')}"><span class="badge bg-danger me-2">New</span></c:if><a href="itemDetail.do?item_num=${item.item_num}" class="text-decoration-none text-dark overflow-hidden">${item.item_name}</a></div>
							<div class="my-1"><a href="${pageContext.request.contextPath}/item/itemDetail.do?item_num=${item.item_num}" class="text-decoration-none text-dark fw-bold"><fmt:formatNumber value="${item.item_price}" type="number"/>원</a></div>
							<div class="small mt-2">${item.member.mem_address1}</div>
							<div class="small text-secondary">채팅 ${item.item_chatCount} ∙ 조회 ${item.item_views}</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
</section>
		<!-- 중고거래 인기매물순 끝 -->
    <!-- 메인 컨텐츠 끝 -->
    	</div>
    </div>
    <!-- 배경색 끝 -->
    <!-- 챗봇 시작-->
    <!--챗봇 끝  -->

	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>