<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>sampleOk.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2>결재가 정상적으로 처리되었습니다.</h2>
  <p>(주문/결재하신 내용은 다음과 같습니다.)</p>
  <hr/>
  <table class="table table-bordered">
    <tr>
      <th>결제 금액</th>
      <td>${vo.amount}</td>
    </tr>
    <tr>
      <th>구매 물품명</th>
      <td>${vo.name}</td>
    </tr>
    <tr>
      <th>이메일</th>
      <td>${vo.buyer_email}</td>
    </tr>
    <tr>
      <th>주문자</th>
      <td>${vo.buyer_name}</td>
    </tr>
    <tr>
      <th>연락처</th>
      <td>${vo.buyer_tel}</td>
    </tr>
    <tr>
      <th>주소</th>
      <td>${vo.buyer_addr}</td>
    </tr>
    <tr>
      <th>우편번호</th>
      <td>${vo.buyer_postcode}</td>
    </tr>
  </table>
  <p class="text-center">
    <a href="${ctp}/study/payment/payment" class="btn btn-success">다시결제하기</a>
  </p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>