<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>dbCategory.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    // 대분류 등록하기
    function categoryMainCheck() {
    	let categoryMainCode = categoryMainForm.categoryMainCode.value.toUpperCase();
    	let categoryMainName = categoryMainForm.categoryMainName.value;
    	if(categoryMainCode.trim() == "" || categoryMainName.trim() == "") {
    		alert("대분류명(코드)를 입력하세요");
    		categoryMainForm.categoryMainName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categoryMainInput",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categoryMainName : categoryMainName
    		},
    		success:function(res) {
    			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
    			else {
    				alert("대분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 대분류 삭제
    function categoryMainDelete(categoryMainCode) {
    	let ans = confirm("대분류 항복을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : "${ctp}/dbShop/categoryMainDelete",
    		type : "post",
    		data : {categoryMainCode : categoryMainCode},
    		success:function(res) {
    			if(res == "0") alert("하위항목이 존재하기에 삭제하실수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			else {
    				alert("대분류 항목이 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 중분류 등록하기
    function categoryMiddleCheck() {
    	let categoryMainCode = categoryMiddleForm.categoryMainCode.value;
    	let categoryMiddleCode = categoryMiddleForm.categoryMiddleCode.value;
    	let categoryMiddleName = categoryMiddleForm.categoryMiddleName.value;
    	if(categoryMainCode.trim() == "" || categoryMiddleCode.trim() == "" || categoryMiddleName.trim() == "") {
    		alert("대분류명(코드)를 입력하세요");
    		categoryMiddleForm.categoryMiddleName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categoryMiddleInput",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categoryMiddleCode : categoryMiddleCode,
    			categoryMiddleName : categoryMiddleName
    		},
    		success:function(res) {
    			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
    			else {
    				alert("중분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 중분류 삭제
    function categoryMiddleDelete(categoryMiddleCode) {
    	let ans = confirm("중분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categoryMiddleDelete",
    		data : {categoryMiddleCode : categoryMiddleCode},
    		success:function(res) {
    			if(res == "0") {
    				alert("하위항목이 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("중분류 항목이 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 소분류 입력창에서 대분류 선택시에 중분류 자동 조회하기
    function categoryMainChange() {
    	let categoryMainCode = categorySubForm.categoryMainCode.value;
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categoryMiddleName",
    		data : {categoryMainCode : categoryMainCode},
    		success:function(vos) {
    			let str = '';
    			str += '<option value="">중분류선택</option>'
    			for(let i=0; i<vos.length; i++) {
    				str += '<option value="'+vos[i].categoryMiddleCode+'">'+vos[i].categoryMiddleName+'</option>';
    			}
    			$("#categoryMiddleCode").html(str);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 소분류 등록하기
    function categorySubCheck() {
    	let categoryMainCode = categorySubForm.categoryMainCode.value;
    	let categoryMiddleCode = categorySubForm.categoryMiddleCode.value;
    	let categorySubCode = categorySubForm.categorySubCode.value;
    	let categorySubName = categorySubForm.categorySubName.value;
    	if(categoryMainCode.trim() == "" || categoryMiddleCode.trim() == "" || categorySubCode.trim() == "" || categorySubName.trim() == "") {
    		alert("소분류명(코드)를 입력하세요");
    		categorySubForm.categorySubName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categorySubInput",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categoryMiddleCode : categoryMiddleCode,
    			categorySubCode : categorySubCode,
    			categorySubName : categorySubName
    		},
    		success:function(res) {
    			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
    			else {
    				alert("소분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 소분류 삭제하기
    function categorySubDelete(categoryMainCode, categoryMiddleCode, categorySubCode) {
    	let ans = confirm("소분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/dbShop/categorySubDelete",
    		data : {
    			categoryMainCode : categoryMainCode,
    			categoryMiddleCode : categoryMiddleCode,
    			categorySubCode : categorySubCode
    		},
    		success:function(res) {
    			if(res == "0") {
    				alert("하위항목이 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("소분류 항목이 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>상품 분류(대/중/소) 등록하기</h2>
  <hr/>
  <form name="categoryMainForm">
    <h4><b>대분류(제조사) 관리(코드는 영문대문자1자리)</b></h4>
    대분류코드(A,B,C,...)
    <input type="text" name="categoryMainCode" size="1" maxlength="1"/>, &nbsp;
    대분류명
    <input type="text" name="categoryMainName" size="8"/> &nbsp;
    <input type="button" value="대분류등록" onclick="categoryMainCheck()" class="btn btn-success btn-sm" />
    <table class="table table-hover m-3">
      <tr class="table-dark text-dark text-center">
        <th>대분류코드</th>
        <th>대분류명</th>
        <th>삭제</th>
      </tr>
      <c:forEach var="mainVO" items="${mainVOS}">
        <tr class="text-center">
          <td>${mainVO.categoryMainCode}</td>
          <td>${mainVO.categoryMainName}</td>
          <td><input type="button" value="삭제" onclick="categoryMainDelete('${mainVO.categoryMainCode}')" class="btn btn-danger btn-sm"/></td>
        </tr>
      </c:forEach>
      <tr><td colspan="3" class="m-0 p-0"></td></tr>
    </table>
  </form>
  <hr/><br/>
  <form name="categoryMiddleForm">
    <h4><b>중분류(상품분류) 관리(코드는 숫자 2자리)</b></h4>
    대분류선택
    <select name="categoryMainCode">
      <option value="대분류명"></option>
      <c:forEach var="mainVO" items="${mainVOS}">
        <option value="${mainVO.categoryMainCode}">${mainVO.categoryMainName}</option>
      </c:forEach>
    </select> &nbsp;
    중분류코드(01,02,03,...)
    <input type="text" name="categoryMiddleCode" size="2" maxlength="2"/>, &nbsp;
    중분류명
    <input type="text" name="categoryMiddleName" size="8"/> &nbsp;
    <input type="button" value="중분류등록" onclick="categoryMiddleCheck()" class="btn btn-success btn-sm" />
    <table class="table table-hover m-3">
      <tr class="table-dark text-dark text-center">
        <th>중분류코드</th>
        <th>중분류명</th>
        <th>대분류명</th>
        <th>삭제</th>
      </tr>
      <c:forEach var="middleVO" items="${middleVOS}">
        <tr class="text-center">
          <td>${middleVO.categoryMiddleCode}</td>
          <td>${middleVO.categoryMiddleName}</td>
          <td>${middleVO.categoryMainName}</td>
          <td><input type="button" value="삭제" onclick="categoryMiddleDelete('${middleVO.categoryMiddleCode}')" class="btn btn-danger btn-sm"/></td>
        </tr>
      </c:forEach>
      <tr><td colspan="4" class="m-0 p-0"></td></tr>
    </table>
  </form>
  <hr/><br/>
  <form name="categorySubForm">
    <h4><b>소분류(상품군) 관리(코드는 숫자 3자리)</b></h4>
    대분류선택
    <select name="categoryMainCode" onchange="categoryMainChange()">
      <option value="">대분류명</option>
      <c:forEach var="mainVO" items="${mainVOS}">
        <option value="${mainVO.categoryMainCode}">${mainVO.categoryMainName}</option>
      </c:forEach>
    </select> &nbsp;
    중분류선택
    <select name="categoryMiddleCode" id="categoryMiddleCode">
      <option value="">중분류명</option>
    </select> &nbsp;
    소분류코드(001,002,003,...)
    <input type="text" name="categorySubCode" size="2" maxlength="3"/>, &nbsp;
    소분류명
    <input type="text" name="categorySubName" size="8"/> &nbsp;
    <input type="button" value="소분류등록" onclick="categorySubCheck()" class="btn btn-success btn-sm" />
    <table class="table table-hover m-3">
      <tr class="table-dark text-dark text-center">
        <th>소분류코드</th>
        <th>소분류명</th>
        <th>중분류명</th>
        <th>대분류명</th>
        <th>삭제</th>
      </tr>
      <c:forEach var="subVO" items="${subVOS}">
        <tr class="text-center">
          <td>${subVO.categorySubCode}</td>
          <td>${subVO.categorySubName}</td>
          <td>${subVO.categoryMiddleName}</td>
          <td>${subVO.categoryMainName}</td>
          <td><input type="button" value="삭제" onclick="categorySubDelete('${subVO.categoryMainCode}','${subVO.categoryMiddleCode}','${subVO.categorySubCode}')" class="btn btn-danger btn-sm"/></td>
        </tr>
      </c:forEach>
      <tr><td colspan="5" class="m-0 p-0"></td></tr>
    </table>
  </form>
</div>
<p><br/></p>
</body>
</html>