<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminLeft.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
	<style>
		.accordion {
		  background-color: #eee;
		  color: #444;
		  cursor: pointer;
		  padding: 18px;
		  width: 100%;
		  border: none;
		  text-align: left;
		  outline: none;
		  font-size: 15px;
		  transition: 0.4s;
		}
		
		.active, .accordion:hover {
		  background-color: #ccc;
		}
		
		.panel {
		  padding: 0 18px;
		  background-color: white;
		  max-height: 0;
		  overflow: hidden;
		  transition: max-height 0.2s ease-out;
		}
	</style>
</head>
<body bgcolor="#ccc">
<p><br/></p>
<div class="text-center">
  <h5><a href="${ctp}/admin/adminMain" target="_top">관리자메뉴</a></h5>
  <hr/>
  <p><a href="${ctp}/" target="_top">홈으로</a></p>
  <hr/>
  <div>
    <button class="accordion"><b>게시글관리</b></button>
    <div class="panel">
      <p><a href="${ctp}/${ctp}/admin/guest/guestList" target="adminContent">방명록리스트</a></p>
	    <p><a href="${ctp}/admin/board/boardList" target="adminContent">게시판리스트</a></p>
    </div>
  </div>
  <div>
    <button class="accordion"><b>회원관리</b></button>
    <div class="panel">
      <p><a href="${ctp}/admin/member/memberList" target="adminContent">회원리스트</a></p>
      <p><a href="#" target="adminContent">신고리스트</a></p>
    </div>
  </div>
  <div>
    <button class="accordion"><b>일정관리</b></button>
    <div class="panel">
      <p><a href="${ctp}/admin/schedule/scheduleList" target="adminContent">일정</a></p>
    </div>
  </div>
  <div>
    <button class="accordion"><b>기타관리</b></button>
    <div class="panel">
      <p><a href="${ctp}/admin/file/fileList" target="adminContent">파일관리</a></p>
    </div>
  </div>
  <div>
    <button class="accordion"><b>상품관리</b></button>
    <div class="panel">
      <p><a href="${ctp}/dbShop/dbCategory" target="adminContent">상품분류등록</a></p>
      <p><a href="${ctp}/dbShop/dbProduct" target="adminContent">상품등록관리</a></p>
      <p><a href="${ctp}/dbShop/dbShopList" target="adminContent">상품등록조회</a></p>
      <p><a href="${ctp}/dbShop/dbOption" target="adminContent">옵션등록관리</a></p>
      <p><a href="${ctp}/dbShop/adminOrder" target="adminContent">주문관리</a></p>
      <p><a href="${ctp}/*" target="adminContent">1:1문의</a></p>
      <p><a href="${ctp}/dbShop/" target="adminContent">메인이미지관리</a></p>
    </div>
  </div>
  <hr/>
</div>
<p><br/></p>
<script>
	var acc = document.getElementsByClassName("accordion");
	var i;
	
	for (i = 0; i < acc.length; i++) {
	  acc[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    if (panel.style.maxHeight) {
	      panel.style.maxHeight = null;
	    } else {
	      panel.style.maxHeight = panel.scrollHeight + "px";
	    } 
	  });
	}
</script>
</body>
</html>