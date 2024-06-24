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
<title>guestList.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
th {
	background-color: #eee;
	text-align: center;
}
</style>
<script>
	'ues strict';

	function delCheck(idx) {
		let ans = confirm('현재 방문글을 삭제하시겠습니까?');
		if (ans) {
			location.href = '${ctp}/GuestDelete?idx=' + idx;
			return false;
		}
	}

	function pageSizeCheck() {
		let pageSize = document.getElementById("pageSize").value;
		location.href = "${ctp}/GuestList?pag=${pag}&pageSize=" + pageSize;
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
		<h2 class="text-center">방 명 록 리 스 트</h2>
		<table class="table table-borderless m-0 p-0">
			<tr>
				<!-- <td><a href="#" class="btn btn-primary">관리자</a></td> -->
				<td>
					<a href="${ctp}/guest/guestInput" class="btn btn-success">글쓰기</a>
				</td>
				<td class="text-right">
					<c:if test="${pag > 1}">
						<a href="${ctp}/GuestList?pag=1" title="첫 페이지">◁</a>
						<a href="${ctp}/GuestList?pag=${pag-1}" title="이전 페이지">←</a>
					</c:if>
					${pag}/${totPage}
					<c:if test="${pag < totPage}">
						<a href="${ctp}/GuestList?pag=${pag+1}" title="다음 페이지">→</a>
						<a href="${ctp}/GuestList?pag=${totPage}" title="마지막 페이지">▷</a>
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
		<!--글번호 fn:length(vos) 으로 set ((vos의 size만큼 가져오기. idx는 고유번호이기 때문에 중간에 글이 삭제되어도 번호가 반영되지 않는다)) -->
		<c:set var="curScrStartNo" value="${curScrStartNo}"></c:set>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<table class="table table-borderless m-0 p-0">
				<tr>
					<td>
						번호 : ${curScrStartNo}
						<!-- admin(관리자)로 접속했을 때 모든 방명록 게시글 삭제 가능 혹은 등록된 이름이 로그인한 회원의 이름과 같을 경우 그 건만 삭제 가능-->
						<c:if test="${sAdmin == 'OK' || sName == vo.name}">
							<a href="javascript:delCheck(${vo.idx})" class="btn btn-danger btn-sm ml-3">삭제</a>
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
					<td>${fn:substring(vo.visitDate, 0, 19)}</td>
				</tr>
				<tr>
					<th>메일주소</th>
					<td colspan="3">
						<!--
	      	<c:if test="${vo.email == '' || vo.email == null}">- 없음 -</c:if>
	      	<c:if test="${vo.email != '' && vo.email != null}">${vo.email}</c:if>
	      	-->

						<!-- empty : null과 공백을 같이 처리하는 애 / 이메일 최소 길이가 6자리 이상이어야하고, @랑 .이 있어야만 함 -->
						<c:if test="${empty vo.email || fn:length (vo.email) < 6 || fn:indexOf(vo.email, '@') == -1 || fn:indexOf(vo.email, '.') == -1}">- 없음 -</c:if>
						<c:if test="${!empty vo.email && fn:length (vo.email) >= 6 && fn:indexOf(vo.email, '@') != -1 && fn:indexOf(vo.email, '.') != -1}">${vo.email}</c:if>
					</td>
				</tr>
				<tr>
					<th>홈페이지</th>
					<td colspan="3">
						<c:if test="${empty vo.homePage || fn:length (vo.homePage) <= 10 || fn:indexOf(vo.homePage, '.') == -1}">- 없음 -</c:if>
						<c:if test="${!empty vo.homePage && fn:length (vo.homePage) > 10 && fn:indexOf(vo.homePage, '.') != -1}">
							<a href='${vo.homePage}' target='_blank'>${vo.homePage}</a>
						</c:if>

					</td>
				</tr>
				<tr>
					<th>방문소감</th>
					<td colspan="3">${fn:replace(vo.content, newLine, "<br>")}</td>
				</tr>
			</table>
			<br />
			<c:set var="curScrStartNo" value="${curScrStartNo - 1}"></c:set>
		</c:forEach>
		<!-- 블록페이지 시작 -->
		<div class="text-center">
			<ul class="pagination justify-content-center">
				<c:if test="${pag > 1}">
					<li class="page-item">
						<a class="page-link text-secondary" href="${ctp}/GuestList?pag=1&pageSize=${pageSize}">첫 페이지</a>
					</li>
				</c:if>
				<c:if test="${curBlock > 0}">
					<li class="page-item">
						<a class="page-link text-secondary" href="${ctp}/GuestList?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}">이전블럭</a>
					</li>
				</c:if>
				<c:forEach var="i" begin="${(curBlock*blockSize)+ 1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
					<c:if test="${i <= totPage && i == pag}">
						<li class="page-item active">
							<a class="page-link bg-secondary bordered-secondary" href="${ctp}/GuestList?pag=${i}&pageSize=${pageSize}">${i}</a>
						</li>
					</c:if>
					<c:if test="${i <= totPage && i != pag}">
						<li class="page-item">
							<a class="page-link text-secondary" href="${ctp}/GuestList?pag=${i}&pageSize=${pageSize}">${i}</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${curBlock < lastBlock}">
					<li class="page-item">
						<a class="page-link text-secondary" href="${ctp}/GuestList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블럭</a>
					</li>
				</c:if>
				<c:if test="${pag < totPage}">
					<li class="page-item">
						<a class="page-link text-secondary" href="${ctp}/GuestList?pag=${totPage}&pageSize=${pageSize}">마지막 페이지</a>
					</li>
				</c:if>
			</ul>
		</div>
		<!-- 블록페이지 끝 -->
		<!-- 글번호 no에서 하나 빼기 -->
	</div>
	<p>
		<br />
	</p>
		<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>