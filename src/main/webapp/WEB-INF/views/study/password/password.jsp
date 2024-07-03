<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>sha256.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    let str = '';
    let cnt = 0;
    
    function sha256check() {
    	let pwd = $("#pwd").val();
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/study/password/sha256",
    		data  : {pwd : pwd},
    		success:function(res) {
    			cnt++;
    			str += cnt + "(sha256) : " + res + "<br/>";
    			$("#demo").html(str);
    		},
    		error : function() {
    			alert("전송오류!!")
    		}
    	});
    }
    
    function ariaCheck() {
    	let pwd = $("#pwd").val();
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/study/password/aria",
    		data  : {pwd : pwd},
    		success:function(res) {
    			cnt++;
    			str += cnt + "(aria) : " + res + "<br/>";
    			$("#demo").html(str);
    		},
    		error : function() {
    			alert("전송오류!!")
    		}
    	});
    }
    
    function bCryptPasswordCheck() {
    	let pwd = $("#pwd").val();
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/study/password/bCryptPassword",
    		data  : {pwd : pwd},
    		success:function(res) {
    			cnt++;
    			str += cnt + "(bCryptPassword) : " + res + "<br/>";
    			$("#demo").html(str);
    		},
    		error : function() {
    			alert("전송오류!!")
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
  <h2>암호화 학습</h2>
  <table class="table table-bordered">
    <tr class="table table-secondary">
      <th class="text-center">방법</th>
      <th class="text-center">설 명</th>
    </tr>
    <tr>
		  <td class="text-center"><h3>SHA-256</h3></td>
		  <td>
			    SHA256 암호화 방식은 SHA(Secure Hash Algorithm) 알고리즘의 한종류로, 256비트로 구성되며 64자리 문자열로 구성된다.<br/>
			    SHA256은 단방향 암호화 방식으로 복호화가 불가능하고, 속도가 빠르다는 장점이 있다.
      </td>
    </tr>
    <tr>
      <td class="text-center"><h3>ARIA</h3></td>
      <td>
			    ARIA암호화 방식은 경량환경 및 하드웨어 구현을 위해 최적화된 알고리즘으로, Involutional SPN 구조를 갖는 범용블록 암호화 알고리즘이다.<br/>
			    ARIA가 사용하는 연산은 대부분 XOR과 같은 단순한 바이트단위연산으로, 블록크기는 128Bit(총비트수:128Bit=32문자)이다.<br/>
			    ARIA는 Academy(학계), Research Institute(연구소), Agency(정부기관)의 첫글자를 따서 만들었다.<br/>
			    ARIA암호화 방식은 복호화가 가능하다.
      </td>
    </tr>
    <tr>
      <td class="text-center"><h3>BCryptPasswordEncoder</h3></td>
      <td>
		    - 스프링 시큐리티(Spring Security) 프레임워크에서 제공하는 클래스중 하나로 비밀번호를 암호화 하는데 사용한다.<br/>
		      이것은 주로 자바 서버프로그램 개발을 위해 필요한 '인증'/'인가(권한부여)'및 '보안기능'을 제공해주는 프레임워크에 속한다.<br/>
		      단방향 암호화 기법으로 복호화 되지 않는다.<br/>
		    - BcryptPasswordEncoder는 BCrypt해싱함수를 사용하여 비밀번호를 인코딩해주는 메서드와 사용자에 의해 제출된 비밀번호를
		      저장소에 저장된 비밀번호와의 일치여부를 통해서 확인해주는 메소드로 제공된다.<br/>
		    - BCryptPasswordEncoder는 PasswordEncoder 인터페이스를 구현한 클래스이다.<br/>
		    - 사용되는 메소드?<br/>
		      1) encode(java.lang.CharSequence) : 패스워드를 암호화 해주는 메소드 이다. 반환타입은 String이다.<br/>
		         encode()메서드는 sha-1에 의한 8Byte(64Bit)로 결합된 해시키를 랜덤하게 셩성된 솔트(salt)를 지원한다.<br/>
		      2) machers(java.lang.CharSequence) : 제출된 인코딩 되지 않은 패스워드의 일치여부를 판단하기위해
		         인코딩된 패스워드와 비교/판단한다. 반환타입은 boolean이다.
      </td>
    </tr>
  </table>
  <hr/>
  <div class="input-group mb-3">
    <input type="text" name="pwd" id="pwd" value="1234" autofocus />
    <div class="input-group-append"><input type="button" value="다시하기" onclick="location.reload()" class="btn btn-primary"/></div>
  </div>
  <div>
    <input type="button" value="sha256암호화" onclick="sha256check()" class="btn btn-success mr-1"/>
    <input type="button" value="ARIA암호화" onclick="ariaCheck()" class="btn btn-info mr-1"/>
    <input type="button" value="bCryptPassword암호화" onclick="bCryptPasswordCheck()" class="btn btn-secondary"/>
  </div>
  <hr/>
  <div>
    <div>출력결과 : </div>
    <span id="demo"></span>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>