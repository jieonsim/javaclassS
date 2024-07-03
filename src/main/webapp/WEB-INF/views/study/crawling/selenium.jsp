<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selenium.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';

	function crawling1() {
		$("#spinnerIcon").show();

		$.ajax({
			url : "${ctp}/study/crawling/selenium",
			type : "post",
			success : function(vos) {
				if (vos != "") {
					let str = '<table class="table table-bordered text-center">';
					str += '<tr class="table-secondary"><th>번호</th><th>영화제목</th><th>포스터</th><th>예매율</th></tr>';
					for (let i = 0; i < vos.length; i++) {
						str += '<tr>';
						str += '<td>' + (i + 1) + '</td>';
						str += '<td>' + vos[i].title + '</td>';
						str += '<td>' + vos[i].image + '</td>';
						str += '<td>' + vos[i].percent + '</td>';
						str += '</tr>';
					}
					str += '<tr><td colspan="4" class="p-0 m-0"></td></tr>';
					str += '</table>';
					$("#demo").html(str);
				} else
					$("#demo").html("검색된 자료가 없습니다.");

				$("#spinnerIcon").hide();
			}
		});
	}

	// SRT 열차 시간 조회
	function crawlingCheck() {
		$("#spinnerIcon").show();
		let stationStart = $("#stationStart").val();
		let stationStop = $("#stationStop").val();

		$.ajax({
			url : "${ctp}/study/crawling/train",
			type : "post",
			data : {
				stationStart : stationStart,
				stationStop : stationStop
			},
			success : function(vos) {
				if (vos != "") {
					let str = '';
					str += '<table class="table table-bordered text-center"><tr class="table-dark text-dark"><th>열차</th><th>출발</th><th>도착</th><th>소요시간</th><th>요금</th></tr>';
					for (let i = 0; i < vos.length; i++) {
						str += '<tr>';
						str += '<td>' + vos[i].train + '</td>';
						str += '<td>' + vos[i].start + '</td>';
						str += '<td>' + vos[i].arrive + '</td>';
						str += '<td>' + vos[i].time + '</td>';
						str += '<td><a href="${ctp}/data/ckeditor/screenshot.png" target="_blank">' + vos[i].price + '</a></td>';
						str += '</tr>';
					}
					str += '</tr></table>';
					$("#demo").html(str);

					$("#spinnerIcon").hide();
				} else
					$("#demo").html("검색한 자료가 없습니다.");
			}
		});
	}

	// 네이버 게임 목록 지정페이지까지 크롤링
	function crawling3() {
		$("#spinnerIcon3").show();
		let page = $("#page").val();

		$.ajax({
			url : "${ctp}/study/crawling/naverGameSearch",
			type : "post",
			data : {
				page : page
			},
			success : function(vos) {
				if (vos != "") {
					let str = '';
					str += '<table class="table table-bordered text-center"><tr class="table-dark text-dark"><th>번호</th><th>제목</th><th>장르</th><th>플랫폼</th><th>출시일</th><th>사진</th></tr>';
					for (let i = 0; i < vos.length; i++) {
						str += '<tr>';
						str += '<td>' + (i + 1) + '</td>';
						str += '<td>' + vos[i].item1 + '</td>';
						str += '<td>' + vos[i].item2 + '</td>';
						str += '<td>' + vos[i].item3 + '</td>';
						str += '<td>' + vos[i].item4 + '</td>';
						str += '<td>' + vos[i].item5 + '</td>';
						str += '</tr>';
					}
					str += '</tr></table>';
					$("#demo").html(str);

					$("#spinnerIcon3").hide();
				} else
					$("#demo").html("검색한 자료가 없습니다.");
			}
		});
	}

	// 화살표클릭시 화면 상단으로 부드럽게 이동하기
	$(window).scroll(function() {
		if ($(this).scrollTop() > 100) {
			$("#topBtn").addClass("on");
		} else {
			$("#topBtn").removeClass("on");
		}

		$("#topBtn").click(function() {
			window.scrollTo({
				top : 0,
				behavior : "smooth"
			});
		});
	});
</script>
<style>
h6 {
	position: fixed;
	right: 1rem;
	bottom: -50px;
	transition: 0.7s ease;
}

.on {
	opacity: 0.8;
	cursor: pointer;
	bottom: 0;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p>
		<br />
	</p>
	<div class="container">
		<h2>selenium를 이용한 웹 크롤링</h2>
		<hr />
		<div>
			<a href="javascript:location.reload()" class="btn btn-warning form-control">다시검색</a>
		</div>
		<hr />
		<h4>CGV 상영관 무비차트</h4>
		<form name="myform">
			<div class="input-group mb-3">
				<div class="input-group-text">CGV 상영관 무비챠트</div>
				<div class="input-group-append mr-5">
					<input type="button" value="크롤링1" onclick="crawling1()" class="btn btn-success" />
				</div>
				<div class="input-group-append">
					<span id="spinnerIcon" style="display: none">
						<span class="spinner-border"></span>
						&nbsp;&nbsp; 검색중입니다. &nbsp;&nbsp;
						<span class="spinner-border"></span>
					</span>
				</div>
			</div>
		</form>
		<hr />
		<h4>SRT 승차권 조회</h4>
		<form name="trainform">
			<div class="input-group mb-3">
				<span class="input-group-text mr-2">출발역</span>
				<div class="input-group-append mr-3">
					<input type="text" name="stationStart" id="stationStart" value="대전" class="form-control" />
				</div>
				~
				<span class="input-group-text ml-3 mr-2">도착역</span>
				<div class="input-group-append">
					<input type="text" name="stationStop" id="stationStop" value="부산" class="form-control" />
				</div>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<input type="button" value="새로고침" onclick="location.reload()" class="btn btn-info" />
				</div>
				<span class="input-group-text" style="width: 50%">SRT 열차 시간표 조회</span>
				<div class="input-group-append mr-1">
					<input type="button" value="웹크롤링2" onclick="crawlingCheck()" class="btn btn-success" />
				</div>
				<div class="input-group-append">
					<span id="spinnerIcon" style="display: none">
						<span class="spinner-border"></span>
						검색중입니다.
						<span class="spinner-border"></span>
					</span>
				</div>
			</div>
			<hr />
		</form>
		<hr />
		<h4>네이버 게임 검색목록</h4>
		<div>(https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=게임)</div>
		<form name="gameform">
			<div class="input-group mb-3">
				<div class="input-group-text">마지막 페이지(1~마지막지정페이지)</div>
				<input type="number" name="page" id="page" value="2" class="form-control" />
				<div class="input-group-append mr-5">
					<input type="button" value="크롤링3" onclick="crawling3()" class="btn btn-success" />
				</div>
				<div class="input-group-append">
					<span id="spinnerIcon3" style="display: none">
						<span class="spinner-border"></span>
						&nbsp;&nbsp; 검색중입니다. &nbsp;&nbsp;
						<span class="spinner-border"></span>
					</span>
				</div>
			</div>
		</form>
		<hr />
		<div id="demo"></div>
	</div>
	<p>
		<br />
	</p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<!-- 위로가기 버튼 -->
	<h6 id="topBtn" class="text-right mr-3">
		<img src="${ctp}/images/arrowTop.gif" title="위로이동" />
	</h6>
</body>
</html>