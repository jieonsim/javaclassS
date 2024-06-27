<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
pageContext.setAttribute("newLine", "\n");
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>pdsContent.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
    'use strict';
    
    // 처음접속시는 '리뷰보이기'버튼을 감추고, '리뷰가리기'버튼과 '리뷰박스'를 보이게한다.
    // $(document).ready(function(){});
    $(function(){
    	$("#reviewShowBtn").hide();
    	$("#reviewHideBtn").show();
    	$("#reviewBox").show();
    });
    
    // 리뷰 보이기
    function reviewShow() {
    	$("#reviewShowBtn").hide();
    	$("#reviewHideBtn").show();
    	$("#reviewBox").show();
    }
    
    // 리뷰 가리기
    function reviewHide() {
    	$("#reviewShowBtn").show();
    	$("#reviewHideBtn").hide();
    	$("#reviewBox").hide();
    }
    
    
    // 다운로드수 증가시키기
    function downNumCheck(idx) {
    	$.ajax({
    		url  : "${ctp}/pds/pdsDownNumCheck",
    		type : "post",
    		data : {idx : idx},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 화살표클릭시 화면 상단으로 부드럽게 이동하기
    $(window).scroll(function(){
    	if($(this).scrollTop() > 100) {
    		$("#topBtn").addClass("on");
    	}
    	else {
    		$("#topBtn").removeClass("on");
    	}
    	
    	$("#topBtn").click(function(){
    		window.scrollTo({top:0, behavior: "smooth"});
    	});
    });
    
    // 별점/리뷰평가 등록하기
    function reviewCheck() {
    	let star = starForm.star.value;
    	let review = $("#review").val();
    	
    	if(star == "") {
    		alert("별점을 부여해 주세요");
    		return false;
    	}
    	
    	let query = {
    			part   : 'pds',
    			partIdx: ${vo.idx},
    			mid    : '${sMid}',
    			nickName    : '${sNickName}',
    			star   : star,
    			content: review
    	}
    	
    	$.ajax({
    		url  : "${ctp}/review/reviewInputOk",
    		type : "post",
    		data : query,
    		success:function(res) {
    			alert(res);
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 리뷰 삭제하기
    function reviewDelete(idx) {
    	let ans = confirm("리뷰를 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "${ctp}/review/reviewDelete",
    		type : "post",
    		data : {idx : idx},
    		success:function(res) {
    			if(res != "0") {
    				alert('리뷰가 삭제되었습니다.');
    				location.reload();
    			}
    			else alert("리뷰 삭제 실패~~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 리뷰 댓글 달기폼 보여주기
    function reviewReply(idx, nickName, content) {
    	$("#myModal #reviewIdx").val(idx);
    	$("#myModal #reviewReplyNickName").text(nickName);
    	$("#myModal #reviewReplyContent").html(content);
    }
    
    // 리뷰 댓글 달기
    function reviewReplyCheck() {
    	let replyContent = reviewReplyForm.replyContent.value;
    	let reviewIdx = reviewReplyForm.reviewIdx.value;
    	
    	if(replyContent.trim() == "") {
    		alert("리뷰 댓글을 입력하세요");
    		return false;
    	}
    	
    	let query = {
    			reviewIdx : reviewIdx,
    			replyMid  : '${sMid}',
    			replyNickName : '${sNickName}',
    			replyContent  : replyContent
    	}
    	
    	$.ajax({
    		url  : "${ctp}/review/reviewReplyInputOk",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("댓글이 등록되었습니다.");
    				location.reload();
    			}
    			else alert("댓글 등록 실패~~");
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
    	});
    }
  </script>
<style>
th {
	background-color: #eee;
	width: 15%;
	text-align: center;
}

h6 {
	position: fixed;
	right: 1rem;
	bottom: -50px;
	transition: 0.7s ease;
}

.on {
	opacity: 0.8;
	cursor: pointer;
	bottom: 0;
}

/* 별점 스타일 설정하기 */
#starForm fieldset {
	direction: rtl;
}

#starForm input[type=radio] {
	display: none;
}

#starForm label {
	font-size: 1.6em;
	color: transparent;
	text-shadow: 0 0 0 #f0f0f0;
}

#starForm label:hover {
	text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
}

#starForm label:hover ~ label {
	text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
}

#starForm input[type=radio]:checked ~ label {
	text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
}

#reviewReplyForm {
	font-size: 11pt;
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
		<h2 class="text-center">자료 내용 상세보기</h2>
		<br />
		<table class="table table-bordered text-center">
			<tr>
				<th>올린이</th>
				<td>${vo.nickName}</td>
				<th>올린날짜</th>
				<td>${fn:substring(vo.FDate,0,fn:length(vo.FDate)-2)}</td>
			</tr>
			<tr>
				<th>파일명</th>
				<td>
					<c:set var="fNames" value="${fn:split(vo.FName,'/')}" />
					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}" />
					<c:forEach var="fName" items="${FNames}" varStatus="st">
						<a href="${ctp}/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a>
						<br />
					</c:forEach>
					(
					<fmt:formatNumber value="${vo.FSize/1024}" pattern="#,##0" />
					KByte)
				</td>
				<th>다운횟수</th>
				<td>${vo.downNum}</td>
			</tr>
			<tr>
				<th>분류</th>
				<td>${vo.part}</td>
				<th>접속IP</th>
				<td>${vo.hostIp}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3" class="text-left">${vo.title}</td>
			</tr>
			<tr>
				<th>상세내역</th>
				<td colspan="3" class="text-left" style="height: 150px">${fn:replace(vo.content,newLine,'<br/>')}</td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="button" value="돌아가기" onclick="location.href='pdsList.pds?pag=${pag}&pageSize=${pageSize}&part=${part}';" class="btn btn-primary" />
				</td>
			</tr>
		</table>
		<hr />
		<div>
			<form name="starForm" id="starForm">
				<fieldset style="border: 0px;">
					<div class="text-left viewPoint m-0 b-0">
						<input type="radio" name="star" value="5" id="star1">
						<label for="star1">★</label>
						<input type="radio" name="star" value="4" id="star2">
						<label for="star2">★</label>
						<input type="radio" name="star" value="3" id="star3">
						<label for="star3">★</label>
						<input type="radio" name="star" value="2" id="star4">
						<label for="star4">★</label>
						<input type="radio" name="star" value="1" id="star5">
						<label for="star5">★</label>
						: 별점을 선택해 주세요 ■
					</div>
				</fieldset>
				<div class="m-0 p-0">
					<textarea rows="3" name="review" id="review" class="form-control mb-1" placeholder="별점 후기를 남겨주시면 100포인트를 지급합니다."></textarea>
				</div>
				<div>
					<input type="button" value="별점/리뷰등록" onclick="reviewCheck()" class="btn btn-primary btn-sm form-control" />
				</div>
			</form>
		</div>
		<hr />
		<div class="row">
			<div class="col">
				<input type="button" value="리뷰보이기" id="reviewShowBtn" onclick="reviewShow()" class="btn btn-success" />
				<input type="button" value="리뷰가리기" id="reviewHideBtn" onclick="reviewHide()" class="btn btn-warning" />
			</div>
			<div class="col text-right">
				<b>리뷰평점 : <fmt:formatNumber value="${reviewAvg}" pattern="#,##0.0" /></b>
			</div>
		</div>
		<hr />
		<div id="reviewBox">
			<c:set var="imsiIdx" value="0" />
			<c:forEach var="vo" items="${rVos}" varStatus="st">
				<c:if test="${imsiIdx != vo.idx}">
					<div class="row">
						<div class="col ml-2">
							<b>${vo.nickName}</b> <span style="font-size: 11px">${fn:substring(vo.RDate, 0, 10)}</span>
							<c:if test="${vo.mid == sMid || sLevel == 0}">
								<a href="javascript:reviewDelete(${vo.idx})" title="리뷰삭제" class="badge badge-danger">x</a>
							</c:if>
							<a href="#" onclick="reviewReply('${vo.idx}','${vo.nickName}','${fn:replace(vo.content,newLine,'<br>')}')" title="댓글달기" data-toggle="modal" data-target="#myModal" class="badge badge-secondary">▤</a>
						</div>
						<div class="col text-right mr-2">
							<c:forEach var="i" begin="1" end="${vo.star}" varStatus="iSt">
								<font color="gold">★</font>
							</c:forEach>
							<c:forEach var="i" begin="1" end="${5 - vo.star}" varStatus="iSt">☆</c:forEach>
						</div>
					</div>
					<div class="row border m-1 p-2" style="border-radius: 5px">${fn:replace(vo.content, newLine, '<br/>')}</div>
				</c:if>
				<c:set var="imsiIdx" value="${vo.idx}" />
				<c:if test="${!empty vo.replyContent}">
					<div class="d-flex text-secondary">
						<div class="mt-2 ml-3">└─▶</div>
						<div class="mt-2 ml-2">${vo.replyNickName}
							<span style="font-size: 11px">${fn:substring(vo.replyRDate,0,10)}</span>
							<c:if test="${vo.replyMid == sMid || sLevel == 0}">
								<a href="javascript:reviewReplyDelete(${vo.replyIdx})" title="댓글삭제" class="badge badge-danger">x</a>
							</c:if>
							<br />${vo.replyContent}
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>

		<!-- 자료실에 등록된 자료가 사진이라면, 아래쪽에 모두 보여주기 -->
		<div class="text-center">
			<c:forEach var="fSName" items="${fSNames}" varStatus="st">
			${fNames[st.index]}<br />
				<c:set var="len" value="${fn:length(fSName)}" />
				<c:set var="ext" value="${fn:substring(fSName, len-3, len)}" />
				<c:set var="extLower" value="${fn:toLowerCase(ext)}" />
				<c:if test="${extLower == 'jpg' || extLower == 'gif' || extLower == 'png'}">
					<img src="${ctp}/pds/${fSName}" width="85%" />
				</c:if>
				<hr />
			</c:forEach>
		</div>

		<!-- 위로가기 버튼 -->
		<h6 id="topBtn" class="text-right mr-3">
			<img src="${ctp}/images/top_arrow.gif" title="위로이동" />
		</h6>
	</div>
	<p>
		<br />
	</p>

	<!-- 댓글달기를 위한 모달처리 -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">>> 리뷰에 댓글달기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form name="reviewReplyForm" id="reviewReplyForm" class="was-vilidated">
						<table class="table table-bordered">
							<tr>
								<th style="width: 25%">원본글작성자</th>
								<td style="width: 75%">
									<span id="reviewReplyNickName"></span>
								</td>
							</tr>
							<tr>
								<th>원본글</th>
								<td>
									<span id="reviewReplyContent"></span>
								</td>
							</tr>
						</table>
						<hr />
						댓글 작성자 : ${sNickName}<br /> 댓글 내용 :
						<textarea rows="3" name="replyContent" id="replyContent" class="form-control" required></textarea>
						<br />
						<input type="button" value="리뷰댓글등록" onclick="reviewReplyCheck()" class="btn btn-success form-control" />
						<input type="hidden" name="reviewIdx" id="reviewIdx" />
					</form>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>