<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakaomap.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<div id="map" style="width: 100%; height: 500px;"></div>
		<!-- 카카오맵 javascript API -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=72fa02985e6ba64cf44f44ded5806dd8"></script>
		<script>
			// 1. 지도를 띄워주는 기본 코드(지도 생성)
			var container = document.getElementById('map');
			var options = {
				center : new kakao.maps.LatLng(36.635167247264256, 127.459485217679), // 지도의 중심좌표
				level : 3
			// 지도의 확대, 축소 레벨
			};

			var map = new kakao.maps.Map(container, options);
		</script>

		<hr>
		<jsp:include page="kakaoMenu.jsp" />
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>