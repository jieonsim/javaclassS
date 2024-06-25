<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>adminContent.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
</head>
<body>
<p><br/></p>
<div class="container">
  <h3>관리자 메인화면</h3>
  <hr/>
  <!-- 
    - 방명록은 최근 1주일안에 작성된글의 개수를 보여준다.
    - 게시판은....__________
    - 신규등록건수 출력
    - 탈퇴신청회원 건수 출력 
  -->
  <p>방명록 새글 : ???</p>
  <p>게시글 새글 : ???</p>
  <p>신고글(최근1주일) : ???건</p>
  <p>신규등록회원 : <a href="MemberList.ad?level=1"><b>${mCount}</b></a>건</p>
  <p>탈퇴신청회원 : <a href=""><b>${m99Count}</b></a>건</p>
</div>
<p><br/></p>
</body>
</html>