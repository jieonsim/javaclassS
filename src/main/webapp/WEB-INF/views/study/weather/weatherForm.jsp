<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>weatherForm.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	function accessToGeo(position) {
		const positionObj = {
			latitude : position.coords.latitude,
			longitude : position.coords.longitude
		}
		let lot = "(현재위치) 위도 : " + positionObj.latitude + " , 경도 : " + positionObj.longitude;
		$("#demo").text(lot);
	}

	$(document).ready(function() {
		function convertTime() {
			var now = new Date();
			var month = now.getMonth() + 1;
			var date = now.getDate();
			return month + '월' + date + '일';
		}
		var currentTime = convertTime();
		$('.nowtime').append(currentTime);
	});

	function weatherCheck1() {
		navigator.geolocation.getCurrentPosition(accessToGeo)
	}

	$.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&appid=91e0cc30e67a2ab642c89a1d3eda04a8&units=metric', function(WeatherResult) {
		$('.SeoulNowtemp').append(WeatherResult.main.temp + " ℃");
		$('.SeoulLowtemp').append(WeatherResult.main.temp_min + " ℃");
		$('.SeoulHightemp').append(WeatherResult.main.temp_max + " ℃");

		var weathericonUrl = '<img src= "http://openweathermap.org/img/wn/'
          + WeatherResult.weather[0].icon +
          '.png" alt="' + WeatherResult.weather[0].description + '"/>';
		$('.SeoulIcon').html(weathericonUrl);
	});

	// 현재지역날씨.
	function weatherCheck2() {
		navigator.geolocation.getCurrentPosition(accessToGeo2)
	}

	function accessToGeo2(position) {
		const positionObj = {
			latitude : position.coords.latitude,
			longitude : position.coords.longitude
		}

		let lot = "(현재위치) 위도 : " + positionObj.latitude + " , 경도 : " + positionObj.longitude;
		$("#demo").text(lot);

		$.getJSON('https://api.openweathermap.org/data/2.5/weather?lat=' + position.coords.latitude + '&lon=' + position.coords.longitude + '&appid=91e0cc30e67a2ab642c89a1d3eda04a8&units=metric', function(WeatherResult) {
			$(".dispForm2").show();

			$('.nowtemp').html("현재기온 : " + WeatherResult.main.temp + " ℃");
			$('.lowtemp').html("최저기온 : " + WeatherResult.main.temp_min + " ℃");
			$('.hightemp').html("최고기온 : " + WeatherResult.main.temp_max + " ℃");

			var weathericonUrl = '<img src= "http://openweathermap.org/img/wn/'
            + WeatherResult.weather[0].icon +
            '.png" alt="' + WeatherResult.weather[0].description + '"/>';
			$('.icon2').html(weathericonUrl);

		});
	}

	// DB에서 지역을 찾아서 그 위치의 날씨를 출력처리
	let jiyuk = "";
	function weatherCheck3() {
		jiyuk = document.getElementById("jiyuk").value.split("/");

		navigator.geolocation.getCurrentPosition(accessToGeo3);
	}

	function accessToGeo3(position) {
		const positionObj = {
			latitude : jiyuk[1],
			longitude : jiyuk[2]
		}

		let lot = "(현재위치) 위도 : " + positionObj.latitude + " , 경도 : " + positionObj.longitude;
		$("#demo").text(lot);

		$.getJSON('https://api.openweathermap.org/data/2.5/weather?lat=' + positionObj.latitude + '&lon=' + positionObj.longitude + '&appid=91e0cc30e67a2ab642c89a1d3eda04a8&units=metric', function(WeatherResult) {
			$(".dispForm3").show();
			$('.jiyukName').html(jiyuk[0]);
			$('.nowTempl').html('현재기온:' + WeatherResult.main.temp + " ℃");
			$('.lowTempl').text('최저기온:' + WeatherResult.main.temp_min + " ℃");
			$('.highTempl').text('최고기온:' + WeatherResult.main.temp_max + " ℃");

			var weathericonUrl = '<img src= "http://openweathermap.org/img/wn/'
            + WeatherResult.weather[0].icon +
            '.png" alt="' + WeatherResult.weather[0].description + '"/>';
			$('.icon3').html(weathericonUrl);

		});
	}
</script>
<style>
.dispForm {
	float: left;
}

#line {
	clear: both;
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
		<h2>날씨정보 확인하기</h2>
		<hr />
		<input type="button" value="현재위치보기" onclick="weatherCheck1()" class="btn btn-success" />
		<input type="button" value="현재위치날씨" onclick="weatherCheck2()" class="btn btn-primary mr-3" />
		<select name="jiyuk" id="jiyuk" onchange="weatherCheck3()">
			<option value="">지역선택</option>
			<c:forEach var="jiyuk" items="${jiyukVos}" varStatus="st">
				<option value="${jiyuk.address}/${jiyuk.latitude}/${jiyuk.longitude}">${jiyuk.address}</option>
			</c:forEach>
		</select>
		<hr />
		<div id="demo"></div>
		<hr />
		<div class="card m-3 dispForm" style="width: 180px; margin: 20px 0 24px 0">
			<div class="SeoulIcon"></div>
			<div class="card-body">
				<h4 class="card-title">서울</h4>
				<p class="card-text SeoulNowtemp">현재기온:</p>
				<p class="card-text SeoulLowtemp">최저기온:</p>
				<p class="card-text SeoulHightemp">최고기온:</p>
			</div>
		</div>
		<div class="card m-3 dispForm dispForm2" style="width: 180px; margin: 20px 0 24px 0; display: none;">
			<div class="icon2"></div>
			<div class="card-body">
				<h4 class="card-title">청주</h4>
				<p class="card-text nowtemp">현재기온:</p>
				<p class="card-text lowtemp">최저기온:</p>
				<p class="card-text hightemp">최저기온:</p>
			</div>
		</div>
		<div class="card m-3 dispForm dispForm3" style="width: 180px; margin: 20px 0 24px 0; display: none;">
			<div class="icon3"></div>
			<div class="card-body">
				<h4 class="card-title jiyukName"></h4>
				<p class="card-text nowTempl">현재기온:</p>
				<p class="card-text lowTempl">최저기온:</p>
				<p class="card-text highTempl">최저기온:</p>
			</div>
		</div>
		<hr id="line" />
	</div>
	<p>
		<br />
	</p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>