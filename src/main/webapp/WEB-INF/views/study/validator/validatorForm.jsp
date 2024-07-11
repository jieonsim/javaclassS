<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>validatorForm</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
th {
	background-color: #eee;
}
</style>
<script>
	'use strict';

	$(document).ready(function() {
		$("#btnShow").show();
		$("#btnHide").hide();
		$("#userInput").hide();

		$("#btnShow").click(function() {
			$("#userInput").show();
			$("#btnShow").hide();
			$("#btnHide").show();
		});

		$("#btnHide").click(function() {
			$("#userInput").hide();
			$("#btnShow").show();
			$("#btnHide").hide();
		});
	});

	function deleteCheck(idx) {
		let ans = confirm("선택하신 회원을 삭제처리 하시겠습니까?");
		if (!ans)
			return false;

		location.href = "${ctp}/dbtest/dbtestDelete?tempFlag=validator&idx=" + idx;
	}

	function idCheck() {
		let mid = myform.mid.value;

		if (mid.trim() === "") {
			alert("아이디를 입력하세요.");
		} else {
			let url = "${ctp}/dbtest/dbtestWindow?mid=" + mid;
			window.open(url, "dbtestWindow", "width=600px,height=300px");
		}
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<h2 class="text-center">회원 리스트</h2>
		<hr />
		<div class="mb-2">
			<input type="button" value="회원가입창보이기" id="btnShow" class="btn btn-success" />
			<input type="button" value="회원가입창가리기" id="btnHide" class="btn btn-primary" />
		</div>
		<div id="userInput">
			<form name="myform" method="post">
				<table class="table table-bordered text-center">
					<tr>
						<th>아이디</th>
						<td>
							<div class="input-group">
								<input type="text" name="mid" class="form-control" />
								<div class="input-group-append">
									<input type="button" value="아이디중복체크" onclick="idCheck()" class="btn btn-success" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th>성명</th>
						<td>
							<input type="text" name="name" class="form-control" />
						</td>
					</tr>
					<tr>
						<th>나이</th>
						<td>
							<input type="number" name="age" class="form-control" />
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input type="text" name="address" class="form-control" />
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center">
							<input type="submit" value="회원가입" class="btn btn-success" />
							<input type="reset" value="다시입력" class="btn btn-warning" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<table class="table table-hover text-center">
			<tr class="table-secondary">
				<th>번호</th>
				<th>아이디</th>
				<th>성명</th>
				<th>나이</th>
				<th>주소</th>
				<th>비고</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${vo.idx}</td>
					<td>${vo.mid}</td>
					<td>${vo.name}</td>
					<td>${vo.age}</td>
					<td>${vo.address}</td>
					<td>
						<a href="javascript:deleteCheck(${vo.idx})" class="badge badge-danger">삭제</a>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="6" class="m-0 p-0"></td>
			</tr>
		</table>
		<div class="row">
			<div class="col">
				<a href="${ctp}/" class="btn btn-warning">돌아가기</a>
			</div>
		</div>
		<br />
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>