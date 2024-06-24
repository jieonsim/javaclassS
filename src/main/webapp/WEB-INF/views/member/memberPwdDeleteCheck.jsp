<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>memberPwdDeleteCheck.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';

	function pwdDeleteCheck() {
		let pwd = $("#pwd").val().trim();
		if (pwd == "") {
			alert("현재 비밀번호를 입력하세요!");
			$("#pwd").focus();
			// return false;
		} else {
			let ans = confirm("회원 탈퇴신청 하시겠습니까?");
			if (ans) {
				ans = confirm("회원 탈퇴하시면 1개월간 같은 아이디로 가입하실수 없습니다.\n계속 진행하시겠습니까?");
				if (ans)
					myform.submit();
			}
		}
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p>
		<br />
	</p>
	<div class="container">
		<form name="myform" method="post" action="MemberDeleteCheckOk.mem">
			<table class="table table-bordered text-center">
				<tr>
					<td colspan="2">
						<h3>비밀번호 확인</h3>
						<div>(회원 탈퇴를 하기위해 현재 비밀번호를 확인합니다.)</div>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="pwd" id="pwd" class="form-control" autofocus required />
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="button" value="비밀번호확인" onclick="pwdDeleteCheck()" class="btn btn-primary mr-2" />
						<input type="reset" value="다시입력" class="btn btn-info mr-2" />
						<input type="button" value="돌아가기" onclick="location.href='MemberMain.mem';" class="btn btn-warning" />
					</td>
				</tr>
			</table>
			<br />
		</form>
	</div>
	<p>
		<br />
	</p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>