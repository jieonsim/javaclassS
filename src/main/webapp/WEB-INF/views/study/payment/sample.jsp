<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
  <script>
    var IMP = window.IMP; // 그대로 쓰기
    IMP.init("imp81328707");	// 내 고객사 식별 코드 넣기

    //function requestPay() {
      IMP.request_pay(
        {
          pg: "html5_inicis.INIpayTest", // PG provide.MID넣기
          pay_method: "card",
          merchant_uid: "javaclassS8_" + new Date().getTime(),
          name : "${vo.name}",
          amount : "${vo.amount}",
          buyer_email: "${vo.buyer_email}",
          buyer_name: "${vo.buyer_name}",
          buyer_tel: "${vo.buyer_tel}",
          buyer_addr: "${vo.buyer_addr}",
          buyer_postcode: "${vo.buyer_postcode}",
        },//위에까지는 결제대행사 이니시스에서 처리하는 부분 아래 function 부터 직접 설정
        function (rsp) {
          if(rsp.success) {
        	  alert("결제가 완료 되었습니다.");
        	  location.href = '${ctp}/study/payment/paymentOk';
          } else {
        	  alert("결제가 취소 되었습니다.");
        	  location.href = '${ctp}/study/payment/payment';
          }
        }
      );
    //}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <p>
    <img src="${ctp}/images/payment.gif" />
  </p>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>