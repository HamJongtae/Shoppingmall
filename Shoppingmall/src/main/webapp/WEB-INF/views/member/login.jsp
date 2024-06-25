<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${mem_auth == 1}">
			<script type="text/javascript">
		alert('정지된 회원입니다.');
		history.go(-1);
	</script>
		</c:when>
		<c:when test="${mem_auth == 0}">
			<script type="text/javascript">
		alert('탈퇴된 회원입니다.');
		history.go(-1);
	</script>
		</c:when>
	<%-- auth가 1이 아닌 경우 --%>
	<c:otherwise>
		<script type="text/javascript">
		alert('아이디 또는 비밀번호가 불일치합니다.');
		history.go(-1);
	</script>
	</c:otherwise>
</c:choose>