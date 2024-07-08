<%@ page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qrCodeEx4.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function qrCodeCreate4() {
  		let mid = $("#mid").val();
  		let name = $("#name").val();
  		let email = $("#email").val();
  		let movieName = $("#movieName").val();
  		let movieDate = $("#movieDate").val();
  		let movieTime = $("#movieTime").val();
  		let movieAdult = $("#movieAdult").val();
  		let movieChild = $("#movieChild").val();
  		
  		if(mid.trim()=="" || name.trim()=="" || email.trim()=="" || movieName.trim()=="" || movieDate.trim()=="" || movieTime.trim()=="" || movieAdult.trim()=="" || movieChild.trim()=="") {
  			alert("티켓 구매 정보를 입력해 주세요");
  			$("#mid").focus();
  			return false;
  		}
  		
  		let query = {
  				mid  : mid,
  				name  : name,
  				email  : email,
  				movieName : movieName,
  				movieDate : movieDate,
  				movieTime : movieTime,
  				movieAdult : movieAdult,
  				movieChild : movieChild
  		}
  		
  		$.ajax({
  			url  : "${ctp}/study/qrCode/qrCodeCreate4",
  			type : "post",
  			data : query,
  			success:function(res) {
  				if(res != "") {
  					let qrCode = 'QR Code명 : ' + res + '<br/>';
  					qrCode += '<img src="${ctp}/qrCode/' + res + '.png" />';
  					$("#demo").html(qrCode);
  				
	  				$("#qrCodeView").show();
  				}
  				else alert("QR코드 생성 실패~~");
  			},
  			error : function() {
  				alert("전송 오류!");
  			}
  		});
  	}
  	
  	// qrCode 검색
  	function qrCodeCheck() {
  		let qrCode = $("#qrCode").val();
  		
  		$.ajax({
  			url  : "${ctp}/study/qrCode/qrCodeSearch",
  			type : "post",
  			data : {qrCode : qrCode},
  			success:function(vo) {
  				let str = '';
  				str += '구매자 아이디 : '+vo.mid+' <br/>';
  				str += '티켓 발매 날짜 : '+vo.publishDate+' <br/>';
  				str += '구매자 성명 : '+vo.name+' <br/>';
  				str += '구매자 이메일 : '+vo.email+' <br/>';
  				str += '영화제목 : '+vo.movieName+' <br/>';
  				str += '상영일자 : '+vo.movieDate+' <br/>';
  				str += '상영시간 : '+vo.movieTime+' <br/>';
  				str += '성인 티켓수 : '+vo.movieAdult+' <br/>';
  				str += '소인 티켓수 : '+vo.movieChild;
  				$("#demoQrCode").html(str);
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
        <th>아이디</th>
        <td><input type="text" name="mid" id="mid" value="${sMid}" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <th>성명</th>
        <td><input type="text" name="name" id="name" value="${sNickName}" required class="form-control"/></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td><input type="text" name="email" id="email" value="cjsk1126@naver.com" required class="form-control"/></td>
      </tr>
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
          <input type="button" value="QR코드 생성" onclick="qrCodeCreate4()" class="btn btn-success mr-2"/>
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
  <hr/>
  <div id="qrCodeView" style="display:none">
    <h4>생성된 QR코드와 DB의 자료를 확인해본다.</h4>
    <div class="input-group">
      <input type="text" name="qrCode" id="qrCode" class="form-control"/>
      <div class="input-group-append">
        <input type="button" value="DB검색하기" onclick="qrCodeCheck()" class="btn btn-success"/>
      </div>
    </div>
    <div id="demoQrCode"></div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>