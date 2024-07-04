<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>randomForm</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript">
	'use strict';

	let str = "";
	let cnt = 0;

	function randomCheck() {
		$.ajax({
			url : "${ctp}/study/random/randomNumeric",
			type : "post",
			success : function(res) {
				cnt++;
				str += cnt + "(random) : " + res + "<br/>";
				$("#demo").html(str);
			},
			error : function() {
				alert("전송 오류");
			}
		});
	}

	function uuidCheck() {
		$.ajax({
			url : "${ctp}/study/random/randomUUID",
			type : "post",
			success : function(res) {
				cnt++;
				str += cnt + "(UUID) : " + res + "<br/>";
				$("#demo").html(str);
			},
			error : function() {
				alert("전송 오류");
			}
		});
	}
	function randomAlPhaNumericCheck() {
		$.ajax({
			url : "${ctp}/study/random/randomAlPhaNumeric",
			type : "post",
			success : function(res) {
				cnt++;
				str += cnt + "(AlPhaNumeric) : " + res + "<br/>";
				$("#demo").html(str);
			},
			error : function() {
				alert("전송 오류");
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<h2>무작위 수 / randomAlphaNumeric</h2>
		<div>알파벳과 숫자를 랜덤하게 출력시켜줄 수 있다.</div>
		<hr>
		<div>
			<input type="button" value="Numeric" onclick="randomCheck()" class="btn btn-success mr-2" />
			<input type="button" value="UUID(16진수)" onclick="uuidCheck()" class="btn btn-primary mr-2" />
			<input type="button" value="AlphaNumeric" onclick="randomAlPhaNumericCheck()" class="btn btn-success mr-2" />
			<input type="button" value="새로고침" onclick="location.reload()" class="btn btn-warning" />
		</div>
		<hr>
		<div>출력결과 :</div>
		<span id="demo"></span>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>