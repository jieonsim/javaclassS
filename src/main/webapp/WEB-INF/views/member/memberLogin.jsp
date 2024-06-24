<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%-- <%
// 아래 방법은 mvc1, mvc2를 위해서는 controller나 service로 빼기

// 로그인창에 아이디 체크 유무에 대한 처리
// 쿠키를 검색해서 cMid가 있을때 가져와서 아이디입력 창에 뿌릴 수 있게 한다.

Cookie[] cookies = request.getCookies();

if (cookies != null) {
	for (int i = 0; i < cookies.length; i++) {
		if (cookies[i].getName().equals("cMid")) {
	pageContext.setAttribute("mid", cookies[i].getValue());
	break;
		}
	}
}
%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>memberLogin.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
#spinner {
	position: fixed;
	top: 50%;
	display: none;
	z-index: 1;
	width: 3rem;
	height: 3rem;
}
</style>
<script>
	'use strict';

	$(function() {
		$("#searchPassword").hide();
		$("#searchMid").hide();
	});

	// 아이디 찾기
	function midSearch() {
		$("#searchMid").show();
	}
	// 비밀번호 찾기
	function pwdSearch() {
		$("#searchPassword").show();
	}

	// 아이디 찾기 시 이메일로 아이디 발송
	function findMid() {
		let name = $("#nameSearch").val().trim();
		let email = $("#emailSearch1").val().trim();

		if (name === "" || email === "") {
			alert("가입 시 등록한 이름과 메일 주소를 입력하세요.");
			$("#nameSearch").focus();
			return false;
		}

		$.ajax({
			url : "${ctp}/member/memberFindMid",
			type : "POST",
			data : {
				name : name,
				email : email
			},
			beforeSend : function() {
				$("#spinner").css("display", "inline-block");
			},
			success : function(res) {
				$("#spinner").css("display", "none");

				if (res != "0") {
					alert("회원님의 아이디가 메일로 발송되었습니다.\n메일 수신함을 확인하세요.");
				} else {
					alert("입력하신 정보와 일치하는 회원이 없습니다. 확인 후 다시 시도하세요.");
				}
			},
			error : function() {
				$("#spinner").css("display", "none");
				alert("전송 오류");
			}
		});
	}

	// 임시 비밀번호 등록 시켜주기
	function newPassword() {
		let mid = $("#midSearch").val().trim();
		let email = $("#emailSearch2").val().trim();

		if (mid === "" || email === "") {
			alert("가입 시 등록한 아이디와 메일 주소를 입력하세요.");
			$("#midSearch").focus();
			return false;
		}

		$.ajax({
			url : "${ctp}/member/memberNewPassword",
			type : "POST",
			data : {
				mid : mid,
				email : email
			},
			beforeSend : function() {
				$("#spinner").css("display", "inline-block");
			},
			success : function(res) {
				$("#spinner").css("display", "none");

				if (res != "0") {
					alert("새로운 비밀번호가 회원님 메일로 발송되었습니다.\n메일 수신함을 확인하세요.");
				} else {
					alert("등록하신 정보가 일치하지 않습니다. 확인 후 다시 시도하세요.");
				}
				// 리로드를 해줘야 로그인에서 머무름
				location.reload();
			},
			error : function() {
				$("#spinner").css("display", "none");
				alert("전송 오류");
			}
		});
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
		<form name="myform" method="post">
			<table class="table table-bordered text-center">
				<tr>
					<td colspan="2">
						<font size="5">로 그 인</font>
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="mid" value="${mid}" autofocus required class="form-control" />
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="pwd" value="1234" required class="form-control" />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인" class="btn btn-success mr-2" />
						<input type="reset" value="다시입력" class="btn btn-warning mr-2" />
						<input type="button" value="회원가입" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-primary mr-4" />
					</td>
				</tr>
			</table>
			<table class="table table-bordered p-0">
				<tr>
					<td class="text-center">
						<input type="checkbox" name="idSave" checked />
						<span class="mr-3"> 아이디 저장 </span>
						<a href="javascript:midSearch()">아이디 찾기</a>
						<span class="mx-3">|</span>
						<a href="javascript:pwdSearch()">비밀번호 찾기</a>
					</td>
				</tr>
			</table>
		</form>
		<div id="searchMid">
			<hr>
			<table class="table table-bordered p-0 text-center">
				<tr>
					<td colspan="2" class="text-center">
						<font size="4">
							<b>아이디 찾기</b>
						</font>
						(가입 시 입력한 이름과 메일 주소를 입력하세요.)
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="nameSearch" id="nameSearch" class="form-control" placeholder="이름을 입력하세요.">
					</td>
				</tr>
				<tr>
					<th>메일 주소</th>
					<td>
						<input type="email" name="emailSearch1" id="emailSearch1" class="form-control" placeholder="이메일을 입력하세요.">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="button" value="아이디 찾기" onclick="findMid()" class="form-control  btn btn-success">
					</td>
				</tr>
			</table>
		</div>
		<div id="searchPassword">
			<hr>
			<table class="table table-bordered p-0 text-center">
				<tr>
					<td colspan="2" class="text-center">
						<font size="4">
							<b>비밀번호 찾기</b>
						</font>
						(가입 시 입력한 아이디와 메일 주소를 입력하세요.)
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="midSearch" id="midSearch" class="form-control" placeholder="아이디를 입력하세요.">
					</td>
				</tr>
				<tr>
					<th>메일 주소</th>
					<td>
						<input type="email" name="emailSearch2" id="emailSearch2" class="form-control" placeholder="이메일을 입력하세요.">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="button" value="새 비밀번호 발급" onclick="newPassword()" class="form-control btn btn-success">
					</td>
				</tr>
			</table>
		</div>
		<div class="d-flex justify-content-center">
			<div class="spinner-border" role="status" id="spinner"></div>
		</div>
	</div>
	<p>
		<br />
	</p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>