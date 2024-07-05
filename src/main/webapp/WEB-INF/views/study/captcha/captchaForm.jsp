<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>captchaForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    #chapchaImage {
      width  : 250px;
      height : 50px;
      border : 3px dotted #A3C552;
      text-align : center;
      padding: 5px;
    }
  </style>
  <script>
    'use strict';
    
    $(document).ready(function(){
    	
    	// captcha이미지를 새로(다시) 만들기
			/* $("#refreshBtn").click(function(e) {
					$.ajax({
						type  : "post",
						url   : "${ctp}/study/captcha/captchaImage",
						async : false,
						success:function() {
							//setTimeout(function() {
								//$("#chapchaImage").load(location.href + ' #chapchaImage');  // 부분 리로드
								//$("#chapchaCode").load(location.href + ' #chapchaCode');  // 부분 리로드
								location.reload();
							//}, 3000);
						},
						error : function() {
							alert("전송오류!!");
						}
					});
				}); */
				// captcha 확인하기...
				$("#confirmBtn").click(function(e) {
					e.preventDefault(); // 새로고침(F5)버튼을 막아준다.

					let strCaptcha = $("#strCaptcha").val();

					$.ajax({
						type : "post",
						url : "${ctp}/study/captcha/captcha",
						data : {
							strCaptcha : strCaptcha
						}
					}).done(function(res) {
						if (res != "1")
							alert("로봇으로 의심되는군요. 다시 입력해 보세요");
						else
							alert("사람이시군요. 계속 작업을 진행해 주세요");
					});
				});

			});
		</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>Captcha 연습</h2>
  <pre>
    CAPTCHA는 기계는 인식할 수 없으나, 사람은 쉽게 인식할 수 있는 텍스트나 이미지를 통해서 사람과 기계를 구별하는 프로그램이다.
  </pre>
  <hr/>
  <form name="myform">
    <p id="chapchaCode">다음 코드를 입력해 주세요(${captchaImage}) : <img src="${ctp}/data/study/${captchaImage}" id="chapchaImage"></p>
    <p>
      <input type="text" name="strCaptcha" id="strCaptcha"/>
      <input type="button" value="확인" id="confirmBtn"/>
      <input type="button" value="새로고침" onclick="location.href='captchaImage';"/>
    </p>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>