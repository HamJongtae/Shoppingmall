<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#photo_btn').click(function(){
		$('#photo_choice').show();
		$(this).hide(); //수정 버튼 감추기
	});
	
	//이미지 미리 보기
	let photo_path = $('.my-photo').attr('src');//처음 화면에 보여지는 이미지 읽기
	$('#photo').change(function(){
		let my_photo = this.files[0];
		if(!my_photo){
			//선택을 취소하면 원래 처음 화면으로 되돌림
			$('.my-photo').attr('src',photo_path);
			return;
		}
		
		if(my_photo.size > 1024*1024){
			alert(Math.round(my_photo.size/1024) + 'kbytes(1024kbytes까지만 업로드 가능)');
			$('.my-photo').attr('src',photo_path);
			$(this).val('');//선택한 파일 정보 지우기
			return;
		}
		//화면에 이미지 미리 보기
		const reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		reader.onload=function(){
			$('.my-photo').attr('src',reader.result);
		};		
	});//end of change
	
	//이미지 전송
	$('#photo_submit').click(function(){
		if($('#photo').val()==''){
			alert('파일을 선택하세요');
			$('#photo').focus();
			return;
		}
		//파일 전송
		const form_data = new FormData();
		//업로드할 파일은 $('#photo').files[0]를 호출할 수 없음
		//$('#photo')[0].files[0] 또는
		//document.getElementById('photo').files[0]
		//형식으로 호출 가능
		form_data.append('photo',$('#photo')[0].files[0]);
		
		$.ajax({
			url:'updateMyPhoto.do',
			type:'post',
			data:form_data,
			dataType:'json',
			contentType:false, //데이터 객체를 문자열로 바꿀지 설정.true이면 일반문자
			processData:false, //해당 타입을 true로 하면 일반 text로 구분
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요');
				}else if(param.result == 'success'){
					alert('프로필 사진이 수정되었습니다.');
					//수정된 이미지 정보 저장
					photo_path = $('.my-photo').attr('src');
					$('#photo').val('');
					$('#photo_choice').hide();
					$('#photo_btn').show();//수정 버튼 표시
				}else{
					alert('파일 전송 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
	});//end of click
	
	//이미지 미리보기 취소
	$('#photo_reset').click(function(){
		//초기 이미지 표시
		$('.my-photo').attr('src',photo_path);//이미지 미리보기 전 이미지로 되돌리기
		$('#photo').val('');
		$('#photo_choice').hide();
		$('#photo_btn').show();//수정 버튼 표시
	});
});
</script>
<style type="text/css">
.page-main{
	background:#FFFFFF;
	margin:40px 0;
	border-radius:5px;
	min-height:650px;
}
.content-main{
	padding:10px 20px;
}
.mypage-div{
	width:48%;
	float:left;
	padding:5px;
}
.mypage-end{
	clear:both;
}
.my-photo{
	object-fit:cover;
	/*정사각형이 아니라 직사각형일 경우 원 안에 보여지게 할 중심 이미지의 위치를 지정*/
	object-position:top;
	/*사각형의 모서리 둥근 정도를 지정하는 속성,50%를 지정하면 완전한 원*/
	border-radius:50%;
}
.align-center{
	text-align:center;
}
</style>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container">
		<h2 class="ms-3 mt-3 mb-3">회원정보</h2>
		<div class="mypage-div">
			<h4>프로필 사진</h4>
			<ul class="list-unstyled p-5 rounded-5 bg-light">
				<li>
					<c:if test="${empty member.photo}">
					<img src="${pageContext.request.contextPath}/images/face.png" 
					                   width="200" height="200" class="my-photo">
					</c:if>
					<c:if test="${!empty member.photo}">
					<img src="${pageContext.request.contextPath}/upload/${member.photo}" 
					                   width="200" height="200" class="my-photo">
					</c:if>
				</li>
				<li>
					<div class="align-center">
						<input class="btn btn-dark" style="color: #CC66FF" type="button" value="수정" id="photo_btn">
					</div>
					<div id="photo_choice" style="display:none;">
						<input type="file" id="photo" accept="image/gif,image/png,image/jpeg">
						<input class="btn btn-dark" style="color: #CC66FF" type="button" value="전송" id="photo_submit">
						<input class="btn btn-dark" style="color: #CC66FF" type="button" value="취소" id="photo_reset">          
					</div>
				</li>
			</ul>
			<hr size="1" noshade="noshade" width="100%">
			<h4>연락처 <input class="btn btn-dark" style="color: #CC66FF" type="button" value="연락처 수정"
			        onclick="location.href='modifyUserForm.do'"></h4>
			<ul class="list-unstyled p-5 rounded-5 bg-light">
				<li>아이디 : ${member.id}</li>
				<li>이름 : ${member.name}</li>
				<li>전화번호 : ${member.phone}</li>
				<li>이메일 : ${member.email}</li>
				<li>우편번호 : ${member.zipcode}</li>
				<li>주소 : ${member.address1} ${member.address2}</li>
				<li>가입일 : ${member.reg_date}</li>
				<c:if test="${!empty member.modify_date}">
				<li>최근 정보 수정일 : ${member.modify_date}</li>
				</c:if>
			</ul> 
			<div class="mb-4">
			비밀번호 수정 <input class="btn btn-dark" style="color: #CC66FF" type="button" value="비밀번호 수정" onclick="location.href='modifyPasswordForm.do'">
			회원탈퇴 <input class="btn btn-dark" style="color: #CC66FF" type="button" value="회원탈퇴" onclick="location.href='deleteUserForm.do'">      
			</div>
		</div>
		<div class="mypage-div">
			<h4>관심 게시물 목록</h4>
			<table class="table table-hover mb-5">
			<thead class="table-dark text-center">
				<tr>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody class="text-center">
				<c:forEach var="board" items="${boardList}">
				<tr>
					<td><a href="${pageContext.request.contextPath}/board/detail.do?board_num=${board.board_num}" target="_blank">${fn:substring(board.title,0,12)}</a></td>
					<td>${board.id}</td>
					<td>${board.reg_date}</td>
				</tr>
				</c:forEach>
			</tbody>
			</table>
			<hr size="1" noshade="noshade" width="100%">
			<h4 class="mt-5">상품구매목록 <input class="btn btn-dark" style="color: #CC66FF" type="button" value="더보기" onclick="location.href='${pageContext.request.contextPath}/order/orderList.do'"></h4>
			<table class="table table-hover mb-5">
			<thead class="table-dark text-center">
				<tr>
					<th>주문번호</th>
					<th>상품명</th>
					<th>주문날짜</th>
					<th>배송상태</th>
				</tr>
			</thead>
			<tbody class="text-center">
				<c:forEach var="order" items="${orderList}">
				<tr>
					<td>${order.order_num}</td>
					<td><a href="${pageContext.request.contextPath}/order/orderDetail.do?order_num=${order.order_num}">${order.item_name}</a></td>
					<td>${order.reg_date}</td>
					<td>
						<c:if test="${order.status == 1}">배송대기</c:if>
						<c:if test="${order.status == 2}">배송준비중</c:if>
						<c:if test="${order.status == 3}">배송중</c:if>
						<c:if test="${order.status == 4}">배송완료</c:if>
						<c:if test="${order.status == 5}">주문취소</c:if>
					</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="mypage-end"></div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>




