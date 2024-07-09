<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>		<!-- 네이버로그인 js파일 -->

<script>
	var naver_id_login = new naver_id_login("xW0p5VrP1n8uMwTEuZtY", "http://localhost:9090/javawspring/member/memberLogin");
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	
	function naverSignInCallback() {
		  //var name = naver_id_login.getProfileData('name');
		  var email = naver_id_login.getProfileData('email');
		  var nickName = naver_id_login.getProfileData('nickname');
		  //var age = naver_id_login.getProfileData('age');
		  var gender = naver_id_login.getProfileData('gender');
		  //var birthday = naver_id_login.getProfileData('birthday');
		  //var birthyear = naver_id_login.getProfileData('birthyear');
		  //var tel = naver_id_login.getProfileData('mobile');
		  //var profile_image = naver_id_login.getProfileData('profile_image');
			
		  // 이메일 골뱅이 앞에 거를 아이디로 설정
		 	var mid = email.split("@")[0];
		 	setTimeout(() => {
		  	window.close();		  
		  }, 300);
		 	opener.location.href = "${ctp}/member/memberNaverLogin?mid="+mid+"&email="+email+"&nickName="+nickName;
	}
</script>