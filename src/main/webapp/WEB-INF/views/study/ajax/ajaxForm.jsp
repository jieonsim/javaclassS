<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxForm</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';

	function ajaxTest1(idx) {
		//location.href = "${ctp}/study/ajax/ajaxTest1?idx=" + idx;
		$.ajax({
			url : "${ctp}/study/ajax/ajaxTest1",
			type : "post",
			data : {
				idx : idx
			},
			success : function(res) {
				$("#demo1").html(res);
			},
			error : function() {
				alert("전송 오류");
			}
		});
	}

	function ajaxTest2(str) {
		$.ajax({
			url : "${ctp}/study/ajax/ajaxTest2",
			type : "post",
			// contentType: "application/x-www-form-urlencoded; charset=utf-8",
			// headers : {Content-Type : "application/json"},
			data : {
				str : str
			},
			success : function(res) {
				$("#demo2").html(res);
			},
			error : function() {
				alert("전송 오류");
			}
		});
	}

	function fCheck1() {
		let mid = document.getElementById("mid").value;

		if (mid.trim() == "") {
			alert("아이디를 입력하세요.");
			document.getElementById("mid").focus();
			return false;
		}
		$.ajax({
			url : "${ctp}/study/ajax/ajaxTest4-1",
			type : "post",
			data : {
				mid : mid
			},
			// 아래에서 vo 변수로 받아서
			success : function(vo) {
				console.log(vo);
				let str = '<h5>vo로 전송된 자료 출력</h5>';
				// 여기서 vo를 키로 받는것
				if (vo != '') {
					str += '아이디 : ' + vo.mid + '<br/>';
					str += '이름 : ' + vo.name + '<br/>';
					str += '나이 : ' + vo.age + '<br/>';
					str += '주소 : ' + vo.address + '<br/>';
				} else {
					str += "<b>찾고자 하는 자료가 없습니다.</b>";
				}

				$("#demo3").html(str);
			},
			error : function() {
				alert("전송오류");
			}
		});
	}

	function fCheck2() {
		let mid = document.getElementById("mid").value;

		if (mid.trim() == "") {
			alert("아이디를 입력하세요.");
			document.getElementById("mid").focus();
			return false;
		}
		$.ajax({
			url : "${ctp}/study/ajax/ajaxTest4-2",
			type : "post",
			data : {
				mid : mid
			},
			// 아래에서 vo 변수로 받아서
			success : function(vos) {
				console.log(vos);
				let str = '<h5>vos로 전송된 자료 출력</h5>';

				if (vos != '') {
					str += '<table class="table table-bordered table-hover text-center">';
					str += '<tr class="table-secondary">';
					str += '<th>아이디</th><th>이름</th><th>나이</th><th>주소</th>';
					str += '</tr>';
					for (let i = 0; i < vos.length; i++) {
						str += '<tr>';
						str += '<td>' + vos[i].mid + '</td>';
						str += '<td>' + vos[i].name + '</td>';
						str += '<td>' + vos[i].age + '</td>';
						str += '<td>' + vos[i].address + '</td>';
						str += '</tr>';
					}
					// bordered 쓸때는 아래 내용 필요없음
					//str += '<tr><td colspan="4" class="m-0 p-0"></td></tr>';
					str += '</table>';
				} else {
					str += "<b>찾고자 하는 자료가 없습니다.</b>";
				}
				$("#demo3").html(str);
			},
			error : function() {
				alert("전송오류");
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<h2>AJAX 연습</h2>
		<hr>
		<div>
			기본 (int -> String -> int -> String) :
			<a href="javascript:ajaxTest1(8)" class="btn btn-success mr-2 mb-2">값 전달1</a>
			<span id="demo1"></span>
		</div>
		<div>
			기본 (String) :
			<a href="javascript:ajaxTest2('안뇽')" class="btn btn-primary mr-2 mb-2">값 전달2</a>
			<span id="demo2"></span>
		</div>
		<hr>
		<div>
			<span> 응용(배열) - 시(도) / 구(시, 군, 동) 출력</span>
			<div class="mt-2">
				<a href="${ctp}/study/ajax/ajaxTest3_1" class="btn btn-secondary mr-2">String 배열</a>
				<a href="${ctp}/study/ajax/ajaxTest3_2" class="btn btn-info mr-2">ArrayList</a>
				<a href="${ctp}/study/ajax/ajaxTest3_3" class="btn btn-danger mr-2">Map 형식</a>
			</div>
		</div>
		<hr>
		<div class="mt-2">
			<span>user table의 유저 정보 출력</span>
			<div>
				<a href="${ctp}/study/ajax/ajaxTest3_4" class="btn btn-warning mt-2">DB의 user 이름으로 자료 검색</a>
			</div>
		</div>
		<hr>
		<div class="mt-2">
			<span>아이디 : </span>
			<input type="text" name="mid" id="mid" class="form-control mb-3" autofocus>
			<input type="button" value="아이디완전일치(vo)" onclick="fCheck1()" class="btn btn-info mr-2">
			<input type="button" value="아이디부분일치(vo)" onclick="fCheck2()" class="btn btn-secondary mr-2">
		</div>
		<div id="demo3"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>