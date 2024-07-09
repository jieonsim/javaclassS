<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>thumbnailResult</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<h2>저장된 썸네일 이미지 보기</h2>
		<hr>
		<div>
			<h3>서버에 저장된 파일정보(총 : ${fileCount}건)</h3>
			<div class="row">
				<div class="col">저장경로 : ${ctp}/resources/data/thumbnail/*.*</div>
				<div class="col">
					<!-- 파일 삭제 -->
					<input type="button" value="폴더 내 모든 파일 삭제" onclick="fileDeleteAll()" class="btn btn-danger">
				</div>
			</div>
			<table class="table table-hover text-center">
				<tr class="table-secondary">
					<th>번호</th>
					<th>파일명</th>
					<th>썸네일이미지</th>
					<th>비고</th>
				</tr>
				<c:forEach var="file" items="${files}" varStatus="st">
					<c:if test="${fn:substring(file, 0, 2) == 's_'}">
						<tr>
							<td>${fileCount}</td>
							<td>${fn:substring(file,2,fn:length(file))}</td>
							<td>
								<a href="${ctp}/thumbnail/${fn:substring(file,2,fn:length(file))}" target="_blank">
									<img src="${ctp}/thumbnail/${file}">
								</a>
							</td>
							<td>
								<input type="button" value="삭제" onclick="fileDelete('${file}')" class="btn btn-danger btn-sm" />
							</td>
						</tr>
						<c:set var="fileCount" value="${fileCount - 1}" />
					</c:if>
				</c:forEach>
				<tr>
					<td colspan="4" class="m-0 p-0"></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>