<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>barVChart</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [
			'bar'
		]
	});
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		var data = google.visualization.arrayToDataTable([
				[
						'Year', '냉장고', '세탁기', '에어컨'
				], [
						'2014', 1000, 400, 200
				], [
						'2015', 1170, 460, 250
				], [
						'2016', 660, 1120, 300
				], [
						'2017', 1030, 540, 350
				]
		]);

		var options = {
			chart : {
				title : '우수대리점 년도별 판매 현황',
				subtitle : '(각 분기별 합계 : 단위(백대))',
			}
		};

		var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

		chart.draw(data, google.charts.Bar.convertOptions(options));
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<div id="columnchart_material" style="width: 800px; height: 500px;"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>