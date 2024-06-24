<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mailForm</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
#myform th {
	background-color: #eee;
	text-align: center;
}

#spinner {
	position: fixed;
	top: 50%;
	display: none;
	z-index: 1;
	width: 3rem;
	height: 3rem;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<h2>메일 보내기</h2>
		<p>(받는 사람의 메일 주소를 정확히 입력하셔야 합니다.)</p>
		<form name="myform" method="post">
			<table class="table table-bordred">
				<tr>
					<th>받는 사람</th>
					<td>
						<div class="input-group">
							<input type="text" name="toMail" placeholder="받는 사람 메일 주소를 입력하세요." autofocus required class="form-control">
							<div class="input-group-append">
								<a href="#" class="btn btn-primary" data-toggle="modal" data-target="#addressBook">주소록</a>
								<!-- <input type="button" value="주소록" onclick="jusorokCheck()" class="btn btn-primary"> -->
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th>메일 제목</th>
					<td>
						<input type="text" name="title" placeholder="메일 제목을 입력하세요." required class="form-control">
					</td>
				</tr>
				<tr>
					<th>메일 내용</th>
					<td>
						<textarea rows="7" name="content" placeholder="메일 내용을 입력하세요." required class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="메일 보내기" class="btn btn-success mr-2">
						<input type="reset" value="다시쓰기" class="btn btn-warning mr-2">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- The Modal -->
	<div class="modal fade" id="addressBook">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">주소록</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<table class="table table-hover">
						<thead class="table-secondary">
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>이메일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="member" items="${memberDetails}">
								<tr onclick="selectEmail('${member.email}')">
									<td>${member.mid}</td>
									<td>${member.name}</td>
									<td>${member.email}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
<script type="text/javascript">
	'use strict'

	$(document).ready(function() {
		$('#addressBook').on('show.bs.modal', function() {
		});
	});

	function selectEmail(email) {
		$('input[name="toMail"]').val(email);
		$('#addressBook').modal('hide');
	}
</script>
</html>