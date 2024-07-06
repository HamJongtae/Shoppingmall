<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('search_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		const keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요');
			keyword.value = '';
			keyword.focus();
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
		<h2 class="pt-5 pb-3">게시판 목록</h2>
		<!-- 검색바 -->
		<div class="d-flex justify-content-between align-items-center rounded" style="background-color: #f5f6f9;">
			<div class="text-start ms-4 mt-5 mb-5" style="font-size: 15pt;">
				<b>총 ${count}건의 글이 있습니다.</b>
			</div>		
		<form id="search_form" action="list.do" method="get" class="d-flex justify-content-center">
			<div class="d-flex align-items-center ms-4 mt-5 mb-5">
					<select name="keyfield" class="form-select" style="width: auto; margin-right: 10px;">
						<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>작성자</option>
						<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
					</select>
					<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}" class="form-control rounded me-2">			
					<input type="submit" value="검색" class="btn btn-dark me-3" style="color: #CC66FF">
			</div>
		</form>
	</div>
		<div class="text-end mb-4">
			<input class="btn btn-dark" style="color: #CC66FF" type="button" value="글쓰기" onclick="location.href='writeForm.do'"
			    	<c:if test="${empty user_num}">disabled="disabled"</c:if>>
			<input class="btn btn-dark" style="color: #CC66FF" type="button" value="목록" onclick="location.href='list.do'">
			<input class="btn btn-dark" style="color: #CC66FF" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">        
		</div>
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 게시물이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table class="table table-hover mt-4">
			<thead class="table-dark text-center" style="color: #CC66FF">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회</th>
			</tr>
			</thead>
			<tbody class="text-center">
			<c:forEach var="board" items="${list}">
			<tr>
				<td>${board.board_num}</td>
				<td><a href="detail.do?board_num=${board.board_num}">${board.title}</a></td>
				<td>${board.id}</td>
				<td>${board.reg_date}</td>
				<td>${board.hit}</td>
			</tr>				
			</c:forEach>
			</tbody>
		</table>
		<div class="text-center mt-3 mb-3">${page}</div>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>






