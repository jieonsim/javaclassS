<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>restapi</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script type="text/javascript">
	'use strict';

	function fetchCheck() {
		fetch("https://infuser.odcloud.kr/oas/docs?namespace=15084592/v1").then(function(res) {
			return res.json();
		}).then(function(json) {
			console.log(json)
		}).then(function(api) {
			$("#demo").html(api);
		});
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<div class="container my-5">
		<h2>REST API</h2>
		<hr>
		<h4>사용 예</h4>
		<div>예) 브라우저 상에 'Hello Springframework'를 출력해보시오.</div>
		<div class="mb-3">
			<a href="${ctp}/study/restapi/restapiTest1/Hello Springframework" class="btn btn-warning">호출1(X)</a>
			<a href="${ctp}/restapi/restapiTest2/Hello Springframework" class="btn btn-success">호출2(O)</a>
			<a href="${ctp}/restapi/restapiTest3/Hello Springframework" class="btn btn-primary">호출3(O)</a>
		</div>
		<hr>
		<h4>Fetch를 사용한 JSON 자료 호출</h4>
		<div class="mb-3">
			<input type="button" value="fetch 연습" onclick="fetchCheck()" class="btn btn-success">
		</div>
		<hr>
		<div class="mb-3">
			<a href="${ctp}/study/restapi/restapiTest4" class="btn btn-primary">강력범죄발생현황</a>
		</div>
		<div class="mb-3" id="demo"></div>
		<pre>
		API란?
		  Application Programming interface의 줄임말
		  응용프로그램에서 사용할 수 있도록 다른 응용프로그램을 제어할 수 있게 만든 인터페이스를 뜻한다.
		  API를 사용하면 사용하려는 응용프로그램의 내부구현로직을 알지 못하더라도 정의되어 있는 기능을 쉽게 사용할 수 있다.
		  
		  * 인터페이스(Interface) : 어떤 장치(H/W,S/W)간의 정보를 교환하기 위한 수단이나 방법을 의미한다.
		  
		  REST란?
		  Representational State Transfer의 줄임말로, 자원의 이름으로 구분하여 해당 자원의 상태를 교환하는것을 의미한다.
		  WEB에서의 REST는 서버와 클라이언트의 통신 방법중의 하나로,
		  HTTP URI(Uniform Resource Identifier)를 통해 자원을 명시하고 HTTP Method를 통해 자원을 교환하는것을 말한다.
		  
		  * HTTP Method : HTTP통신을 통해서 CRUD(Create, Read, Update, Delete)를 통한 자료의 전달과 표현
		  
		  REST 특징
		  (1) Server-Client 구조
		  자원을 제공하는 Server과 자원을 요청하는 Client가 서로 독립적으로 분리되어 있어야 한다.
		  
		  (2) Stateless
		  요청 상호간에는 클라이언트정보가 서버에 저장되지 않는다.
		  서버는 각각의 요청을 완전히 별개의 것으로 인식하고 처리한다.
		  
		  (3) Cacheable
		  HTTP프로토콜을 그대로 사용하기 때문에 HTTP의 특징인 캐싱기능을 적용한다.
		  즉, 대량의 요청을 효율적으로 처리하기 위해서 캐시를 이용하여 같은 자료의 전송시간을 단축할수 있다.
		  
		  (4) 계층화(Layered System)
		  클라이언트는 서버의 구성과 관계없이 REST API 서버로 요청할수 있다.
		  서버는 다중 계층으로 구성될수 있다.(로드밸런싱, 보안요소, 캐시등 - 스위치/라우터/방화벽등의 변경)
		  
		  (5) Code on Demand(Optional - 옵션...)
		  요청을 받으면 서버에서 클라이언트로 코드 또는 스크립트(로직)을 전달하여 클라이언트 기능을 확장한다.(옵션 사항이다.)
		  
		  (6) 인터페이스의 일관성(Uniform Interface)
		  정보가 표준형식으로 전송되기 위해서는 구성 요소간의 통합 인터페이스를 제공해야 한다.
		  즉, HTTP 프로토콜을 따르는 모든 플랫폼에서 사용 가능하게끔 설계해야 한다.(브라우저 버젼/종류가 바꿔도 사용할수 있어야한다.)
		  
		  REST의 장점
		  HTTP 표준 프로토콜을 사용하는 모든 플랫폼에서 호환 가능하다.
		  서버와 클라이언트간의 역할을 명확하게 분리한다.
		  여러 서비스 설계에서 생길수 있는 문제들을 최소화 시켜준다.
		  
		  REST API란
		  REST 아키텍처의 조건을 준수하는 애플리케이션 프로그래밍 인터페이스를 뜻한다.
		  최근 많은 API가 REST API로 제공되고 있다.
		  일반적으로 REST 아키텍처를 구현하는 웹 서비스를 RESTful 하다고 표현한다.
		  
		  REST API 특징
		  REST 기반으로 시스템을 분산하여 확장성과 재사용성을 높인다.
		  HTTP표준을 따르고 있기에 여러 프로그래밍 언어로 구현할 수 있다.
		  
		  REST API 설계 규칙
		  - 웹기반의 REST API를 설계할 경우에는 URI를 통해 자원을 표현해야 한다.
		   예) https://www.spring.green/member/1126
		       Resource    : member
		       Resource id : 1126
		  
		  - 자원에 대한 조작은 HTTP Method(CRUD)를 통해서 표현해야 한다.
		      URI에 행위가 들어가서는 안된다.(get/post/put/delete 등...)
		      HEADER를 통해서 CRUD를 표현하여 통작을 요청처리해야 한다.
		    
		  - 메세지를 통한 리소스 조작
		      HEADER를 통해서 content-type를 지정하여 데이터를 전달한다.
		      대표적인 형식으로는 HTML, XML, JSON, TEXT가 있다.
		    
		  - URI에는 소문자를 사용하도록 권고
		  - Resource의 이름이나 URI가 길어질 경우 하이폰(-)을 통해 가독성을 높일수 있게한다.
		    가급적 언더바(_)의 사용은 피하도록 한다.
		  - 파일 확장자를 표현하지 않는다.
  </pre>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>