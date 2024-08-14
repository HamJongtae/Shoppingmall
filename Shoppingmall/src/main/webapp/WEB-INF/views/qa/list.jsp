<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>고객 문의</title>
<script type="text/javascript">
	window.onload = function(){
		const myForm = document.getElementById('search_form');
		//이벤트 연결
		myForm.onsubmit = function(){
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
		<h2 class="pt-5 pb-3">고객 문의</h2>
			<!-- 검색바 -->
				<div class="d-flex justify-content-between align-items-center rounded" style="background-color: #f5f6f9;">
					<div class="text-start ms-4 mt-5 mb-5" style="font-size:15pt;">
						<b>총 ${count}건의 글이 있습니다.</b>
					</div>
				<form id="search_form" action="list.do" method="get" class="d-flex justify-content-center">
				<div class="d-flex align-items-center ms-4 mt-5 mb-5">
					<select name="keyfield" class="form-select" style="width:auto; margin-right: 10px;">
						<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>작성자</option>
						<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
					</select>
					<input type="search" size="16" name="keyword" class="form-control rounded me-2" id="keyword" placeholder="검색할 정보를 입력하세요" value="${param.keyword}" style="width:400px;">
					<input type="submit" value="검색" class="btn btn-dark me-3" style="color: #CC66FF">
				</div>
				</form>
				</div>
		<!-- 목록 표 -->
		<c:if test="${count == 0}">
		<div class="text-center border rounded m-5">
			표시할 문의내역이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
			<table class="table table-hover text-center mt-4">
				<thead class="table-light">
				<tr>
					<th>글번호</th>
					<th>처리상태</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="qa" items="${list}">
							<tr>
								<c:if test="${!empty user_num && (user_auth == 9 || user_num == qa.mem_num)}">
									<td><a href="detail.do?qa_num=${qa.qa_num}"
										class="text-decoration-none text-dark fw-bold">${qa.qa_num}</a></td>
									<c:if test="${qa.qa_status == 1}">
										<td><a href="detail.do?qa_num=${qa.qa_num}"
											class="text-decoration-none text-dark fw-bold">미처리</a></td>
									</c:if>
									<c:if test="${qa.qa_status == 2}">
										<td><a href="detail.do?qa_num=${qa.qa_num}"
											class="text-decoration-none text-danger fw-bold">처리</a></td>
									</c:if>
									<td><a href="detail.do?qa_num=${qa.qa_num}"
										class="text-decoration-none text-dark fw-bold">${qa.qa_title}</a></td>
									<td><a href="detail.do?qa_num=${qa.qa_num}"
										class="text-decoration-none text-dark fw-bold">${qa.mem_id}</a></td>
									<c:if test="${empty qa.qa_modify}">
										<td><a href="detail.do?qa_num=${qa.qa_num}"
											class="text-decoration-none text-dark fw-bold">${fn:substring(qa.qa_reg,0,10)}</a></td>
									</c:if>
									<c:if test="${!empty qa.qa_modify}">
										<td><a href="detail.do?qa_num=${qa.qa_num}"
											class="text-decoration-none text-dark fw-bold">${fn:substring(qa.qa_modify,0,10)}</a></td>
									</c:if>
								</c:if>
								<c:if test="${empty user_num || (user_auth != 9 && user_num != qa.mem_num)}">
									<td onclick="alert('조회할 수 있는 권한이 없습니다.')"><b>${qa.qa_num}</b></td>
									<c:if test="${qa.qa_status == 1}">
										<td onclick="alert('조회할 수 있는 권한이 없습니다.')"><a class="text-decoration-none text-dark fw-bold">미처리</a></td>
									</c:if>
									<c:if test="${qa.qa_status == 2}">
										<td onclick="alert('조회할 수 있는 권한이 없습니다.')"><a class="text-decoration-none text-danger fw-bold">처리</a></td>
									</c:if>
									<td onclick="alert('조회할 수 있는 권한이 없습니다.')"><b>${qa.qa_title}</b></td>
									<td onclick="alert('조회할 수 있는 권한이 없습니다.')"><b>${qa.mem_id}</b></td>
									<c:if test="${empty qa.qa_modify}">
										<td onclick="alert('조회할 수 있는 권한이 없습니다.')"><b>${fn:substring(qa.qa_reg,0,10)}</b></td>
									</c:if>
									<c:if test="${!empty qa.qa_modify}">
										<td onclick="alert('조회할 수 있는 권한이 없습니다.')"><b>${fn:substring(qa.qa_modify,0,10)}</b></td>
									</c:if>
								</c:if>
							</tr>
						</c:forEach>
				</tbody>
			</table>
			<div class="text-center mt-3 mb-3">${page}</div>
			<!-- 버튼 -->
		</c:if>
			<div class="text-end mb-4">
				<c:if test="${!empty user_num && user_auth == 2}">
					<input class="btn btn-dark" style="color: #CC66FF" type="button" value="글쓰기" onclick="location.href='writeForm.do'">
				</c:if>		
					<input class="btn btn-dark" style="color: #CC66FF" type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	</div>
</body>
</html>