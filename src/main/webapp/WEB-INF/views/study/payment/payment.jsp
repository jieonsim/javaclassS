<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>payment.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<jsp:include page="/WEB-INF/views/include/slide2.jsp"/>
<p><br/></p>
<div class="container">
  <h2 class="text-center">결 제 연 습</h2>
  <hr/>
  <form name="myform" method="post">
    <h4>기본 정보를 입력해 주세요.</h4>
    <table class="table table-bordered">
      <tr>
	      <th>구매 금액</th>
	      <!-- name 변수는 결제사에서 제공하는것이기 때문에 그대로 맞춰야함 -->
	      <td><input type="number" name="amount" value="10" class="form-control"/></td>
      </tr>
      <tr>
	      <th>구매 물품명</th>
	      <td><input type="text" name="name" value="냉장고 300L" class="form-control"/></td>
      </tr>
      <tr>
	      <th>이메일</th>
	      <td><input type="text" name="buyer_email" value="wldjs0721@naver.com" class="form-control"/></td>
      </tr>
      <tr>
	      <th>주문자</th>
	      <td><input type="text" name="buyer_name" value="심지언" class="form-control"/></td>
      </tr>
      <tr>
	      <th>연락처</th>
	      <td><input type="text" name="buyer_tel" value="010-8549-5209" class="form-control"/></td>
      </tr>
      <tr>
	      <th>주소</th>
	      <td><input type="text" name="buyer_addr" value="충북 청주시 서원구 사직대로 109 그린컴퓨터" class="form-control"/></td>
      </tr>
      <tr>
	      <th>우편번호</th>
	      <td><input type="text" name="buyer_postcode" value="361-831" class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="submit" value="결제하기" class="btn btn-success"/> &nbsp;
          <input type="reset" value="다시입력" class="btn btn-warning"/> &nbsp;
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/';" class="btn btn-secondary"/>
        </td>
      </tr>
    </table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>