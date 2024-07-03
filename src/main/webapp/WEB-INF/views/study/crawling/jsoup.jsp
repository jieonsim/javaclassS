<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>crawling-jsoup</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';

	$(function() {
		$("#url").change(function() {
			let url = document.querySelector("select[name=url]");
			let urlNo = url.options[url.selectedIndex].text.substring(0, url.options[url.selectedIndex].text.indexOf("."));

			let temp = "<option>";
			let selector = document.myform.selector;
			for (let i = 0; i < selector.length; i++) {
				if (urlNo == selector[i].value.substring(0, selector[i].value.indexOf("."))) {
					temp += selector[i].value;
					break;
				}
			}
			temp += "</option>";
			$("#selector").html(temp);
		});
	});

	function crawling1() {
		let url = document.getElementById("url").value;
		let selector = document.getElementById("selector").value;

		if (url.trim() == "") {
			alert("웹크로링할 주소를 입력하세요");
			return false;
		}

		$.ajax({
			url : "${ctp}/study/crawling/jsoup",
			type : "post",
			data : {
				url : url.substring(url.indexOf("-") + 1),
				selector : selector.substring(selector.indexOf(".") + 1)
			},
			success : function(res) {
				if (res != "") {
					let str = '';
					for (let i = 0; i < res.length; i++) {
						str += res[i] + "<br/>";
					}
					$("#demo").html(str);
				} else
					$("#demo").html("검색된 자료가 없습니다.");
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}

	// 네이버 뉴스
	function crawling2() {
		$.ajax({
			url : "${ctp}/study/crawling/jsoup2",
			type : "post",
			success : function(vos) {
				if (vos != "") {
					let str = '<table class="table table-bordered text-center">';
					str += '<tr class="table-secondary"><th>번호</th><th>제목</th><th>사진</th><th>언론사</th></tr>';
					for (let i = 0; i < vos.length; i++) {
						str += '<tr>';
						str += '<td>' + (i + 1) + '</td>';
						str += '<td>' + vos[i].item1 + '</td>';
						str += '<td>' + vos[i].item2 + '</td>';
						str += '<td>' + vos[i].item3 + '</td>';
						str += '</tr>';
					}
					str += '<tr><td colspan="4" class="p-0 m-0"></td></tr>';
					str += '</table>';
					$("#demo").html(str);
				} else
					$("#demo").html("검색된 자료가 없습니다.");
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}

	// 다음 연예뉴스
	function crawling3() {
		$.ajax({
			url : "${ctp}/study/crawling/jsoup3",
			type : "post",
			success : function(vos) {
				if (vos != "") {
					let str = '<table class="table table-bordered text-center">';
					str += '<tr class="table-secondary"><th>번호</th><th>제목</th><th>사진</th><th>언론사</th></tr>';
					for (let i = 0; i < vos.length; i++) {
						str += '<tr>';
						str += '<td>' + (i + 1) + '</td>';
						str += '<td>' + vos[i].item1 + '</td>';
						str += '<td>' + vos[i].item2 + '</td>';
						str += '<td>' + vos[i].item3 + '</td>';
						str += '</tr>';
					}
					str += '<tr><td colspan="4" class="p-0 m-0"></td></tr>';
					str += '</table>';
					$("#demo").html(str);
				} else
					$("#demo").html("검색된 자료가 없습니다.");
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}

	// 네어버 검색어로 검색결과 가져오기
	function crawling4() {
		let searchString = document.getElementById("searchString").value;
		let page = document.getElementById("page").value;
		if (searchString.trim() == "") {
			alert("검색어를 입력하세요");
			document.getElementById("searchString").focus();
			return false;
		}
		if (page.trim() == "")
			page = 1;

		let search = "https://search.naver.com/search.naver?nso=&page=" + page + "&query=" + searchString + "&sm=tab_pge&start=" + (page * 15 + 1) + "&where=web";
		let searchSelector = "div.total_dsc_wrap";

		$.ajax({
			url : "${ctp}/study/crawling/jsoup4",
			type : "post",
			data : {
				search : search,
				searchSelector : searchSelector
			},
			success : function(vos) {
				if (vos != "") {
					let str = '';
					for (let i = 0; i < vos.length; i++) {
						str += vos[i] + "<br/>";
					}
					$("#demo").html(str);
				} else
					$("#demo").html("검색된 자료가 없습니다.");
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}
	
	// 네어버 검색어로 그림검색결과 가져오기
	function crawling5() {
		let searchString = document.getElementById("searchString").value;
		let page = document.getElementById("page").value;
		if (searchString.trim() == "") {
			alert("검색어를 입력하세요");
			document.getElementById("searchString").focus();
			return false;
		}
		if (page.trim() == "")
			page = 1;

		let search = "https://search.naver.com/search.naver?nso=&page=" + page + "&query=" + searchString + "&sm=tab_pge&start=" + (page * 15 + 1) + "&where=web";
		// let searchSelector = "div.thumb_single._parent"; // 링크
		let searchSelector = "a.thumb_link"; // 이미지

		$.ajax({
			url : "${ctp}/study/crawling/jsoup4",
			type : "post",
			data : {
				search : search,
				searchSelector : searchSelector
			},
			success : function(vos) {
				if (vos != "") {
					let str = '';
					for (let i = 0; i < vos.length; i++) {
						str += vos[i] + "<br/>";
					}
					$("#demo").html(str);
				} else
					$("#demo").html("검색된 자료가 없습니다.");
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
	<div class="container my-5">
		<h2>JSOUP을 이용한 웹 크롤링</h2>
		<hr />
		<div>
			<a href="javascript:location.reload()" class="btn btn-warning form-control">다시검색</a>
		</div>
		<hr />
		<form name="myform">
			<div class="input-group mb-3">
				<div class="input-group-text">크롤링할 웹 주소</div>
				<select name="url" id="url" class="form-control">
					<option value="">URL을 선택하세요.</option>
					<option>1.네이버뉴스-https://news.naver.com/</option>
					<option>2.네이버뉴스(이미지)-https://news.naver.com/</option>
					<option>3.네이버뉴스(언론사)-https://news.naver.com/</option>
				</select>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-text">크롤링할 셀렉터</div>
				<select name="selector" id="selector" class="form-control">
					<option value="">셀렉터를 선택하세요.</option>
					<option>1.div.cjs_t</option>
					<option>2.div.cjs_news_mw</option>
					<option>3.h4.channel</option>
				</select>
				<div class="input-group-append">
					<input type="button" value="크롤링" onclick="crawling1()" class="btn btn-success" />
				</div>
			</div>
			<div class="my-3">
				<input type="button" value="크롤링2(네이버 헤드라인뉴스)" onclick="crawling2()" class="btn btn-primary" />
			</div>
			<div class="my-3">
				<input type="button" value="크롤링3(다음 엔터테인먼트)" onclick="crawling3()" class="btn btn-danger" />
			</div>
			<div class="input-group mb-3">
				<div class="input-group-text">네이버 검색어로 검색(검색어)</div>
				<input type="text" name="searchString" id="searchString" value="인사이드아웃2" class="form-control">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-text">네이버 검색어로 검색(페이지번호)</div>
				<input type="text" name="page" id="page" value="2" class="form-control">
				<div class="input-group-append">
					<input type="button" value="크롤링4" onclick="crawling4()" class="btn btn-info" />
				</div>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-text">네이버 검색어로 그림검색(검색어)</div>
				<input type="text" name="searchString" id="searchString" value="인사이드아웃2" class="form-control">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-text">네이버 검색어로 그림검색(페이지번호)</div>
				<input type="text" name="page" id="page" value="2" class="form-control">
				<div class="input-group-append">
					<input type="button" value="크롤링5" onclick="crawling5()" class="btn btn-dark" />
				</div>
			</div>
		</form>
		<hr>
		<div id="demo"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>