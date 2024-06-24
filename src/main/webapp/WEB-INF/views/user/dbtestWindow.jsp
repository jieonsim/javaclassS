<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dbtestWindow</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';

	function wClose() {
		opener.window.myform.mid.value = '${mid}';
		opener.window.myform.name.focus();

		window.close();
	}

	function idCheck() {
		let mid = childForm.mid.value;

		if (mid.trim() === "") {
			alert("검색할 아이디를 입력하세요.");
			childForm.mid.focus();
			return false;
		}
		childForm.submit();
	}
</script>
</head>
<body>
	<div class="container my-5">
		<h3>아이디 중복체크</h3>
		<hr>
		<div class="text-center">
			<font color="red">
				<c:if test="${idCheck == 'OK'}">
					<b>${mid}는 사용 가능한 아이디입니다.</b>
				</c:if>
				<c:if test="${idCheck == 'NO'}">
					<b>${mid}는 사용 불가한 아이디입니다. 원하는 아이디를 검색해보세요.</b>
					<form name="childForm" method="get" action="${ctp}/dbtest/dbtestWindow" class="mt-3">
						<label style="color: black;">아이디</label>
						<input type="text" name="mid">
						<input type="button" value="아이디 검색" onclick="idCheck()">
					</form>
				</c:if>
			</font>
		</div>
		<hr />
		<div class="text-center">
			<input type="button" value="창닫기" onclick="wClose()" class="btn btn-success" />
		</div>
	</div>
</body>
</html>