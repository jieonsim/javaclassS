<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
pageContext.setAttribute("newLine", "\n");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>guestList2.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
th {
	background-color: #eee;
	text-align: center;
}
</style>
<script>
	'use strict';

	function delCheck(idx) {
		let ans = confirm("현재 방문글을 삭제하시겠습니까?");
		if (ans) {
			location.href = '${ctp}/admin/guest/guestDelete?idx=' + idx;
			return false;
		}
	}

	function pageSizeCheck() {
		let pageSize = document.getElementById("pageSize").value;
		location.href = "${ctp}/admin/guest/guestList?pag=${pag}&pageSize=" + pageSize;
	}
</script>
</head>
<body>
	<p>
		<br />
	</p>
	<div class="container">
		<h2 class="text-center">방 명 록 리 스 트(기본 페이징 처리)</h2>
		<table class="table table-borderless m-0 p-0">
			<tr>
				<!-- <td><a href="#" class="btn btn-primary">관리자</a></td> -->
				<td>
					<a href="${ctp}/guest/guestInput" class="btn btn-success">글쓰기</a>
				</td>
				<td class="text-right">
					<c:if test="${pag > 1}">
						<a href="${ctp}/admin/guestList/guestList?pag=1&pageSize=${pageSize}" title="첫페이지">◁◁</a>
						<a href="${ctp}/admin/guestList/guestList?pag=${pag-1}&pageSize=${pageSize}" title="이전페이지">◀</a>
					</c:if>
					${pag}/${totPage}
					<c:if test="${pag < totPage}">
						<a href="${ctp}/admin/guestList/guestList?pag=${pag+1}&pageSize=${pageSize}" title="다음페이지">▶</a>
						<a href="${ctp}/admin/guestList/guestList?pag=${totPage}&pageSize=${pageSize}" title="마지막페이지">▷▷</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-right">
					<select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
						<option <c:if test="${pageSize == 2}">selected</c:if>>2</option>
						<option <c:if test="${pageSize == 3}">selected</c:if>>3</option>
						<option <c:if test="${pageSize == 5}">selected</c:if>>5</option>
						<option <c:if test="${pageSize == 10}">selected</c:if>>10</option>
					</select>
				</td>
			</tr>
		</table>
		<c:set var="curScrStartNo" value="${curScrStartNo}" />
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<table class="table table-borderless m-0 p-0">
				<tr>
					<td>
						번호 : ${curScrStartNo}
						<c:if test="${sAdmin == 'OK' || sName == vo.name}">
							<a href="javascript:delCheck(${vo.idx})" class="btn btn-danger btn-sm">삭제</a>
						</c:if>
					</td>
					<td class="text-right">방문IP : ${vo.hostIp}</td>
				</tr>
			</table>
			<table class="table table-bordered">
				<tr>
					<th>성명</th>
					<td>${vo.name}</td>
					<th>방문일자</th>
					<td>${fn:substring(vo.visitDate,0,19)}</td>
				</tr>
				<tr>
					<th>메일주소</th>
					<td colspan="3">
						<%-- 
	        <c:if test="${vo.email == '' || vo.email == null}">- 없음 -</c:if>
	        <c:if test="${vo.email != '' && vo.email != null}">${vo.email}</c:if>
	         --%>
						<c:if test="${empty vo.email || fn:length(vo.email)<6 || fn:indexOf(vo.email,'@')==-1 || fn:indexOf(vo.email,'.')==-1}">- 없음 -</c:if>
						<c:if test="${!empty vo.email && fn:length(vo.email)>=6 && fn:indexOf(vo.email,'@')!=-1 && fn:indexOf(vo.email,'.')!=-1}">${vo.email}</c:if>
					</td>
				</tr>
				<tr>
					<th>홈페이지</th>
					<td colspan="3">
						<c:if test="${empty vo.homePage || fn:length(vo.homePage)<=10 || fn:indexOf(vo.homePage,'.')==-1}">- 없음 -</c:if>
						<c:if test="${!empty vo.homePage && fn:length(vo.homePage)>10 && fn:indexOf(vo.homePage,'.')!=-1}">
							<a href='${vo.homePage}' target='_blank'>${vo.homePage}</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>방문소감</th>
					<td colspan="3">${fn:replace(vo.content, newLine, "<br/>")}</td>
				</tr>
			</table>
			<br />
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
		</c:forEach>
		<br />

		<!-- 블록페이지 시작 ddd-->
		<div class="text-center">

			<c:if test="${pag > 1}">[<a href="${ctp}/admin/guestList/guestList?pag=1&pageSize=${pageSize}">첫페이지</a>]</c:if>
			<c:if test="${curBlock > 0}">[<a href="${ctp}/admin/guestList/guestList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">이전블록</a>]</c:if>
			<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
				<c:if test="${i <= totPage && i == pag}">
					<a href="${ctp}/admin/guestList/guestList?pag=${i}&pageSize=${pageSize}">
						[
						<font color="red">
							<b>${i}</b>
						</font>
						]
					</a>
				</c:if>
				<c:if test="${i <= totPage && i != pag}">
					<a href="${ctp}/admin/guestList/guestList?pag=${i}&pageSize=${pageSize}">[${i}]</a>
				</c:if>
			</c:forEach>
			<c:if test="${curBlock < lastBlock}">[<a href="${ctp}/admin/guestList/guestList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블록</a>]</c:if>
			<c:if test="${pag < totPage}">[<a href="${ctp}/admin/guestList/guestList?pag=${totPage}&pageSize=${pageSize}">마지막페이지</a>]</c:if>

		</div>
		<!-- 블록페이지 끝 -->

	</div>
	<p>
		<br />
	</p>
</body>
</html>