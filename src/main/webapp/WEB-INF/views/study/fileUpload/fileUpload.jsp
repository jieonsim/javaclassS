<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fileUploadjsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';

	function fCheck() {
		let fName = document.getElementById("fName").value;
		let ext = fName.substring(fName.lastIndexOf(".") + 1).toLowerCase();
		let maxSize = 1024 * 1024 * 20; // 한번에 업로드 최대용량은 20MByte

		if (fName.trim() == "") {
			alert("업로드할 파일을 선택하세요");
			return false;
		}

		let fileSize = document.getElementById("fName").files[0].size;
		if (fileSize > maxSize) {
			alert("업로드할 파일의 최대용량은 20MByte입니다.");
		} else if (ext != "jpg" && ext != "gif" && ext != "png" && ext != "zip" && ext != "ppt" && ext != "pptx" && ext != "hwp") {
			alert("업로드 가능한 파일은 'jpg/gif/png/zip/ppt/pptx/hwp'파일 입니다.");
		} else {
			myform.submit();
		}
	}

	// 개별파일 삭제처리
	function fileDelete(file) {
		let ans = confirm("선택한 파일을 삭제하시겠습니까?");
		if (!ans)
			return false;

		$.ajax({
			url : "${ctp}/study/fileUpload/fileDelete",
			type : "post",
			data : {
				file : file
			},
			success : function(res) {
				if (res != 0) {
					alert("파일이 삭제되었습니다.");
					location.reload();
				} else
					alert("파일 삭제 실패~");
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}

	// 전체파일 삭제처리
	function fileDeleteAll() {
		let ans = confirm("모든 파일을 삭제하시겠습니까?");
		if (!ans)
			return false;

		$.ajax({
			url : "${ctp}/study/fileUpload/fileDeleteAll",
			type : "post",
			success : function(res) {
				if (res != 0) {
					alert("파일이 삭제되었습니다.");
					location.reload();
				} else
					alert("파일 삭제 실패~");
			},
			error : function() {
				alert("전송오류!");
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
		<h2>파일 업로드 연습</h2>
		<form name="myform" method="post" enctype="multipart/form-data">
			<p>
				올린이 :
				<input type="text" name="mid" value="${sMid}" />
			</p>
			<p>
				파일명 :
				<input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp" />
			</p>
			<p>
				<input type="button" value="파일업로드" onclick="fCheck()" class="btn btn-success" />
				<input type="reset" value="다시선택" class="btn btn-warning" />
				<input type="button" value="멀티파일업로드로이동" onclick="location.href='${ctp}/study/fileUpload/multiFile';" class="btn btn-primary" />
				<input type="button" value="그림파일업로드로이동" onclick="location.href='${ctp}/study/fileUpload/multiFile2';" class="btn btn-primary" />
			</p>
		</form>
		<hr />
		<div id="downLoadFile">
			<h3>서버에 저장된 파일정보(총 : ${fileCount}건)</h3>
			<div class="row">
				<div class="col">저장경로 : ${ctp}/resources/data/fileUpload/*.*</div>
				<div class="col">
					<!-- 파일 삭제 -->
					<input type="button" value="폴더 내 모든 파일 삭제" onclick="fileDeleteAll()" class="btn btn-danger">
				</div>
			</div>
			<table class="table table-hover text-center">
				<tr class="table-secondary">
					<th>번호</th>
					<th>파일명</th>
					<th>파일형식</th>
					<th>비고</th>
				</tr>
				<c:forEach var="file" items="${files}" varStatus="st">
					<tr>
						<td>${st.count}</td>
						<td>${file}</td>
						<td>
							<c:set var="fNameArray" value="${fn:split(file,'.')}" />
							<c:set var="extName" value="${fn:toLowerCase(fNameArray[fn:length(fNameArray)-1])}" />
							<c:if test="${extName == 'zip'}">압축파일</c:if>
							<c:if test="${extName == 'ppt' || extName == 'pptx'}">파워포인트 파일</c:if>
							<c:if test="${extName == 'hwp'}">한글파일</c:if>
							<c:if test="${extName == 'jpg' || extName == 'gif' || extName == 'png'}">
								<img src="${ctp}/fileUpload/${file}" width="150px" />
							</c:if>
						</td>
						<td>
							<input type="button" value="삭제" onclick="fileDelete('${file}')" class="btn btn-danger btn-sm" />
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<p>
		<br />
	</p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>