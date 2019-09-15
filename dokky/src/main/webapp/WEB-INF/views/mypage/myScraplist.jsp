<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dokky - 스크랩</title>     
<link href="/dokky/resources/css/myScraplist.css" rel="stylesheet" type="text/css">
</head>
<%@include file="../includes/left.jsp"%>
<body>
<sec:authentication property="principal" var="userInfo"/>
<div class="myscrapWrap">	
	<div class="ContentWrap">
		<div id="menuWrap">
			<div class="tab"> 
				<button onclick="location.href='myInfoForm?userId=${userInfo.username}'">개인정보 변경</button>
		        <button onclick="location.href='rePasswordForm?userId=${userInfo.username}'">비밀번호 변경</button> 
		        <button onclick="location.href='myBoardList?userId=${userInfo.username}'">나의 게시글</button> 
		        <button onclick="location.href='myReplylist?userId=${userInfo.username}'">나의 댓글</button> 
		        <button onclick="location.href='myScraplist?userId=${userInfo.username}'">스크랩</button>
		        <button onclick="location.href='myCashInfo?userId=${userInfo.username}'">캐시</button>  
		    </div> 
		</div>
	<div class="listWrapper">
		<div class="">
			<table class="">  
				<c:forEach items="${myScraplist}" var="scrap"> 
					<tr>
						<td>
						<input type="checkbox" name="checkRow" value="${scrap.scrap_num}" />
                    </td>
						<td class="boardTitle">
							<a class='move' href='<c:out value="${scrap.board_num}"/>'>  
								<c:out value="${scrap.title}" />
								<span class="replyCnt">[<c:out value="${scrap.replyCnt}" />]</span>
							</a>
						</td>  
						<td>
							<img width="20px" src="/dokky/resources/img/read.png"/>
							<c:out value="${scrap.hitCnt}" />
						</td> 
						<td>   
							<img width="20px" src="/dokky/resources/img/like.png"/>
							<c:out value="${scrap.likeCnt}" />  
						</td>
						<td>  
							\<fmt:formatNumber type="number" maxFractionDigits="3" value="${scrap.money}"/>
						</td> 
						<td> 
							<a href="#" class="userMenu" data-scrap_num="${scrap.scrap_num}"> 
								<img src="/dokky/resources/img/profile_img/<c:out value="${scrap.userId}"  />.png"  class="memberImage hideUsermenu" onerror="this.src='/dokky/resources/img/basicProfile.png'" />
								<c:out value="${scrap.nickName}" /> 
							</a>   
							 <div id="userMenubar_${scrap.scrap_num}" class="userMenubar">
								<ul class="hideUsermenu"> 
									<li class="hideUsermenu"><a href="/dokky/userBoardList?userId=${scrap.userId}" class="hideUsermenu"><span class="hideUsermenu">게시글보기</span></a></li>
									<li class="hideUsermenu"><a href="#" class="hideUsermenu"><span class="hideUsermenu">쪽지보내기</span></a></li>
								</ul>      
						     </div>
						</td>
						<td>
							<fmt:formatDate value="${scrap.regDate}" pattern="yyyy-MM-dd HH:mm" />
						</td>
					</tr>
				</c:forEach>
					<tr>
				        <td><input type="checkbox" name="checkAll" id="checkAll" onclick="checkAll();"/>전체선택</td>
				        <td><button id='deleteBtn' type="button" class="">삭제</button></td>
				         <td>총 스크랩수 ${total}개 </td> 
				    </tr>
			</table>
		</div>
		
			<div class='pull-right'>
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage -1}">Previous</a>
						</li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
							<a href="${num}">${num}</a>
						</li> 
					</c:forEach>

					<c:if test="${pageMaker.next}">
						<li class="paginate_button next"><a
							href="${pageMaker.endPage +1 }">Next</a>
						</li>
					</c:if>
				</ul>
			</div>
	<form id='actionForm' action="/dokky/mypage/myScraplist" method='get'>  
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'><!--  $(this).attr("href") -->
		<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
		<input type='hidden' name='userId' value='${pageMaker.cri.userId}'>
	</form> 
		</div>
	</div>
</div> 
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<script> 

		$(".userMenu").on("click",function(event){//해당 메뉴바 보이기 이벤트
			
			var	scrap_num = $(this).data("scrap_num");
			var userMenubar = $("#userMenubar_"+scrap_num);
					
			if($(".addBlockClass").length > 0){
				$(".addBlockClass").css("display","none");  
				$(".addBlockClass").removeClass('addBlockClass');
			}
			userMenubar.css("display","block"); 
			userMenubar.addClass('addBlockClass'); 
		 });
		 
		$('html').click(function(e) { //html안 Usermenu, hideUsermenu클래스를 가지고있는 곳 제외하고 클릭하면 숨김 이벤트발생
			if( !$(e.target).is('.userMenu, .hideUsermenu') ) {  	
			    var userMenu = $(".userMenubar");     
				userMenu.css("display","none");  
			} 
		});
	   
		$("#deleteBtn").on("click", function() { 
			deleteAction(); 
		}); 
    
	var actionForm = $("#actionForm");

		$(".paginate_button a").on("click", function(e) {
	
					e.preventDefault();
	 
					actionForm.find("input[name='pageNum']").val($(this).attr("href"));
					
					actionForm.submit();
				});
	
		$(".move").on("click",function(e) {//게시판 조회
			
			e.preventDefault(); 
		
			actionForm.append("<input type='hidden' name='board_num' value='"+ $(this).attr("href")+ "'>");
			actionForm.attr("action","/dokky/board/get");
			actionForm.submit();   
		});
		
		function checkAll(){
		      if( $("#checkAll").is(':checked') ){ 
		        $("input[name=checkRow]").prop("checked", true);
		      }else{
		        $("input[name=checkRow]").prop("checked", false);
		      }
		}
		
		function deleteAction(){
			
			  var checkRow = "";
			  
			  $( "input[name='checkRow']:checked" ).each (function (){
			    	checkRow = checkRow + $(this).val()+"," ;
			  });
			  
			  checkRow = checkRow.substring(0,checkRow.lastIndexOf( ","));
			 
			  if(checkRow == ''){
			   	 alert("삭제할 스크랩을 선택하세요.");
			    return false;
			  }
			   
			  if(confirm("정말 삭제 하시겠습니까?")){
				  actionForm.attr("action","/dokky/mypage/removeAllScrap").attr("method","post");
				  actionForm.append("<input type='hidden' name='checkRow' value='"+checkRow+"'>");
				  actionForm.append("<input type='hidden' id='csrf' name='${_csrf.parameterName}' value='${_csrf.token}'/>");
				  actionForm.submit();
			  }
		}
		
	 
</script>
	
</body>
</html>