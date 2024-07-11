<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gantChart</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [
			'gantt'
		]
	});
	google.charts.setOnLoadCallback(drawChart);

	function daysToMilliseconds(days) {
		return days * 24 * 60 * 60 * 1000;
	}

	function drawChart() {

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Task ID');
		data.addColumn('string', 'Task Name');
		data.addColumn('date', 'Start Date');
		data.addColumn('date', 'End Date');
		data.addColumn('number', 'Duration');
		data.addColumn('number', 'Percent Complete');
		data.addColumn('string', 'Dependencies');

		data.addRows([
				[
						'Research', 'Find sources', new Date(2015, 0, 1), new Date(2015, 0, 5), null, 100, null
				], [
						'Write', 'Write paper', null, new Date(2015, 0, 9), daysToMilliseconds(3), 25, 'Research,Outline'
				], [
						'Cite', 'Create bibliography', null, new Date(2015, 0, 7), daysToMilliseconds(1), 20, 'Research'
				], [
						'Complete', 'Hand in paper', null, new Date(2015, 0, 10), daysToMilliseconds(1), 0, 'Cite,Write'
				], [
						'Outline', 'Outline paper', null, new Date(2015, 0, 6), daysToMilliseconds(1), 100, 'Research'
				]
		]);

		var options = {
			height : 275
		};

		var chart = new google.visualization.Gantt(document.getElementById('chart_div'));

		chart.draw(data, options);
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<div id="chart_div"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>