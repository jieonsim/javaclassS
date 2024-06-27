<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mutiFile2.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
.imgsWrap {
	border: 2px solid #eee;
}

.imgsWrap img {
	max-width: 160px;
	margin: 10px;
}

.myBtn {
	width: 200px;
	padding: 10px;
	background-color: #09A;
	color: #fff;
	border-radius: 5px;
}
</style>
<script>
	'use strict';

	let imgFiles = [];

	$(document).ready(function() {
		$("#inputImgs").on("change", function(e) {
			//imgFiles = [];
			$(".imgsWrap").empty();

			let files = e.target.files;
			let filesArr = Array.prototype.slice.call(files);

			let idx = 0;
			filesArr.forEach(function(f) {
				if (!f.type.match("image.*")) {
					alert("이미지파일만 업로드 하실수 있습니다.");
					return false;
				}
				imgFiles.push(f);

				let reader = new FileReader();
				reader.onload = function(e) {
					let str = "<a href='javascript:void(0);' onclick='deleteImage(" + idx + ")' id='imgId" + idx + "'><img src='"+e.target.result+"' data-file='"+f.name+"' class='' title='그림을 클릭하시면 제거됩니다.'/></a>";
					$(".imgsWrap").append(str);
					idx++;
				}
				reader.readAsDataURL(f);
			});
		});
	});

	function deleteImage(idx) {
		imgFiles.slice(idx, 1);

		let imgId = "#imgId" + idx;
		$(imgId).remove();
	}

	function imageUpload() {
		$("#inputImgs").trigger('click');
	}

	function fCheck() {
		if (imgFiles.length < 1) {
			alert("한 개 이상의 파일을 선택해 주세요.");
			return;
		}

		let imgNames = "";
		for (let i = 0; i < imgFiles.length; i++) {
			imgNames += imgFiles[i].name + "/";
		}
		imgNames = imgNames.substring(0, imgNames.length - 1);
		$("#imgNames").val(imgNames);
		myform.submit();
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
		<h2>멀티(그림)파일 업로드 연습</h2>
		<form name="myform" method="post" enctype="multipart/form-data">
			<a href="javascript:imageUpload()" class="myBtn">이미지 불러오기</a>
			<input type="file" name="fName" id="inputImgs" multiple style="display:none" class="form-control-file border" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp" />
			<p class="mt-3">
				<input type="button" value="파일업로드" onclick="fCheck()" class="btn btn-success" />
				<input type="reset" value="다시선택" class="btn btn-warning" />
				<input type="button" value="싱글파일업로드로이동(파일리스트)" onclick="location.href='${ctp}/study/fileUpload/fileUpload';" class="btn btn-primary" />
				<input type="button" value="멀티파일업로드로이동" onclick="location.href='${ctp}/study/fileUpload/multiFile';" class="btn btn-danger" />
			</p>
			<input type="hidden" name="imgNames" id="imgNames" />
		</form>
		<hr>
		<div>
			<div class="imgsWrap">
				<img id="img" />
			</div>
		</div>
		<p>
			<br />
		</p>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>