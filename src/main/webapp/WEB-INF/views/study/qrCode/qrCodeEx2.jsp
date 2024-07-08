<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qrCodeEx2.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function qrCodeCreate2() {
  		let moveUrl = $("#moveUrl").val();
  		
  		if(moveUrl.trim()=="") {
  			alert("소개할 사이트 주소를 입력해 주세요");
  			$("#moveUrl").focus();
  			return false;
  		}
  		
  		$.ajax({
  			url  : "${ctp}/study/qrCode/qrCodeCreate2",
  			type : "post",
  			data : {moveUrl : moveUrl},
  			success:function(res) {
  				if(res != "") {
  					let qrCode = 'QR Code명 : ' + res + '<br/>';
  					qrCode += '<img src="${ctp}/qrCode/' + res + '.png" />';
  					$("#demo").html(qrCode);
  				}
  				else alert("QR코드 생성 실패~~");
  			},
  			error : function() {
  				alert("전송 오류!");
  			}
  		});
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>소개할 사이트를 QR코드로 생성하기</h2>
  <div>(소개하고 싶은 사이트의 주소를 입력해주세요 : 예- 고궁, 문화재, 블로그, 홈페이지, 상품상세설명,....)</div>
  <form name="myform" method="post">
    <table class="table table-bordered text-center">
      <tr>
        <th>이동할 주소</th>
        <td><input type="text" name="moveUrl" id="moveUrl" value="cjsk1126.tistory.com" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="QR코드 생성" onclick="qrCodeCreate2()" class="btn btn-success mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-warning mr-2"/>
          <input type="button" value="돌아가기" onclick="location.href='qrCodeForm';" class="btn btn-primary mr-4"/>
        </td>
      </tr>
    </table>
  </form>
  <hr/>
  <div>생성된 QR 코드 :<br/>
    <div id="demo"></div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>