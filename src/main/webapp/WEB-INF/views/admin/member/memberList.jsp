<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>memberList.jsp</title>
  <%@ include file = "/WEB-INF/views/include/bs4.jsp" %>
  <script>
    'use strict';
    
    $(function(){
    	$("#userDispaly").hide();
    	
    	$("#userInfor").on("click", function(){
    		if($("#userInfor").is(':checked')) {
    			$("#totalList").hide();
    			$("#userDispaly").show();
    		}
    		else {
    			$("#totalList").show();
    			$("#userDispaly").hide();
    		}
    	});
    });
    
    // 각 레벨(등급)별 회원 보기...
    function levelItemCheck() {
    	let level = $("#levelItem").val();
    	location.href = "memberList?level="+level;
    }
    
    // 회원별 각각의 등급 변경처리(ajax처리)
    function levelChange(e) {
    	let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
    	if(!ans) {
    		location.reload();
    		return false;
    	}
    	
    	let items = e.value.split("/");
    	let query = {
    			level : items[0],
    			idx   : items[1]
    	}
    	
    	$.ajax({
    		url  : "${ctp}/admin/member/memberLevelChange",
    		type : "post",
    		data : query,
    		success:function(res) {
    			if(res != "0") {
    				alert("등급 수정 완료!");
    				location.reload();
    			}
    			else alert("등급 수정 실패~~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 30일 경과회원 삭제처리
    function memberDeleteOk(idx, photo) {
    	let ans = confirm("선택하신 회원을 영구 삭제 하시겠습니까?");
    	if(ans) {
    		$.ajax({
    			url  : "${ctp}/admin/member/memberDeleteOk",
    			type : "post",
    			data : {
    				idx : idx,
    				photo : photo
    			},
    			success:function(res) {
    				if(res != "0") {
    					alert("영구 삭제 되었습니다.");
    					location.reload();
    				}
    				else alert("삭제 실패~~");
    			}
    		});
    	}
    }
    
    // 전체선택
    function allCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = true;
      }
    }

    // 전체취소
    function allReset() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = false;
      }
    }

    // 선택반전
    function reverseCheck() {
      for(let i=0; i<myform.idxFlag.length; i++) {
        myform.idxFlag[i].checked = !myform.idxFlag[i].checked;
      }
    }
    
    // 선택항목 등급변경처리
    function levelSelectCheck() {
    	let select = document.getElementById("levelSelect");
    	let levelSelectText = select.options[select.selectedIndex].text;
    	let levelSelect = select.options[select.selectedIndex].value;
    	// let levelSelect = document.getElementById("levelSelect").value;
    	let idxSelectArray = '';
    	
      for(let i=0; i<myform.idxFlag.length; i++) {
        if(myform.idxFlag[i].checked) idxSelectArray += myform.idxFlag[i].value + "/";
      }
    	if(idxSelectArray == '') {
    		alert("등급을 변경할 항목을 1개 이상 선택하세요");
    		return false;
    	}
    	
      idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));
      let query = {
    		  idxSelectArray : idxSelectArray,
    		  levelSelect : levelSelect
      }
      
      $.ajax({
    	  url  : "${ctp}/admin/member/memberLevelSelectCheck",
    	  type : "post",
    	  data : query,
    	  success:function(res) {
    		  if(res != "0") alert("선택한 항목들이 "+levelSelectText+"(으)로 변경되었습니다.");
    		  else alert("등급변경 실패~");
  			  location.reload();
    	  },
    	  error : function() {
    		  alert("전송 실패~~");
    	  }
      });
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <div class="row">
    <div class="col"><input type="checkbox" name="userInfor" id="userInfor" onclick="userCheck()" /> 비공개회원만보기/전체보기</div>
    <div class="col text-right">
      <select name="levelItem" id="levelItem" onchange="levelItemCheck()">
        <option value="99"   ${level >= 4  ? "selected" : ""}>전체보기</option>
        <option value="1"    ${level == 1 ? "selected"  : ""}>우수회원</option>
        <option value="2"    ${level == 2 ? "selected"  : ""}>정회원</option>
        <option value="3"    ${level == 3 ? "selected"  : ""}>준회원</option>
        <option value="999"  ${level == 999 ? "selected": ""}>탈퇴신청회원</option>
        <option value="0"    ${level == 0 ? "selected"  : ""}>관리자</option>
      </select>
    </div>
  </div>
  <hr/>
  <div id="totalList">
	  <h3 class="text-center">전체 회원 리스트</h3>
	  <div class="row">
	    <div class="col input-group">
	      <input type="button" value="전체선택" onclick="allCheck()" class="btn btn-success btn-sm mr-1"/>
	      <input type="button" value="전체취소" onclick="allReset()" class="btn btn-primary btn-sm mr-1"/>
	      <input type="button" value="선택반전" onclick="reverseCheck()" class="btn btn-info btn-sm mr-1"/>
		    <div class="input-group-append">
		      <select name="levelSelect" id="levelSelect">
		        <option value="2">정회원</option>
		        <option value="3">준회원</option>
		        <option value="1">우수회원</option>
		      </select>
		      <div class="input-group-append"><input type="button" value="선택항목등급변경" onclick="levelSelectCheck()" class="btn btn-warning btn-sm" /></div>
		    </div>
	    </div>
	    <div class="col text-right">
			  <!-- 페이지처리 시작(이전/다음) -->
  	    <c:if test="${pag > 1}">
  	    	<a href="${ctp}/admin/member/memberList?pag=1&pageSize=${pageSize}" title="첫페이지">◁◁</a>
  	    	<a href="${ctp}/admin/member/memberList?pag=${pag-1}&pageSize=${pageSize}" title="이전페이지">◀</a>
  	    </c:if>
  	    ${pag}/${totPage}
  	    <c:if test="${pag < totPage}">
  	    	<a href="${ctp}/admin/member/memberList?pag=${pag+1}&pageSize=${pageSize}" title="다음페이지">▶</a>
  	    	<a href="${ctp}/admin/member/memberList?pag=${totPage}&pageSize=${pageSize}" title="마지막페이지">▷▷</a>
  	    </c:if>
	  	  <!-- 페이지처리 끝(이전/다음) -->
	    </div>
    </div>
    <form name="myform">
		  <table class="table table-hover text-center mt-1">
		    <tr class="table-dark text-dark">
		      <th>번호</th>
		      <th>아이디</th>
		      <th>닉네임</th>
		      <th>성명</th>
		      <th>생일</th>
		      <th>성별</th>
		      <th>최종방문일</th>
		      <th>오늘방문횟수</th>
		      <th>활동여부</th>
		      <th>현재레벨</th>
		    </tr>
		    <c:forEach var="vo" items="${vos}" varStatus="st">
		      <c:if test="${vo.userInfor == '공개' || (vo.userInfor != '공개' && sLevel == 0)}">
		        <c:if test="${vo.userDel == 'OK'}"><c:set var="active" value="탈퇴신청"/></c:if>
		        <c:if test="${vo.userDel != 'OK'}"><c:set var="active" value="활동중"/></c:if>
			      <tr>
			        <td>
			          <c:if test="${vo.level != 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/></c:if>
			          <c:if test="${vo.level == 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}" disabled /></c:if>
			          ${curScrStartNo}
			        </td>
			        <td><a href="MemberSearch.mem?mid=${vo.mid}">${vo.mid}</a></td>
			        <td>${vo.nickName}</td>
			        <td>${vo.name}</td>
			        <td>${fn:substring(vo.birthday,0,10)}</td>
			        <td>${vo.gender}</td>
			        <td>${fn:substring(vo.lastDate,0,10)}</td>
			        <td>${vo.todayCnt}</td>
			        <td>
			          <c:if test="${vo.userDel == 'OK'}"><font color="red"><b>${active}</b></font></c:if>
			          <c:if test="${vo.userDel != 'OK'}">${active}</c:if>
			          <c:if test="${vo.userDel == 'OK' && vo.deleteDiff >= 30}"><br/>
			            (<a href="javascript:memberDeleteOk('${vo.idx}','${vo.photo}')">30일경과</a>)
			          </c:if>
			        </td>
			        <td>
		            <c:if test="${vo.level != 0}">
				          <!-- <form name="levelForm"> -->
				          	<select name="level" id="level" onchange="levelChange(this)">
				          	  <option value="1/${vo.idx}"  ${vo.level == 1  ? "selected" : ""}>우수회원</option>
				          	  <option value="2/${vo.idx}"  ${vo.level == 2  ? "selected" : ""}>정회원</option>
				          	  <option value="3/${vo.idx}"  ${vo.level == 3  ? "selected" : ""}>준회원</option>
				          	  <option value="0/${vo.idx}"  ${vo.level == 0  ? "selected" : ""}>관리자</option>
				          	  <option value="999/${vo.idx}" ${vo.level == 999 ? "selected" : ""}>탈퇴신청회원</option>
				          	</select>
				          <!-- </form> -->
		          	</c:if>
		          	<c:if test="${vo.level == 0}">관리자</c:if>
			        </td>
			      </tr>
		      </c:if>
		      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		    </c:forEach>
		    <tr><td colspan="10" class="m-0 p-0"></td></tr>
		  </table>
    </form>
  </div>
  <div id="userDispaly">
    <c:if test="${sLevel == 0}">
		  <h3 class="text-center">비공개 회원 리스트</h3>
		  <table class="table table-hover text-center">
		    <tr class="table-dark text-dark">
		      <th>번호</th>
		      <th>아이디</th>
		      <th>닉네임</th>
		      <th>성명</th>
		      <th>생일</th>
		      <th>성별</th>
		      <th>최종방문일</th>
		      <th>오늘방문횟수</th>
		    </tr>
		    <c:set var="no" value="1"/>
		    <c:forEach var="vo" items="${vos}" varStatus="st">
		      <c:if test="${vo.userInfor == '비공개'}">
			      <tr>
			        <td>${no}</td>
			        <td>${vo.mid}</td>
			        <td>${vo.nickName}</td>
			        <td>${vo.name}</td>
			        <td>${fn:substring(vo.birthday,0,10)}</td>
			        <td>${vo.gender}</td>
			        <td>${fn:substring(vo.lastDate,0,10)}</td>
			        <td>${vo.todayCnt}</td>
			      </tr>
			      <c:set var="no" value="${no + 1}"/>
		      </c:if>
		    </c:forEach>
		    <tr><td colspan="8" class="m-0 p-0"></td></tr>
		  </table>
	  </c:if>
  </div>
  <br/>
	<!-- 블록페이지 시작(1블록의 크기를 3개(3Page)로 한다. -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
	    <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
	  	<c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}">이전블록</a></li></c:if>
	  	<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
		    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/admin/member/memberList?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
	  	</c:forEach>
	  	<c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블록</a></li></c:if>
	  	<c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/member/memberList?pag=${totPage}&pageSize=${pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->
</div>
<p><br/></p>
</body>
</html>