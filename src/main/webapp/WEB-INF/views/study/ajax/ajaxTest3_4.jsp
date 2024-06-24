<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxTest3_4</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';

	$(document).ready(function() {
		$.ajax({
			url : "${ctp}/study/ajax/getUserMids",
			type : "GET",
			success : function(res) {
				let str = '<option value="">아이디 선택</option>';
				for (let i = 0; i < res.length; i++) {
					str += '<option value="' + res[i] + '">' + res[i] + '</option>';
				}
				$("#mid").html(str);
			},
			error : function() {
				alert("전송 오류!");
			}
		});
	});

	function midCheck() {
		let mid = document.getElementById("mid").value;
		if (mid.trim() == "") {
			alert("아이디를 선택하세요");
			return false;
		}

		$.ajax({
			url : "${ctp}/study/ajax/ajaxTest3_4",
			type : "POST",
			data : {
				mid : mid
			},
			success : function(res) {
				let str = "선택하신 회원의 고유번호 : " + res.idx + " / 아이디 : " + res.mid + " / 이름 : " + res.name + " / 나이 : " + res.age + " / 주소 : " + res.address;
				$("#demo").html(str);
			},
			error : function() {
				alert("전송 오류!");
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<h2>ajaxTest3_4.jsp (HashMap 처리)</h2>
		<hr>
		<form>
			<h3>정보 확인이 필요한 회원의 아이디를 선택하세요.</h3>
			<select name="mid" id="mid">
				<option value="">아이디 선택</option>
			</select>
			<input type="button" value="선택" onclick="midCheck()" class="btn btn-info mx-3 mb-3" />
			<input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-warning mr-3 mb-3" />
		</form>
		<div id="demo"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>