<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리</title>
<style type="text/css">
.result-display{
	width:400px;
	height:200px;
	margin:50px auto;
	border:1px solid #000;
	display:flex;
	align-items:center;/*세로 정렬*/
	justify-content:center;/*가로 정렬*/
}
</style>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
		<h2 class="ms-3 mt-3 mb-3">상품관리</h2>
		<!-- 검색바 -->
        <div class="d-flex justify-content-center rounded" style="background-color:#f5f6f9;">
			<form id="search_form" action="adminList.do" method="get">
				<div class="d-flex align-items-center m-5">
					<select id="keyfield" name="keyfield" class="form-select" style="width:auto; margin-right:10px;">
						<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>상품명</option>
						<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
					</select>
					<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}" class="form-control rounded me-2">			
					<input type="submit" value="검색" class="btn btn-dark me-3" style="color: #CC66FF">
				</div>
			</form>
		</div>
		<div class="text-end mb-4">
			<c:if test="${user_auth == 9}">
			<input class="btn btn-dark" style="color: #CC66FF" type="button" value="상품 등록" onclick="location.href='adminWriteForm.do'">
			</c:if>
			<input class="btn btn-dark" style="color: #CC66FF" type="button" value="목록" onclick="location.href='adminList.do'">
			<input class="btn btn-dark" style="color: #CC66FF" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">        
		</div>
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 상품이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
			<div class="container">
             	<div class="row mb-3">
             	<c:forEach var="item" items="${list}" begin="0" end="11" varStatus="status">
             		<div class="col-4 mt-3">
		                <div class="p-3 border bg-light">
		                	<!-- 사진 상자 -->
		                	<div class="image-container ps-3">
			                	<a href="detail.do?item_num=${item.item_num}">
			                		<img src="${pageContext.request.contextPath}/upload/${item.photo}" style="width:270px; height:200px;" class="img-fluid img-thumbnail rounded-4 img-fluid">
		                		</a>
		                	</div>
		                	<!-- 설명 -->
		                	<div>
			                	<div class="fs-5 mt-3 fw-bold" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="detail.do?item_num=${item.item_num}" class="menu-name">${item.name}</a></div>
			                	<p class="mt-3"><a href="detail.do?item_num=${item.item_num}" class="menu-name"><b><fmt:formatNumber value="${item.price}"/>원</b></a></p>         	
		                	</div>
		                </div>
		            </div>
       			</c:forEach>		
           		</div>
             </div>
		<div class="text-center mt-3 mb-3">${page}</div>
		</c:if>
	</div>
</div>
</body>
</html>






