<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<link href="/dokky/resources/css/left.css" rel="stylesheet" type="text/css"/>
</head>  
<body>
		<sec:authentication property="principal" var="userInfo"/>
		
	<div class="leftWrap">
		<div class="name"><a href="/dokky/main">Dokky</a></div> 
		
		<div class="mypage">  
			<sec:authorize access="isAuthenticated()">
					<a href="#" class="leftUsermenu">
					  	  <img id="leftProfile" src="/dokky/resources/img/profile_img/<c:out value="${userInfo.username}"/>.png" class="memberImage leftHideusermenu" onerror="this.src='/dokky/resources/img/basicProfile.png'" />
					  	  <c:out value="${userInfo.member.nickName}"/>     
			  	    </a> 
			  	    <div id="leftUsermenuBar">
							<ul class="leftHideusermenu"> 
								<li class="leftHideusermenu">
									<a href="/dokky/userBoardList?userId=${userInfo.username}" class="leftHideusermenu">
										<span class="leftHideusermenu">게시글보기</span>
									</a>
								</li>
								<li class="leftHideusermenu">
									<a href="#" class="leftHideusermenu" onclick="noteOpen('${userInfo.username}','${userInfo.member.nickName}')">
										<span class="leftHideusermenu">쪽지보내기</span> 
									</a>
								</li>
							</ul> 
				    </div>
					<form id="logoutForm" method='post' action="/dokky/customLogout">
					    <input id="logoutBtn" type="submit" value="Logout">  
					</form>  
			</sec:authorize>
			<sec:authorize access="isAnonymous()"> 
				<a href="/dokky/customLogin">로그인</a>  
				<a href="/dokky/memberForm">회원가입</a>
			</sec:authorize>	
		</div>
		
		<div class="mypage"><a href="/dokky/board/allList?category=0">전체글보기</a></div>
		<div class="mypage"><a href="/dokky/board/list?category=1">공지사항</a></div>
		<div class="mypage"><a href="/dokky/board/list?category=2">자유게시판</a></div>
		<div class="mypage"><a href="/dokky/board/list?category=3">묻고답하기</a></div>
		<div class="mypage"><a href="/dokky/board/list?category=4">칼럼/Tech</a></div>
		<div class="mypage"><a href="/dokky/board/list?category=5">정기모임/스터디</a></div>
		
		<sec:authorize access="isAuthenticated()">
			<div class="mypage"><a href="/dokky/mypage/myInfoForm?userId=${userInfo.username}">내 정보</a></div>
			<div class="mypage">
				<a href="/dokky/alarmList?userId=${userInfo.username}">
					알림-<span class="alarmCount"></span>
				</a>
				/
				<a href="/dokky/fromNoteList?userId=${userInfo.username}"> 
					쪽지-<span class="noteCount"></span>
				</a>
			</div>
		</sec:authorize> 
		
		<div class="mypage">
			<a href="/dokky/admin/userList">관리자</a>
		</div>
		
		<div class="mypage">
			<div>
				Today : ${sessionScope.todayCount} 
			</div> 
			<div>  
				Total : ${sessionScope.totalCount}  
			</div> 
		</div>
		
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
	
	$(".leftUsermenu").on("click",function(event){//메뉴바 보이기 이벤트 
			 
			event.preventDefault();

			$("#leftUsermenuBar").css("display","block"); 
	});
	 
	$('html').click(function(e) { //html안 Usermenu, leftHideusermenu클래스를 가지고있는 곳 제외하고 클릭하면 숨김 이벤트발생
		
			if( !$(e.target).is('.leftUsermenu, .leftHideusermenu') ) {  
				
				$("#leftUsermenuBar").css("display","none");  	
			} 
	});   

	function noteOpen(userId,nickname){
			
		var popupX = (window.screen.width / 2) - (400 / 2); 

		var popupY= (window.screen.height /2) - (500 / 2);
	         
        window.open('/dokky/minRegNote?userId='+userId+'&nickname='+nickname, 'ot', 'height=500, width=400, screenX='+ popupX + ', screenY= '+ popupY);
    }
	
	function getAlarmRealCount(userId, callback, error) {
		$.ajax({
			type : 'get',
			url : '/dokky/alarmRealCount/'+ userId,
			success : function(result, status, xhr) {
				if (callback) {
					callback(result,xhr);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(xhr,er);
				}
			}
		});
	}
	 
	function getNoteCount(userId, callback, error) {
		$.ajax({
			type : 'get',
			url : '/dokky/noteCount/'+ userId,
			success : function(result, status, xhr) {
				if (callback) {
					callback(result,xhr);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(xhr,er);
				}
			}
		});
	}
	
	<sec:authorize access="isAuthenticated()"> 
		var alarmCount = $(".alarmCount");
		var noteCount = $(".noteCount");
		var userId = '${userInfo.username}';
	</sec:authorize>
	
	function schedule(){
	    getAlarmRealCount(userId, function(result){
	    	alarmCount.html(result);
	 	 });
	    
	    getNoteCount(userId, function(result){
	    	noteCount.html(result);
	 	 });
	} 
	
	$(document).ready(function() {
		<sec:authorize access="isAuthenticated()">  
			schedule();
		 	setInterval(schedule, 30000);//30초마다 알람카운트 불러오기
		</sec:authorize>
		
		 var parameterName = '${_csrf.parameterName}';
		 var token = '${_csrf.token}';
		 var logoutForm = $("#logoutForm");
		  
		  $("#logoutBtn").on("click", function(e){
			  
			  var str = "<input type='hidden' name='"+parameterName+"' value='"+token+"'>";
			  
			  logoutForm.append(str).submit();
			  
		  }); 
	});
	
	</script>
</body>
</html>