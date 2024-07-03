<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>wordcloudForm.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
    'use strict';
    
    function wordCheck1() {
    	let content = document.getElementById("content").value;
    	if(content.trim() == "") {
    		alert("내용을 입력하세요(구분자는 공백입니다.)");
    		document.getElementById("content").focus();
    		return false;
    	}
    	
    	$.ajax({
    		url  : "${ctp}/study/wordcloud/analyzer1",
    		type : "post",
    		data : {content: content},
    		success:function(data) {
    			let no = 0;
    			let res = '<table class="table table-hover text-center">';
    			res += '<tr class="table-secondary"><th>번호</th><th>단어</th><th>개수</th></tr>';
    			Object.entries(data).forEach(([key, value]) => {
    			    console.log(key, value);
    			    no++;
    			    res += '<tr>';
    			    res += "<td>"+no+"</td><td>" + key + "</td><td>" + value + "건</td>";
    			    res += '<tr>';
    			});
    			res += '<tr><td colspan="3" class="m-0 p-0"></td></tr>';
    			res += '</table>';
    			$("#demo").html(res);
    		},
    		error : function() {
    			alert("전송오류~");
    		}
    	});
    }
    
    function wordCheck2() {
    	$.ajax({
    		url  : "${ctp}/study/wordcloud/analyzer2",
    		type : "post",
    		success:function(data) {
    			let no = 0;
    			let res = '<table class="table table-hover text-center">';
    			res += '<tr class="table-secondary"><th>번호</th><th>단어</th><th>개수</th></tr>';
    			Object.entries(data).forEach(([key, value]) => {
    			    console.log(key, value);
    			    no++;
    			    res += '<tr>';
    			    res += "<td>"+no+"</td><td>" + key + "</td><td>" + value + "건</td>";
    			    res += '<tr>';
    			});
    			res += '<tr><td colspan="3" class="m-0 p-0"></td></tr>';
    			res += '</table>';
    			$("#demo").html(res);
    		},
    		error : function() {
    			alert("전송오류~");
    		}
    	});
    }
    
    function wordCheck3() {
    	let url = "https://news.naver.com";
    	let selector = "div.cjs_t";
    	let excludeWord = $("#excludeWord").val();
    	
    	$.ajax({
    		url  : "${ctp}/study/wordcloud/analyzer3",
    		type : "post",
    		data : {
    			url  : url,
    			selector : selector,
    			excludeWord : excludeWord
    		},
    		success:function(data) {
    			let no = 0;
    			let res = '<table class="table table-hover text-center">';
    			res += '<tr class="table-secondary"><th>번호</th><th>단어</th><th>개수</th></tr>';
    			Object.entries(data).forEach(([key, value]) => {
    			    console.log(key, value);
    			    no++;
    			    res += '<tr>';
    			    res += "<td>"+no+"</td><td>" + key + "</td><td>" + value + "건</td>";
    			    res += '<tr>';
    			});
    			res += '<tr><td colspan="3" class="m-0 p-0"></td></tr>';
    			res += '</table>';
    			$("#demo").html(res);
    			
    			// 수집한 단어로 워드클라우드를 그려본다.
    			window.open('${ctp}/study/wordcloud/wordcloudShow','wordcloud','width=1020px,height=1020px');
    		},
    		error : function() {
    			alert("전송오류~");
    		}
    	});
    }
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p>
		<br />
	</p>
	<div class="container">
		<h2>WordCloud 사용예</h2>
		<hr />
		<div>
			사용 단어의 빈도수 구하기 :
			<textarea rows="5" name="content" id="content" class="form-control mb-2" placeholder="문장을 입력하세요."></textarea>
			<div class="row">
				<div class="col">
					<input type="button" value="TextArea내용 분석" onclick="wordCheck1()" class="btn btn-success" />
					<input type="button" value="Sample.txt내용 분석" onclick="wordCheck2()" class="btn btn-primary" />
					<input type="button" value="뉴스 크롤링 분석" onclick="wordCheck3()" class="btn btn-secondary" />
				</div>
				<div class="col text-right">
					<input type="button" value="다시실행" onclick="location.reload()" class="btn btn-warning" />
				</div>
			</div>
			<hr>
			<div class="input-group">
				<div class="input-group-text">제외할 문자열('/'로 구분해서 입력하세요.)</div>
				<input type="text" name="excludeWord" id="excludeWord" value="[특종]/[단독]" class="form-control" />
				<div class="input-group-append">
					<input type="button" value="뉴스 크롤링 분석(제외문자)" onclick="wordCheck3()" class="btn btn-success"/>
				</div>
			</div>
		</div>
		<hr />
		<h4>결과</h4>
		<div id="demo"></div>
	</div>
	<p>
		<br />
	</p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>