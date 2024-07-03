<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>boardUpdate.jsp</title>
<script src="${ctp}/ckeditor/ckeditor.js"></script>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p>
		<br />
	</p>
	<div class="container">
		<h2 class="text-center">게 시 판 글 수 정 하 기</h2>
		<form name="myform" id="boardUpdateForm" method="post">
			<table class="table table-bordered">
				<tr>
					<th>글쓴이</th>
					<td>
						<input type="text" name="nickName" id="nickName" value="${sNickName}" readonly class="form-control" />
					</td>
				</tr>
				<tr>
					<th>글제목</th>
					<td>
						<input type="text" name="title" id="title" value="${vo.title}" autofocus required class="form-control" />
					</td>
				</tr>
				<tr>
					<th>글내용</th>
					<td>
						<textarea name="content" id="CKEDITOR" rows="6" class="form-control" required>${vo.content}</textarea>
					</td>
				</tr>
				<tr>
					<th>공개여부</th>
					<td>
						<input type="radio" name="openSw" id="openSw1" value="OK" ${vo.openSw == 'OK' ? 'checked' : ''} />
						공개 &nbsp;
						<input type="radio" name="openSw" id="openSw2" value="NO" ${vo.openSw == 'NO' ? 'checked' : ''} />
						비공개
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="수정하기" class="btn btn-success mr-2" />
						<input type="reset" value="다시입력" class="btn btn-warning mr-2" />
						<input type="button" value="돌아가기" onclick="location.href='boardContent?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-info" />
					</td>
				</tr>
			</table>
			<input type="hidden" name="idx" value="${vo.idx}" />
			<%-- <input type="hidden" name="mid" value="${sMid}"/> --%>
			<input type="hidden" name="pag" value="${pag}" />
			<input type="hidden" name="pageSize" value="${pageSize}" />
			<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
		</form>
	</div>
	<p>
		<br />
	</p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
<script>
	CKEDITOR.replace("content", {
		height : 480,
		filebrowserUploadUrl : "${ctp}/imageUpload", /*파일(이미지)를 업로드시키기 위한 매핑 경로(메소드)*/
		uploadUrl : "${ctp}/imageUpload" /*여러개의 그림 파일을 드래그 앤 드랍해서 올릴 수 있다.*/
	});

	/* $(document).ready(function() {
		$('#boardUpdateForm').on('submit', function(event) {
			event.preventDefault();
			var formData = $(this).serialize();

			$.ajax({
				type : 'POST',
				url : '${ctp}/board/boardUpdate',
				data : formData,
				success : function(response) {
					alert(response.msg);
					if (response.url) {
						window.location.href = '${ctp}' + response.url;
					}
				},
				error : function(xhr, status, error) {
					alert('게시글 수정 중 오류가 발생했습니다.');
				}
			});
		});
	}); */

	/* document.addEventListener("DOMContentLoaded", function() {
		const form = document.getElementById('boardUpdateForm');
		form.addEventListener('submit', function(event) {
			event.preventDefault(); // 폼의 기본 제출 동작을 막습니다.

			// CKEditor 내용을 업데이트합니다.
			for (instance in CKEDITOR.instances) {
				CKEDITOR.instances[instance].updateElement();
			}

			const formData = new FormData(form);
			const xhr = new XMLHttpRequest();
			xhr.open('POST', '${ctp}/board/boardUpdate', true);

			xhr.onload = function() {
				if (xhr.status >= 200 && xhr.status < 400) {
					const response = JSON.parse(xhr.responseText);
					alert(response.msg);
					if (response.url) {
						window.location.href = '${ctp}' + response.url;
					}
				} else {
					alert('게시글 수정 중 오류가 발생했습니다.1');
				}
			};

			xhr.onerror = function() {
				alert('게시글 수정 중 오류가 발생했습니다.2');
			};

			xhr.send(formData);
		});
	});*/

	$(document).ready(function() {
		$('#boardUpdateForm').on('submit', function(event) {
			event.preventDefault();

			// CKEditor 내용을 업데이트합니다.
			for (instance in CKEDITOR.instances) {
				CKEDITOR.instances[instance].updateElement();
			}

			var formData = $(this).serialize();

			$.ajax({
				type : 'POST',
				url : '${ctp}/board/boardUpdate',
				data : formData,
				success : function(response) {
					alert(response.msg);
					if (response.url) {
						window.location.href = '${ctp}' + response.url;
					}
				},
				error : function(xhr, status, error) {
					alert('게시글 수정 중 오류가 발생했습니다.');
				}
			});
		});
	});
</script>
</html>