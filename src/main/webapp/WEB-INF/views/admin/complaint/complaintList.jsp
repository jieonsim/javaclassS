<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>complaintList.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';

	function complaintCheck(part, partIdx, complaint) {
		$.ajax({
			url : "ComplaintCheck.ad",
			type : "post",
			data : {
				part : part,
				partIdx : partIdx,
				complaint : complaint
			},
			success : function() {
				location.reload();
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}

	function modalCheck(title, content, mid, nickName) {
		$("#myModal #modalTitle").text(title);
		$("#myModal #modalContent").text(content);
		$("#myModal #modalNickName").text(nickName);
		$("#myModal #modalIdx").text(idx);
	}

	function complaintDelete(idx) {
		let ans = confirm("현 게시물을 삭제하시겠습니까?");

	}
</script>
</head>
<body>
	<p>
		<br />
	</p>
	<div class="container">
		<h2 class="text-center">신 고 리 스 트</h2>
		<table class="table table-hover text-center">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>분류</th>
				<th>글제목</th>
				<th>글쓴이</th>
				<th>신고자</th>
				<th>신고내역</th>
				<th>신고날짜</th>
				<th>표시여부</th>
			</tr>
			<c:set var="complaintCnt" value="${complaintCnt}" />
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${complaintCnt}</td>
					<td>${vo.part}</td>
					<td>
						<a href="#" onclick="modalCheck('${vo.title}','${vo.content}','${vo.mid}','${vo.nickName}')" data-toggle="modal" data-target="#myModal">${vo.title}</a>
					</td>
					<td>${vo.nickName}</td>
					<td>${vo.cpMid}</td>
					<td>${vo.cpContent}</td>
					<td>${vo.cpDate}</td>
					<td>
						<a href="javascript:complaintCheck('${vo.part}','${vo.partIdx}','${vo.complaint}')" class="badge badge-warning">${vo.complaint == 'NO' ? '표시중' : '<font color=white>감춰짐</font>'}</a>
						<br />
						<a href="javascript:complaintDelete(${vo.idx})" class="badge badge-danger">삭제</a>
					</td>
					<c:set var="complaintCnt" value="${complaintCnt - 1}" />
				</tr>
			</c:forEach>
			<tr>
				<td colspan="8" class="m-0 p-0"></td>
			</tr>
		</table>
	</div>
	<p>
		<br />
	</p>

	<!-- 모달에 회원정보 출력하기 -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Modal Heading</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					작성자 아이디 : <span id="modalMid"></span>
					<hr />
					글제목 : <span id="modalTitle"></span><br /> 글내용 : <span id="modalContent"></span>
					<hr />
					작성자 닉네임 : <span id="modalNickName"></span><br />
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>