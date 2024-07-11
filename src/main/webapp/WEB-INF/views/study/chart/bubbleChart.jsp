<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bubbleChart</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [
			'corechart'
		]
	});
	google.charts.setOnLoadCallback(drawChart);

	function drawChart() {
		var data = google.visualization.arrayToDataTable([
				[
						'Age', 'Weight'
				], [
						8, 12
				], [
						4, 5.5
				], [
						11, 14
				], [
						4, 5
				], [
						3, 3.5
				], [
						6.5, 7
				]
		]);

		var options = {
			title : 'Age vs. Weight comparison',
			hAxis : {
				title : 'Age',
				minValue : 0,
				maxValue : 15
			},
			vAxis : {
				title : 'Weight',
				minValue : 0,
				maxValue : 15
			},
			legend : 'none'
		};

		var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));

		chart.draw(data, options);
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<div id="chart_div" style="width: 900px; height: 500px;"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>