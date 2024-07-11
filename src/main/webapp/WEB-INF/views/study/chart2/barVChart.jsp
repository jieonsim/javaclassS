<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>barVChart.jsp</title>
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
						'Year', '${vo.legend1}', '${vo.legend2}', '${vo.legend3}'
				], [
						'${vo.x1}', ${vo.x1Value1}, ${vo.x1Value2}, ${vo.x1Value3}
				], [
						'${vo.x2}', ${vo.x2Value1}, ${vo.x2Value2}, ${vo.x2Value3}
				], [
						'${vo.x3}', ${vo.x3Value1}, ${vo.x3Value2}, ${vo.x3Value3}
				], [
						'${vo.x4}', ${vo.x4Value1}, ${vo.x3Value2}, ${vo.x4Value3}
				]
		]);

		var options = {
			chart : {
				title : '${vo.title}',
				subtitle : '${vo.subTitle}',
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
	<p>
		<br />
	</p>
	<div class="container">
		<div id="columnchart_material" style="width: 800px; height: 500px;"></div>
	</div>
	<p>
		<br />
	</p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>