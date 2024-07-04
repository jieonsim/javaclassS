<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakaoEx3.jsp(MyDB에 저장된 지명검색)</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	function addressSave() {
		let address = myform.selectAddress.value;
		let latitude = myform.latitude.value;
		let longitude = myform.longitude.value;
		if (address == "") {
			alert("저장할 지점의 마커를 선택하세요.");
			return false;
		}
		let query = {
			address : address,
			latitude : latitude,
			longitude : longitude
		}

		$.ajax({
			url : "${ctp}/study/kakao/kakaoEx1",
			type : "post",
			data : query,
			success : function(res) {
				if (res != "0") {
					alert("선택한 지점이 MyDB에 저장되었습니다.");
				} else {
					alert("저장 실패하였습니다. 같은 지점명이 있습니다. 이름을 변경하여 다시 등록하세요.");
				}
			},
			error : function() {
				alert("전송 오류");
			}

		});
	}

	function addressDelete() {
		let address = myform.address.value;
		if (address == "") {
			alert("삭제할 지점을 선택하세요");
			return false;
		}
		let ans = confirm("검색한 지점명을 MyDB에서 삭제하시겠습니까?");
		if (!ans)
			return false;

		$.ajax({
			url : "${ctp}/study/kakao/kakaoAddressDelete",
			type : "post",
			data : {
				address : address
			},
			success : function(res) {
				if (res != "0") {
					alert("선택한 지점이 MyDB에 삭제 되었습니다.");
					location.href = "${ctp}/study/kakao/kakaoEx2";
				} else
					alert("삭제 실패~~");
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
		<h2>kakaoDB에 저장된 키워드 검색 후 MyDB에 저장하기(${address})</h2>
		<hr />
		<form name="myform">
			<div>
				키워드 검색 :
				<input type="text" name="address" id="address" autofocus required>
				<input type="submit" value="키워드검색" onclick="addressSearch()" />
				<input type="button" value="검색된 지점을 MyDB에 저장" onclick="addressSave()" />
			</div>
			<input type="hidden" name="selectAddress" id="selectAddress">
			<input type="hidden" name="latitude" id="latitude">
			<input type="hidden" name="longitude" id="longitude">
		</form>
		<div id="demo"></div>
		<hr />
		<div id="map" style="width: 100%; height: 500px;"></div>

		<!-- 카카오맵 Javascript API -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=72fa02985e6ba64cf44f44ded5806dd8&libraries=services"></script>
		<script>
			var infowindow = new kakao.maps.InfoWindow({
				zIndex : 1
			});

			// 1.지도를 띄워주는 기본 코드(지도 생성)
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(36.63508163115122, 127.45948750459904), // 지도의 중심좌표
				level : 3
			// 지도의 확대 레벨
			};

			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption);

			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();

			// 키워드로 장소를 검색합니다
			ps.keywordSearch('${address}', placesSearchCB);

			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB(data, status, pagination) {
				if (status === kakao.maps.services.Status.OK) {

					// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
					// LatLngBounds 객체에 좌표를 추가합니다
					var bounds = new kakao.maps.LatLngBounds();

					for (var i = 0; i < data.length; i++) {
						displayMarker(data[i]);
						bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
					}

					// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
					map.setBounds(bounds);
				}
			}

			// 지도에 마커를 표시하는 함수입니다
			function displayMarker(place) {

				// 마커를 생성하고 지도에 표시합니다
				var marker = new kakao.maps.Marker({
					map : map,
					position : new kakao.maps.LatLng(place.y, place.x)
				});

				// 마커에 클릭이벤트를 등록합니다
				kakao.maps.event.addListener(marker, 'click', function() {
					// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
					infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
					infowindow.open(map, marker);
					$("#selectAddress").val(place.place_name);
					$("#latitude").val(place.y);
					$("#longitude").val(place.x);
					$("#demo").html("장소명 : " + place.place_name + ", 위도 : " + place.y + ", 경도 : " + place.x);
				});
			}
		</script>
		<hr />
		<jsp:include page="kakaoMenu.jsp" />
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>