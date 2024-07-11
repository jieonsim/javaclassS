<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>transactionForm</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    $(function() {
    	$("#fNewFormCloseBtn").hide();
    });
    
    function fNewFormClose() {
    	//$("#fNewFormBtn").show();
    	//$("#fNewFormCloseBtn").hide();
    	location.reload();
    }
    
    
    function userDelete(idx) {
    	let ans = confirm("선택하신 회원을 삭제처리 하시겠습니까?");
		if (!ans)
			return false;

		location.href = "${ctp}/dbtest/dbtestDelete?tempFlag=validator&idx=" + idx;
    }
    
    function nameSearch() {
    	let name = document.getElementById("name").value;
    	location.href = "user2Search?name="+name;
    }
    
    function fNewForm() {
    	$("#fNewFormBtn").hide();
    	$("#fNewFormCloseBtn").show();
    	
    	let str = '';
    	str += '<form name="myform" method="post">';
    	str += '<table class="table table-bordered">';
    	str += '<tr>';
    	str += '<td colspan="2" class="table-dark">user테이블에 입력되는 필드</td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<th>아이디</th>';
    	str += '<td><input type="text" name="mid" class="form-control" /></td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<th>성명</th>';
    	str += '<td><input type="text" name="name" class="form-control" /></td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<th>나이</th>';
    	/* str += '<td><input type="number" name="age" value="20" class="form-control" /></td>'; */
    	str += '<td><input type="number" name="age" class="form-control" /></td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<th>주소</th>';
    	str += '<td><input type="text" name="address" class="form-control" /></td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<td colspan="2" class="table-dark">user2테이블에 추가되는 필드...</td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<th>직업</th>';
    	str += '<td><input type="text" name="job" class="form-control" /></td>';
    	str += '</tr>';
    	str += '<tr>';
    	str += '<td colspan="2" class="text-center">';
    	str += '<input type="submit" value="회원가입(각각 insert)" class="btn btn-info form-control mb-2"/>';
    	str += '<input type="button" value="회원가입2(한번에 insert)" onclick="transaction2()" class="btn btn-primary form-control"/>';
    	str += '</td>';
    	str += '</tr>';
    	str += '</table>';
    	str += '</form>';
    	document.getElementById("demo").innerHTML = str;
    }
    
    function user2Update(idx,name,age,address) {
    	$("#myModal .modal-body #idx").val(idx);
    	$("#myModal .modal-body #name").val(name);
    	$("#myModal .modal-body #age").val(age);
    	$("#myModal .modal-body #address").val(address);
    }
    
    function transaction2() {
    	let mid = myform.mid.value;
    	let name = myform.name.value;
    	let age = myform.age.value;
    	let address = myform.address.value;
    	let job = myform.job.value;
    	let query = {
    			mid  : mid,
    			name : name,
    			age  : age,
    			address : address,
    			job  : job
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/study/transaction/transaction2",
    		data : query,
    		success:function() {
    			alert("등록 OK");
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
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
  <h2>회 원 리 스 트2</h2>
  <br/>
  <div class="row">
    <div class="col-7">
      <input type="button" value="회원가입폼" onclick="fNewForm()" id="fNewFormBtn" class="btn btn-primary btn-sm mb-2"/>
      <input type="button" value="회원가입폼닫기" onclick="fNewFormClose()" id="fNewFormCloseBtn" class="btn btn-info btn-sm mb-2"/>
    </div>
    <div class="col-5">
	    <div class="input-group">
	      <input type="text" name="name" id="name" value="${name}" class="form-control mb-2">
	      <div class="input-group-append"><input type="button" value="이름검색" onclick="nameSearch()" class="btn btn-success btn-sm mb-2"/></div>
	    </div>
    </div>
  </div>
  <div id="demo"></div>
  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>아이디</th>
      <th>성명</th>
      <th>나이</th>
      <th>주소</th>
      <th>비고</th>
    </tr>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${vo.idx}</td>
        <td>${vo.mid}</td>
        <td>${vo.name}</td>
        <td>${vo.age}</td>
        <td>${vo.address}</td>
        <td>
          <a href="#" onclick="user2Update('${vo.idx}','${vo.name}','${vo.age}','${vo.address}')" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#myModal">수정</a>
          <a href="javascript:userDelete(${vo.idx})" class="btn btn-danger btn-sm">삭제</a>
        </td>
      </tr>
    </c:forEach>
    <tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
  <hr/>
  <h3>User2 리스트</h3>
  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>아이디</th>
      <th>직업</th>
    </tr>
    <c:forEach var="vo" items="${vos2}" varStatus="st">
      <tr>
        <td>${st.count}</td>
        <td>${vo.mid}</td>
        <td>${vo.job}</td>
      </tr>
    </c:forEach>
    <tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
  <br/>
  <div><a href="${ctp}/" class="btn btn-secondary form-control">돌아가기</a></div>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원정보수정</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        <form method="post" action="${ctp}/user2/user2Update">
          <div>성명 : <input type="text" name="name" id="name" class="form-control mb-2" required /></div>
          <div>나이 : <input type="number" name="age" id="age" class="form-control mb-2"/></div>
          <div>주소 : <input type="text" name="address" id="address" class="form-control mb-2"/></div>
          <div><input type="submit" value="정보수정" class="form-control btn btn-success"/></div>
          <div><input type="hidden" name="idx" id="idx"/></div>
        </form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>