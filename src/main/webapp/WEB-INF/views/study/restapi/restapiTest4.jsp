<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>restapiTest4.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
    'use strict';
    
    const API_KEY = '7WMGwpEENfXvFnxY1efwZ4263gPHczyuehE7RyufhGeO4SZPOKxDisyWglB%2BjylPIXZJu8Xxs8BCWVbLqr9PdA%3D%3D';
    
    async function getCrimeDate() {
    	let year = $("#year").val();
    	let apiYear = '';
    	
    	if(year == 2015) apiYear = "/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669";
    	else if(year == 2016) apiYear = "/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff";
    	else if(year == 2017) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
    	else if(year == 2018) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
    	else if(year == 2019) apiYear = "/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0";
    	else if(year == 2020) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
    	else if(year == 2021) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
    	else if(year == 2022) apiYear = "/15084592/v1/uddi:5e08264d-acb3-4842-b494-b08f318aa14c";
    	
    	let url = "https://api.odcloud.kr/api";
    	url += apiYear;
    	url += "?serviceKey=" + API_KEY;
    	url += "&page=1&perPage=200";
    	
    	let response = await fetch(url);
    	//console.log("response : ", response);
    	
    	let res = await response.json();
    	console.log("res : ", res);
    	
    	/*
    	let str = res.data.map((item, i) =>
    		(i+1) + "."
    		+ "발생년도 : " + item.발생년도 + "년"
    		+ ", 경찰서 : " +  item.경찰서 + "건"
    		+ ", 강도 : " + item.강도 + "건"
    		+ ", 절도 : " + item.절도 + "건"
    		+ ", 살인 : " + item.살인 + "건"
    		+ "<br/>"
    	);
    	*/
    	
    	let str = '<table class="table table-bordered table-hover text-center">';
    	str += '<tr class="table-secondary">';
    	str += '<th>번호</th><th>발생년도</th><th>경찰서/지역</th><th>강도</th><th>절도</th><th>살인</th><th>폭력</th>';
    	str += '</tr>';
    	str += res.data.map((item, i) =>
    		'<tr><td>' + (i+1) + '</td>'
    		+ '<td>' + item.발생년도 + '년</td>'
    		+ '<td>' +  item.경찰서 + '건</td>'
    		+ '<td>' + item.강도 + '건</td>'
    		+ '<td>' + item.절도 + '건</td>'
    		+ '<td>' + item.살인 + '건</td>'
    		+ '<td>' + item.폭력 + '건</td></tr>'
    	).join('');					// map형식의 연속된 자료는 배열처럼 저장된다. 이때 기본 구분자가 ','인데, 이것을 join()함수를 이용하여 공백으로 바꿔준다.
    	str += '</table>';
    	$("#demo").html(str);
    }
    
    // 검색한 자료를 DB에 저장하기
    async function saveCrimeDate() {
    	let year = $("#year").val();
    	let apiYear = '';
    	
    	if(year == 2015) apiYear = "/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669";
    	else if(year == 2016) apiYear = "/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff";
    	else if(year == 2017) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
    	else if(year == 2018) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
    	else if(year == 2019) apiYear = "/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0";
    	else if(year == 2020) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
    	else if(year == 2021) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
    	else if(year == 2022) apiYear = "/15084592/v1/uddi:5e08264d-acb3-4842-b494-b08f318aa14c";
    	
    	let url = "https://api.odcloud.kr/api";
    	url += apiYear;
    	url += "?serviceKey=" + API_KEY;
    	url += "&page=1&perPage=200";
    	
    	let response = await fetch(url);
    	//console.log("response : ", response);
    	
    	let res = await response.json();
    	console.log("res : ", res);
    	
    	let str = res.data.map((item, i) => [
    		(i+1) + "."
    		+ "발생년도 : " + item.발생년도 + "년"
    		+ ", 경찰서 : " +  item.경찰서 + "건"
    		+ ", 강도 : " + item.강도 + "건"
    		+ ", 절도 : " + item.절도 + "건"
    		+ ", 살인 : " + item.살인 + "건"
    		+ ", 폭력 : " + item.폭력 + "건"
    		+ "<br/>"
    	]);
    	
    	$("#demo").html(str);
    	
    	// 화면에 출력된 자료들을 모두 DB에 저장시켜준다.
    	//alert("경찰서 : " + res.data[0].강도);
    	let query = "";
    	for(let i=0; i<res.data.length; i++) {
    		if(res.data[i].경찰서 != null) {
    			query = {
    					year			: year,
    					police		: res.data[i].경찰서,
    					robbery		: res.data[i].강도,
    					theft			: res.data[i].절도,
    					murder		: res.data[i].살인,
    					violence	: res.data[i].폭력
    			}
    		}
    		
    		$.ajax({
    			url  : "${ctp}/study/restapi/saveCrimeDate",
    			type : "post",
    			data : query,
    			error: function() {
    				alert("전송오류!");
    			}
    		});
    	}
    	alert(year + "년도 자료가 DB에 저장되었습니다.");
    }
    
    // 콤보박스의 년도자료를 DB에서 삭제한다.
    function deleteCrimeDate() {
    	let year = $("#year").val();
    		
  		$.ajax({
  			url  : "${ctp}/study/restapi/deleteCrimeDate",
  			type : "post",
  			data : {year : year},
  			error: function() {
  				alert("전송오류!");
  			}
  		});
    	alert(year + "년도 자료가 DB에서 삭제되었습니다.");
    }
    
    // 선택한 년도별 DB에서 자료 가져와서 출력하기
    function listCrimeDate() {
    	let year = $("#year").val();
    	
    	$.ajax({
    		url  : "${ctp}/study/restapi/listCrimeDate",
    		type : "post",
    		data : {year : year},
    		success:function(vos) {
    			//console.log(vos);
    			let str = '';
    			str += '<table class="table table-bordered table-hover text-center"><tr style="background-color:#eee">';
    			str += '<th>번호</th><th>발생년도</th><th>경찰서/지역</th><th>강도</th><th>절도</th><th>살인</th><th>폭력</th>';
    			for(let i=0; i<vos.length; i++) {
    				str += '<tr>';
    				str += '<td>'+(i+1)+'</td>';
    				str += '<td>'+vos[i].year+'</td>';
    				str += '<td>'+vos[i].police+'</td>';
    				str += '<td>'+vos[i].robbery+'</td>';
    				str += '<td>'+vos[i].theft+'</td>';
    				str += '<td>'+vos[i].murder+'</td>';
    				str += '<td>'+vos[i].violence+'</td>';
    				str += '</tr>';
    			}
    			str += '<tr><td colspan="4" class="m-0 p-0"></td></tr>';
    			str += '</table>';
    			$("#demo").html(str);
    		},
    		error: function() {
    			alert("전송오류~~");
    		}
    	});
    }
    
    // 경찰서별 + 년도별.. DB자료 출력
    function yearPoliceCheck() {
    	myform.action = "${ctp}/study/restapi/yearPoliceCheck";
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
		<h2>경찰청 강력범죄 발생 현황 자료 리스트</h2>
		<hr />
		<form name="myform" method="post">
			<div class="input-group mb-3">
				<select name="year" id="year" class="custom-select mr-1">
					<c:forEach var="i" begin="2015" end="2022">
						<option value="${i}" ${year == i ? 'selected' : ''}>${i}년도</option>
					</c:forEach>
				</select>
				<input type="button" value="강력범죄제공현황조회" onclick="getCrimeDate()" class="btn btn-success mr-1" />
				<input type="button" value="강력범죄DB저장" onclick="saveCrimeDate()" class="btn btn-primary mr-1" />
				<input type="button" value="강력범죄DB삭제" onclick="deleteCrimeDate()" class="btn btn-danger mr-1" />
				<input type="button" value="강력범죄DB출력" onclick="listCrimeDate()" class="btn btn-info" />
			</div>
			<div class="input-group">
				<div class="input-group-prepend">
					<span class="input-group-text">경찰서 지역명</span>
				</div>
				<select name="police" onchange="policeCheck()" class="mr-3">
					<option>서울</option>
					<option>경기</option>
					<option>강원</option>
					<option>충북</option>
					<option>충남</option>
					<option>전북</option>
					<option>전남</option>
					<option>경북</option>
					<option>경남</option>
					<option>제주</option>
				</select>
				<div class="form-check-inline">
					<input type="radio" name="yearOrder" value="asc" checked class="form-check-input" />
					오름차순
				</div>
				<div class="form-check-inline">
					<input type="radio" name="yearOrder" value="desc" class="form-check-input" />
					내름차순
				</div>
				<input type="button" value="년도/경찰서별출력" onclick="yearPoliceCheck()" class="btn btn-secondary mr-2" />
				<input type="button" value="다시검색" onclick="location.reload()" class="btn btn-warning" />
			</div>
		</form>
		<hr />
		<div id="demo"></div>
		<hr />
		<!-- 1. 년도/강도/살인/절도/폭력  -->
		<!-- 2. 경찰서별 통계 :  년도/강도/살인/절도/폭력  -->
		<!-- 3. 범죄발생건수가 가장 작은 지역? -->
		<c:if test="${!empty vos}">
			<h3>
				<font color="blue">
					<b>${year}년 ${police}지역</b>
				</font>
				범죄 분석 통계(
				<font color="red">
					<b>합계</b>
				</font>
				)
			</h3>
			<table class="table table-hover">
				<tr class="table-dark text-dark">
					<th>구분</th>
					<th>년도</th>
					<th>강도</th>
					<th>살인</th>
					<th>절도</th>
					<th>폭력</th>
				</tr>
				<tr>
					<td>총계</td>
					<td>${analyzeVo.year}</td>
					<td>${analyzeVo.totRobbery}</td>
					<td>${analyzeVo.totMurder}</td>
					<td>${analyzeVo.totTheft}</td>
					<td>${analyzeVo.totViolence}</td>
				</tr>
			</table>
			<hr />
			<h3>
				<font color="blue">
					<b>${year}년 ${police}지역</b>
				</font>
				범죄 분석 통계(
				<font color="red">
					<b>평균</b>
				</font>
				)
			</h3>
			<table class="table table-hover">
				<tr class="table-dark text-dark">
					<th>구분</th>
					<th>년도</th>
					<th>강도</th>
					<th>살인</th>
					<th>절도</th>
					<th>폭력</th>
				</tr>
				<tr>
					<td>평균</td>
					<td>${analyzeVo.year}</td>
					<td>
						${analyzeVo.avgRobbery}
						<c:set var="biyul" value="${analyzeVo.totRobbery/totalCnt}" />
						건 (
						<fmt:formatNumber value="${biyul}" type="percent" pattern="#0.0#%"/>
						)
					</td>
					<td>
						${analyzeVo.avgMurder}
						<c:set var="biyul" value="${analyzeVo.totMurder/totalCnt}" />
						건 (
						<fmt:formatNumber value="${biyul}" type="percent"  pattern="#0.0#%"/>
						)
					</td>
					<td>
						${analyzeVo.avgTheft}
						<c:set var="biyul" value="${analyzeVo.totTheft/totalCnt}" />
						건 (
						<fmt:formatNumber value="${biyul}" type="percent" />
						)
					</td>
					<td>
						${analyzeVo.avgViolence}
						<c:set var="biyul" value="${analyzeVo.totViolence/totalCnt}" />
						건 (
						<fmt:formatNumber value="${biyul}" type="percent"  pattern="#0.0#%"/>
						)
					</td>
				</tr>
			</table>
			<hr />
			<h3>
				<font color="blue">
					<b>${year}년 ${police}지역 </b>
				</font>
				범죄 통계 현황(총 :
				<font color="bule">
					<b>${fn:length(vos)}</b>
				</font>
				건)
			</h3>
			<table class="table table-hover">
				<tr class="table-dark text-dark">
					<th>구분</th>
					<th>년도</th>
					<th>경찰서</th>
					<th>강도</th>
					<th>살인</th>
					<th>절도</th>
					<th>폭력</th>
				</tr>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr>
						<td>${st.count}</td>
						<td>${vo.year}</td>
						<td>${vo.police}</td>
						<td>${vo.robbery}</td>
						<td>${vo.murder}</td>
						<td>${vo.theft}</td>
						<td>${vo.violence}</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="7" class="p-0 m-0"></td>
				</tr>
			</table>
		</c:if>
	</div>
	<p>
		<br />
	</p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>