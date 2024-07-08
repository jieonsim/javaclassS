<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qrCodeEx3.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function qrCodeCreate3() {
  		let mid = $("#mid").val();
  		let movieName = $("#movieName").val();
  		let movieDate = $("#movieDate").val();
  		let movieTime = $("#movieTime").val();
  		let movieAdult = $("#movieAdult").val();
  		let movieChild = $("#movieChild").val();
  		
  		if(mid.trim()=="" || movieName.trim()=="" || movieDate.trim()=="" || movieTime.trim()=="" || movieAdult.trim()=="" || movieChild.trim()=="") {
  			alert("티켓 구매 정보를 입력해 주세요");
  			$("#movieAdult").focus();
  			return false;
  		}
  		
  		let query = {
  				mid  : mid,
  				movieName : movieName,
  				movieDate : movieDate,
  				movieTime : movieTime,
  				movieAdult : movieAdult,
  				movieChild : movieChild
  		}
  		
  		$.ajax({
  			url  : "${ctp}/study/qrCode/qrCodeCreate3",
  			type : "post",
  			data : query,
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
  <h2>티켓정보를 QR코드로 생성하기</h2>
  <div>영화티켓 예매정보 QR로 생성</div>
  <div>(생성된 QR코드를 메일로 보내드립니다. QR코드를 입장시 매표소에 제시해 주세요)</div>
  <form name="myform" method="post">
    <table class="table table-bordered text-center">
      <tr>
        <th>영화명선택</th>
        <td>
          <select name="movieName" id="movieName" class="form-control">
            <option value="">영화를 선택해주세요</option>
            <option>핸섬가이즈</option>
            <option>탈주</option>
            <option>인사이드</option>
            <option>하이재킹</option>
            <option>서울의봄</option>
            <option>노량:죽음의바다</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>상영일자선택</th>
        <td><input type="date" name="movieDate" id="movieDate" value="<%=LocalDate.now() %>" required class="form-control"/></td>
      </tr>
      <tr>
        <th>상영시간</th>
        <td>
        	<select name="movieTime" id="movieTime" class="form-control">
            <option value="">상영시간을 선택해주세요</option>
            <option>10시00분</option>
            <option>12시30분</option>
            <option>15시00분</option>
            <option>17시30분</option>
            <option>20시00분</option>
            <option>22시30분</option>
          </select>
        </td>
      </tr>
      <tr>
        <th>인원수</th>
        <td>
          성인 <input type="number" name="movieAdult" id="movieAdult" value="1" min="1" required class="form-control"/><br/>
          어린이 <input type="number" name="movieChild" id="movieChild" value="0" min="0" required class="form-control"/>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="QR코드 생성" onclick="qrCodeCreate3()" class="btn btn-success mr-2"/>
          <input type="reset" value="다시입력" class="btn btn-warning mr-2"/>
          <input type="button" value="돌아가기" onclick="location.href='qrCodeForm';" class="btn btn-primary mr-4"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" id="mid" value="${sMid}"/>
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