<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dokky</title>
<%@include file="../includes/left.jsp"%>
<style>

		@media screen and (max-width:500px){ 
			     .getWrapper {
				    border-color: #e6e6e6;
				    border-style: solid;
				    border-width: 1px;
				    background-color: #323639; 
				    color: #e6e6e6;
				    margin-left: 15%;
				    margin-top: 1%;
				    width: 80%;
				    display: inline-block; 
				}    
        }
        @media screen and (min-width: 501px) and (max-width:1500px){
	          .getWrapper {
				    border-color: #e6e6e6;
				    border-style: solid;
				    border-width: 1px;
				    background-color: #323639;
				    color: #e6e6e6;
				    margin-left: 15%;
				    margin-top: 1%;
				    width: 80%;
				    display: inline-block; 
				}
        }
        @media screen and (min-width: 1501px){    
          .getWrapper {
			    border-color: #e6e6e6;
			    border-style: solid;
			    border-width: 1px;
			    background-color: #323639;
			    color: #e6e6e6;
			    margin-left: 29%;
			    margin-top: 1%;
			    width: 51%;
			    display: inline-block; 
			}
        }
	a  {   
			color:#e6e6e6; text-decoration: none;
		}
	a:hover {   
	     color: #7151fc;
	    text-decoration: underline;
	}
	body{
		background-color: #323639; 
	}
    #replyModForm{ 
      display:none;
    }  
    .page-item{
      display:inline;
    }  
    
    .uploadResult {
	  width:100%;
	  background-color: gray;
	}
	.uploadResult ul{
	  display:flex;
	  flex-flow: row;
	  justify-content: center;
	}
	.uploadResult ul li {
	  list-style: none;
	  padding: 10px;
	  align-content: center;
	  text-align: center;
	}
	.uploadResult ul li img{
	  width: 100px;
	}
	.uploadResult ul li span {
	  color:white;
	}
	.bigPictureWrapper {
	  position: absolute;
	  display: none;
	  justify-content: center;
	  align-items: center;
	  top:0%;
	  width:100%;
	  height:100%;
	  background-color: gray; 
	  z-index: 100;
	  background:rgba(255,255,255,0.5);
	}
	.bigPicture {
	  position: relative;
	  display:flex;
	  justify-content: center;
	  align-items: center;
	}
	
	.bigPicture img {
	  width:600px;
	}
	
	#donateBackGround{
	 	width: 100%;
	    height: 100%;
	    position: fixed;
	    background: #383838;
	    top: 0;
	    left: 0;
	    opacity: 0.6;
	    display: none;
	}

	#donateModal{
	    width: 30%;
	    position: fixed;
	    top: 25%;
	    left: 33%;
	    background-color: #fff;
	    border: 7px solid #5a5e7f;
	    box-sizing: border-box;
	    display: none;
	}
	span.donaSubject {
	    color: #2a0055;
	    display: block;
	    background-color: #f2f2f4;
	    padding: 10px;
	    font-size: 15px;
	    font-weight: 600;
	}
	span.donaText {
	    display: block;
	    color: #888;
	    font-size: 13px;
	    margin-top: 20px;
	    margin-bottom: 20px;
	    margin-left: 16px;
	}
	.donateSubmit{
		border: none;
	    background-color: #ff7e00;
	    color: white;
	    padding: 10px;
	    font-size: 15px;
	    margin: 25px auto;
	    width: 100px;
	    display: block;
	}
	span.mydonaText {
	    font-size: 15px;
	}
	
	.selectWrap {
	    width: 50%;
	    margin: 0 auto;
	}
	
	.donaSelect{
	    font-size: 15px;
	    font-weight: 600;
	    box-sizing: border-box;
	    padding: 10px;
	}
	.modal{
	display: none;
	}
	.reReplyWriteForm{
	display: none;
	}
	
	.reply{
		border-style: solid;
		border-width: 1px;
		border-color: #e6e6e6;
		width: 90%;
		margin-left:0% ; 
		margin-right:1%; 
		margin-top:1%;
		margin-bottom:1%;
		height: 55px;  
	}
	.first {
 		  margin-left: 2%;
	}
	.second {
 		  margin-left: 4%;
	}
	.third {
 		  margin-left: 6%;
	}
	.other {
 		  margin-left: 8%;
	}
	 .userMenubar{
	    display: none;
	    border-style: solid;
	    border-width: 1px;
	    border-color: #e6e6e6;
	    width: 6%; 
	    height: 55px;  
	    background-color: #323639;
	    margin-left: 1.3%;
	    position: absolute;
	}
	.userMenubar li {
	    list-style: none;
	    border-style: solid;
	    border-width: 1px;
	    border-color: #e6e6e6;
	    width: 155%;  
	    margin-left: -60%; 
	}
	.userMenubar ul { 
	    border-style : solid;
	    border-width: 1px;
	    border-color: #e6e6e6;
	    margin: auto;
	}
	.to{
	    margin-left: 11%;
	}
	.getKind{
		border-style : solid;
		border-width: 1px;
		border-color: #e6e6e6; 
		width: 97%; 
		margin-left:1% ; 
		margin-right:1%;
		margin-top:1%;
		height: 30px; 
		font-size: 20px; 
	} 
	.title{
		border-style: solid;
		border-width: 1px;
		border-color: #e6e6e6;
		width: 97%;
		margin-left:1% ; 
		margin-right:1%;
		margin-top:1%;
		height: 60px; 
		font-size: 30px; 
	} 
	#titleNum{
		font-size: 11px;   
	}
	.nickName{
		border-style: solid;
		border-width: 1px;
		border-color: #e6e6e6;
		width: 97%;
		margin-left:1% ; 
		margin-right:1%;
		margin-top:1%;
		height: 60px; 
	}
	.content{
		border-style: solid;
		border-width: 1px;
		border-color: #e6e6e6;
		width: 97%;
		margin-left:1% ; 
		margin-right:1%;
		margin-top:1%;
		height: 200px; 
	}

	.contentInformation {
		/* align-content: right; */ 
	    border-style: solid;
	    border-width: 1px;
	    border-color: #e6e6e6;
	    width: 61%;
	    margin-left: 37%;
	    margin-right: 1%;
	    margin-top: 6%;
	    height: 50px;
	}
	#replyCntVal{
		border-style: solid;
		border-width: 1px;
		border-color: #e6e6e6;
		width: 97%;
		margin-left:1% ; 
		margin-right:1%; 
		margin-top:1%;
		height: 20px; 
	}
	.replyPage{
		border-style: solid;
		border-width: 1px;
		border-color: #e6e6e6;
		width: 97%;
		margin-left:1% ; 
		margin-right:1%; 
		margin-top:1%;
		margin-bottom:1%;
		height: 45px;  
	}
	
	.replyInformation{
		border-style: solid;
		border-width: 1px;
		border-color: #e6e6e6;
		width: 97%;
		margin-left:44%;  
		margin-right:1%; 
		margin-top:1%;
		margin-bottom:1%; 
	}
	#reply_contents{
		width: 80%; 
	}
	.replyWriteForm{  
		margin-left:1%; 
		margin-top:1%; 
		margin-bottom:10%;  
	}
	
	
</style>
</head>
<body> 
<div class="getWrapper"> 
	<div class="getKind">
			 <c:choose>
			       <c:when test="${board.category == 1 }">
			          		 공지사항 
			       </c:when>
			       <c:when test="${board.category == 2 }">
			       			  자유게시판
			       </c:when>
			        <c:when test="${board.category == 3 }">
			     		 	  묻고답하기
			       </c:when>
			        <c:when test="${board.category == 4 }">
			   		   	  	  칼럼/Tech
			       </c:when>
			       <c:when test="${board.category == 5 }">
			   		   		  정기모임/스터디 
			       </c:when>
			        <c:when test="${board.category == 6 }"> 
			   		   		    마이페이지  
			       </c:when>
	       </c:choose> 
    </div>
     
    <div class="nickName">
			<a href="#" class="userMenu">
				<img width="25px" src="/dokky/resources/img/profile_img/<c:out value="${board.userId}" />" class="memberImage hideUsermenu" onerror="this.src='/dokky/resources/img/basicProfile.png'" />
				<c:out value="${board.nickName}" /> 
			</a>
			<div>
				<span>
						<fmt:formatDate value="${board.regDate}" pattern="yyyy년 MM월 dd일 HH:mm" /><label> 작성</label>
					<c:if test="${board.regDate != board.updateDate}">
					    , <fmt:formatDate value="${board.updateDate}" pattern="yyyy년 MM월 dd일 HH:mm" /><label> 수정됨</label> 
					</c:if>
				</span>
				<span>
					<img width="20px" src="/dokky/resources/img/read.png"/>
					<c:out value="${board.hitCnt }"/>
				</span>
			</div>  
			
			<div id="UserMenubar_board" class="userMenubar">
				<ul class="hideUsermenu">  
					<li class="hideUsermenu"><a href="/dokky/userBoardList?userId=${board.userId}" class="hideUsermenu"><span class="hideUsermenu">게시글보기</span></a></li>
					<li class="hideUsermenu"><a href="#" class="hideUsermenu"><span class="hideUsermenu">쪽지보내기</span></a></li>
				</ul>    
		    </div> 
    </div>
        
   	<div class="title">
   		<div id="titleNum">
   			#<c:out value="${board.num }"/>
   		</div>
   		<div>
   		 	<c:out value="${board.title}"/>
   		</div>
    </div> 
          
    <div class="content">
    	<div>
      		${board.content }
      	</div>
      	<div class="contentInformation">
      		<span>
	          <label>좋아요</label> <span id="likeCount"><c:out value="${board.likeCnt }"/></span>
	            <sec:authorize access="isAuthenticated()">
			        <c:if test="${userInfo.username != board.userId}">
			       		<button id="like" data-user_id="${board.userId }">좋아요</button>  
			        </c:if>
		        </sec:authorize>
	        </span> 
	        <span>
		        <label>싫어요</label> <span id="dislikeCount"><c:out value="${board.dislikeCnt }"/></span>
	         	<sec:authorize access="isAuthenticated()">
			        <c:if test="${userInfo.username != board.userId}">
			       	  <button id="dislike" data-user_id="${board.userId }">싫어요</button> 
			        </c:if>
		        </sec:authorize>
	         </span> 
	        <span>
	        	<label>기부금</label> <span id="boardMoney"><c:out value="${board.money }"/></span>
	          	<sec:authorize access="isAuthenticated()">
			        <c:if test="${userInfo.username != board.userId}">
			       	  <button id="donateMoney" data-user_id="${board.userId }">기부</button> 
			        </c:if>
		        </sec:authorize>
	        </span>
	        <span>
	        	<sec:authentication property="principal" var="userInfo"/>
	        
		        	<sec:authorize access="isAuthenticated()">
				        <c:if test="${userInfo.username eq board.userId}">
				       		 <button id="modify_button">수정 </button> 
							 <button id="remove_button">삭제 </button>
				        </c:if>
				        
				        <button id="scrap" data-num="${board.num }">스크랩 </button>
				        
				        <c:if test="${userInfo.username != board.userId}">
				       		 <button id="report">신고 </button> 
				        </c:if>
		        	</sec:authorize>
	        	
	        		<button id="list_button">목록보기 </button> 
	        </span>
        </div> 
    </div>
    <div id="replyCntVal">
    	<!-- 댓글수 -->
    </div> 
	<div> 
		<form id='operForm' action="/dokky/board/modify" method="get">
			  <input type="hidden" id='csrf' name="${_csrf.parameterName}" value="${_csrf.token}"/>
			  <input type='hidden' id='userId' name='userId' value='<c:out value="${board.userId}"/>'>    
			  <input type='hidden' id='num' name='num' value='<c:out value="${board.num}"/>'>
			  <input type='hidden' name='category' value='<c:out value="${board.category}"/>'>
			  <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
			  <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			  <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
  			  <input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>  
		</form>
	</div> 
	<div>
        <ul class="replyList">
        <!-- 댓글 목록 -->
        </ul>
    </div>  
    <div class="replyPage">
    	<!-- 댓글페이지 -->
    </div>
    
      <div id="replyModForm" ><!-- 댓글 수정 폼+값 불러오기 --> 
              <input name='reply_content' value='' oninput="checkLength(this,900);"> 
              <button id='replyModFormModBtn' type="button" >수정</button> 
   			  <button id='replyModFormCloseBtn' type="button" >취소</button>
   			  
   			  <input type='hidden' name='nickName' value=''>
              <input type='hidden' name='reply_num' value=''>
      </div>
      
	<sec:authorize access="isAuthenticated()">
		<div class="replyWriteForm"><!--  댓글쓰기 폼 -->
                <textarea id="reply_contents" rows="3" placeholder="댓글을 입력하세요" name='reply_content' oninput="checkLength(this,900);"></textarea> 
            	 <button id='replyRegisterBtn' type="button">등록</button> 
		</div>   
		<div class="reReplyWriteForm"><!--  대댓글쓰기 폼 -->
		   <div> 
                <textarea id="reReply_contents" rows="3" name='reReply_content' oninput="checkLength(this,900);"></textarea>
           </div>  
   		   <button id='reReplyRegisterBtn' type="button">등록</button>
   		   <button id='reReplyCancelBtn' type="button">취소</button>
		</div> 
	</sec:authorize>
		
</div> 

<div id="donateBackGround"></div>
<div id="donateModal">
         <span class="donaSubject">기부하기</span>
         <span class="donaText">* 기부이후 환불은 불가능합니다</span>
         
         <div class="selectWrap">
         	 <span class="mydonaText">남은금액</span>
         	 <input class="donaSelect" name='myCash' value='' readonly="readonly">
	         <span class="mydonaText">기부금액</span>
	         	<input type="text" name='giveCash' value="" class="donaSelect"/>
         </div>
         <button id='modalSubmitBtn' type="button" class="donateSubmit">기부</button>
		 <button id='modalCloseBtn' type="button" class="donateSubmit">취소</button>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/dokky/resources/js/reply.js"></script> <!--댓글 AJAX통신 -->
<script>
		
function checkLength(obj, maxlength) {    
	var str = obj.value; // 이벤트가 일어난 컨트롤의 value 값    
	var str_length = str.length; // 전체길이       // 변수초기화     
	var max_length = maxlength; // 제한할 글자수 크기     
	var i = 0; // for문에 사용     
	var ko_byte = 0; // 한글일경우는 2 그밗에는 1을 더함     
	var li_len = 0; // substring하기 위해서 사용     
	var one_char = ""; // 한글자씩 검사한다     
	var reStr = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다.       
	for (i = 0; i < str_length; i++) {         // 한글자추출         
		one_char = str.charAt(i);            
		ko_byte++;        
	}              
	if (ko_byte <= max_length) {// 전체 크기가 max_length를 넘지않으면                
		li_len = i + 1;         
	}       
	if (ko_byte > max_length) {// 전체길이를 초과하면          
			alert(max_length + " 글자 이상 입력할 수 없습니다.");         
			reStr = str.substr(0, max_length);         
			obj.value = reStr;      
			}     
		obj.focus();  
	}
	
	//공통 변수 모음
	var board_num = '${board.num}';

     function func_confirm(content){//단순 확인여부 함수
         if(confirm(content)){//true
         	return true;
         } else {//false
         	return false;
         }
     }
	/////////////////////////////////////////////////////////
	
	var operForm = $("#operForm"); 
	
	$("#list_button").on("click", function(e){//글 목록
	    operForm.find("#num").remove();
	    operForm.find("#userId").remove();
	    operForm.find("#csrf").remove();
	    operForm.attr("action","/dokky/board/list")
	    operForm.submit();
 	 }); 
	
	$("#modify_button").on("click", function(e){//글 수정
	    operForm.submit();   
 	 }); 
	   
	$("#remove_button").on("click", function(e){//글 삭제
		if(func_confirm('정말 삭제 하시겠습니까?')){
			operForm.attr("action","/dokky/board/remove").attr("method","post");
		    operForm.submit();
		}
 	 }); 
	
	/////////////////////////////////////////////////////////
 	 var numValue = '<c:out value="${board.num}"/>';// 글번호
 	 var replyList = $(".replyList");//댓글목록
	 var replyCnt ;
	 var username = null;
	 
	function showReplyList(page){ //댓글 목록 가져오기
	    replyService.getList({num:numValue, page: page || 1 }, function(data) {
	  		  replyCnt =  data.replyCnt;
	  		  
			  if(page == -1){
			  
		      pageNum = Math.ceil(replyCnt/10.0);
		      //alert(pageNum);
		      showReplyList(pageNum);//마지막페이지 찾아서 다시호출
		      return;
		    }
	        
	     var str="";
	     var len = data.list.length;
	     var nickName=""; 
	     var userId=""; 
	     var toNickName=""; 
	     var toUserId=""; 
	     var reply_nums=""; 
	     var reply_level; 
	     
		     <sec:authorize access="isAuthenticated()">
		    	 username = '${userInfo.username}';
		     </sec:authorize>

	     if(data.list == null || len == 0){//댓글 리스트
	    	 replyList.html(str);//댓글삭제후 댓글이 하나도 없다면 목록안에 공백 채워주기
	    	 showReplyPage(0);//댓글이 없어서 페이지 번호 없애주기
	    	 return;  
	     }
	     for (var i = 0; i < len || 0; i++) {
	       nickName = data.list[i].nickName; 
	       userId = data.list[i].userId;  
	       reply_nums = data.list[i].reply_num;   
	       reply_level = data.list[i].reply_level;
	       toNickName=data.list[i].toNickName;  
		   toUserId=data.list[i].toUserId;   
	       
	       str +="<div style='display:none' id=replace"+reply_nums+"></div>";
	       
	       if(reply_level == 0 ){ 
	    	  str +=" " + "<div class='reply' data-reply_num='"+reply_nums+"'>"; 
	    	  
	    	  str +=" " +"<a href='#' class='userMenu' data-reply_num='"+reply_nums+"' data-menu_kind='from'>"  
			  str += "<img width='25px' src='/dokky/resources/img/profile_img/"+userId+"' class='memberImage hideUsermenu' onerror='this.src=\"/dokky/resources/img/basicProfile.png\"' />"
		      str += nickName+"</a>" 
			  str += "<div id='userMenubar_reply_from_"+reply_nums+"' class='userMenubar'>" 
			  str += "<ul class='hideUsermenu'>"
			  str += "<li class='hideUsermenu'><a href='/dokky/userBoardList?userId="+userId+" class='hideUsermenu'><span class='hideUsermenu'>게시글보기</span></a></li>"
			  str += "<li class='hideUsermenu'><a href='#' class='hideUsermenu'><span class='hideUsermenu'>쪽지보내기</span></a></li>"
			  str += "</ul></div>" 
			
			  str += replyService.displayTime(data.list[i].replyDate) 
	    	  +" <button data-oper='reReplyForm' type='button' data-user_id='"+userId+"' data-nick_name='"+nickName+"' data-parent_num='"+ data.list[i].parent_num+"' data-order_step='"+data.list[i].order_step+"' data-reply_level='"+data.list[i].reply_level+"'>답글</button>"		  
	    	  +"<div>";
	       }else if(reply_level == 1){   
	    	  str +=" " + "<div class='reply first' data-reply_num='"+reply_nums+"'>└ ";  
	    	  str +=" " + "From" 
	    	  str +=" " +"<a href='#' class='userMenu' data-reply_num='"+reply_nums+"' data-menu_kind='from'>"  
			  str += "<img width='25px' src='/dokky/resources/img/profile_img/"+userId+"' class='memberImage hideUsermenu' onerror='this.src=\"/dokky/resources/img/basicProfile.png\"' />"
		      str += nickName+"</a>" 
			  str += "<div id='userMenubar_reply_from_"+reply_nums+"' class='userMenubar'>" 
			  str += "<ul class='hideUsermenu'>"
			  str += "<li class='hideUsermenu'><a href='/dokky/userBoardList?userId="+userId+" class='hideUsermenu'><span class='hideUsermenu'>게시글보기</span></a></li>"
			  str += "<li class='hideUsermenu'><a href='#' class='hideUsermenu'><span class='hideUsermenu'>쪽지보내기</span></a></li>"
			  str += "</ul></div>"
			  
			  str += "To-"
			  str +=" " +"<a href='#' class='userMenu' data-reply_num='"+reply_nums+"' data-menu_kind='to'>"  
			  str += "<img width='25px' src='/dokky/resources/img/profile_img/"+toUserId+"' class='memberImage hideUsermenu' onerror='this.src=\"/dokky/resources/img/basicProfile.png\"' />"
		      str += toNickName+"</a>" 
			  str += "<div id='userMenubar_reply_to_"+reply_nums+"' class='userMenubar to'>"  
			  str += "<ul class='hideUsermenu'>"
			  str += "<li class='hideUsermenu'><a href='/dokky/userBoardList?userId="+toUserId+" class='hideUsermenu'><span class='hideUsermenu'>게시글보기</span></a></li>"
			  str += "<li class='hideUsermenu'><a href='#' class='hideUsermenu'><span class='hideUsermenu'>쪽지보내기</span></a></li>"
			  str += "</ul></div>"
			  
			  str += replyService.displayTime(data.list[i].replyDate);
	    	  str +=" <button data-oper='reReplyForm' type='button' data-user_id='"+userId+"' data-nick_name='"+nickName+"' data-parent_num='"+ data.list[i].parent_num+"' data-order_step='"+data.list[i].order_step+"' data-reply_level='"+data.list[i].reply_level+"'>답글</button>"  
	    	  str +="<div>"; 
	       }else if(reply_level == 2){
	    	  str +=" " + "<div class='reply second' data-reply_num='"+reply_nums+"'>└ ";
	    	  str +=" " + "From" 
	    	  
	    	  str +=" " +"<a href='#' class='userMenu' data-reply_num='"+reply_nums+"' data-menu_kind='from'>"  
			  str += "<img width='25px' src='/dokky/resources/img/profile_img/"+userId+"' class='memberImage hideUsermenu' onerror='this.src=\"/dokky/resources/img/basicProfile.png\"' />"
		      str += nickName+"</a>" 
			  str += "<div id='userMenubar_reply_from_"+reply_nums+"' class='userMenubar'>" 
			  str += "<ul class='hideUsermenu'>"
			  str += "<li class='hideUsermenu'><a href='/dokky/userBoardList?userId="+userId+" class='hideUsermenu'><span class='hideUsermenu'>게시글보기</span></a></li>"
			  str += "<li class='hideUsermenu'><a href='#' class='hideUsermenu'><span class='hideUsermenu'>쪽지보내기</span></a></li>"
			  str += "</ul></div>"
			  
			  str += "To-"
			  str +=" " +"<a href='#' class='userMenu' data-reply_num='"+reply_nums+"' data-menu_kind='to'>"  
			  str += "<img width='25px' src='/dokky/resources/img/profile_img/"+toUserId+"' class='memberImage hideUsermenu' onerror='this.src=\"/dokky/resources/img/basicProfile.png\"' />"
		      str += toNickName+"</a>" 
			  str += "<div id='userMenubar_reply_to_"+reply_nums+"' class='userMenubar to'>"  
			  str += "<ul class='hideUsermenu'>"
			  str += "<li class='hideUsermenu'><a href='/dokky/userBoardList?userId="+toUserId+" class='hideUsermenu'><span class='hideUsermenu'>게시글보기</span></a></li>"
			  str += "<li class='hideUsermenu'><a href='#' class='hideUsermenu'><span class='hideUsermenu'>쪽지보내기</span></a></li>"
			  str += "</ul></div>"
			  
	    	  str += replyService.displayTime(data.list[i].replyDate);
	    	  str +=" <button data-oper='reReplyForm' type='button' data-user_id='"+userId+"' data-nick_name='"+nickName+"' data-parent_num='"+ data.list[i].parent_num+"' data-order_step='"+data.list[i].order_step+"' data-reply_level='"+data.list[i].reply_level+"'>답글</button>"  
	    	  str +="<div>";
	       }else if(reply_level == 3){
	    	      str +=" " + "<div class='reply third' data-reply_num='"+reply_nums+"'>└ ";
		    	  str +=" " + "From" 
		    	  
		    	  str +=" " +"<a href='#' class='userMenu' data-reply_num='"+reply_nums+"' data-menu_kind='from'>"  
				  str += "<img width='25px' src='/dokky/resources/img/profile_img/"+userId+"' class='memberImage hideUsermenu' onerror='this.src=\"/dokky/resources/img/basicProfile.png\"' />"
			      str += nickName+"</a>" 
				  str += "<div id='userMenubar_reply_from_"+reply_nums+"' class='userMenubar'>" 
				  str += "<ul class='hideUsermenu'>"
				  str += "<li class='hideUsermenu'><a href='/dokky/userBoardList?userId="+userId+" class='hideUsermenu'><span class='hideUsermenu'>게시글보기</span></a></li>"
				  str += "<li class='hideUsermenu'><a href='#' class='hideUsermenu'><span class='hideUsermenu'>쪽지보내기</span></a></li>"
				  str += "</ul></div>"
				  
				  str += "To-"
				  str +=" " +"<a href='#' class='userMenu' data-reply_num='"+reply_nums+"' data-menu_kind='to'>"  
				  str += "<img width='25px' src='/dokky/resources/img/profile_img/"+toUserId+"' class='memberImage hideUsermenu' onerror='this.src=\"/dokky/resources/img/basicProfile.png\"' />"
			      str += toNickName+"</a>" 
				  str += "<div id='userMenubar_reply_to_"+reply_nums+"' class='userMenubar to'>"  
				  str += "<ul class='hideUsermenu'>"
				  str += "<li class='hideUsermenu'><a href='/dokky/userBoardList?userId="+toUserId+" class='hideUsermenu'><span class='hideUsermenu'>게시글보기</span></a></li>"
				  str += "<li class='hideUsermenu'><a href='#' class='hideUsermenu'><span class='hideUsermenu'>쪽지보내기</span></a></li>"
				  str += "</ul></div>"
				  
		    	  str += replyService.displayTime(data.list[i].replyDate);
		    	  str +=" <button data-oper='reReplyForm' type='button' data-user_id='"+userId+"' data-nick_name='"+nickName+"' data-parent_num='"+ data.list[i].parent_num+"' data-order_step='"+data.list[i].order_step+"' data-reply_level='"+data.list[i].reply_level+"'>답글</button>"  
		    	  str +="<div>";
	       }else{  
	    	   str +=" " + "<div class='reply other' data-reply_num='"+reply_nums+"'>└ ";
		    	  str +=" " + "From"  
		    	  
		    	  str +=" " +"<a href='#' class='userMenu' data-reply_num='"+reply_nums+"' data-menu_kind='from'>"  
				  str += "<img width='25px' src='/dokky/resources/img/profile_img/"+userId+"' class='memberImage hideUsermenu' onerror='this.src=\"/dokky/resources/img/basicProfile.png\"' />"
			      str += nickName+"</a>" 
				  str += "<div id='userMenubar_reply_from_"+reply_nums+"' class='userMenubar'>" 
				  str += "<ul class='hideUsermenu'>"
				  str += "<li class='hideUsermenu'><a href='/dokky/userBoardList?userId="+userId+" class='hideUsermenu'><span class='hideUsermenu'>게시글보기</span></a></li>"
				  str += "<li class='hideUsermenu'><a href='#' class='hideUsermenu'><span class='hideUsermenu'>쪽지보내기</span></a></li>"
				  str += "</ul></div>"
				  
				  str += "To-"
				  str +=" " +"<a href='#' class='userMenu' data-reply_num='"+reply_nums+"' data-menu_kind='to'>"  
				  str += "<img width='25px' src='/dokky/resources/img/profile_img/"+toUserId+"' class='memberImage hideUsermenu' onerror='this.src=\"/dokky/resources/img/basicProfile.png\"' />"
			      str += toNickName+"</a>" 
				  str += "<div id='userMenubar_reply_to_"+reply_nums+"' class='userMenubar to'>"  
				  str += "<ul class='hideUsermenu'>"
				  str += "<li class='hideUsermenu'><a href='/dokky/userBoardList?userId="+toUserId+" class='hideUsermenu'><span class='hideUsermenu'>게시글보기</span></a></li>"
				  str += "<li class='hideUsermenu'><a href='#' class='hideUsermenu'><span class='hideUsermenu'>쪽지보내기</span></a></li>"
				  str += "</ul></div>"
				  
		    	  str += replyService.displayTime(data.list[i].replyDate);
		    	  str +=" <button data-oper='reReplyForm' type='button' data-user_id='"+userId+"' data-nick_name='"+nickName+"' data-parent_num='"+ data.list[i].parent_num+"' data-order_step='"+data.list[i].order_step+"' data-reply_level='"+data.list[i].reply_level+"'>답글</button>"  
		    	  str +="<div><span>";
	       }
	         
	       str +=" " + data.list[i].reply_content
	       +" </span>" 
	       str += "  <span class='replyInformation'>좋아요 <span id='replyLikeCount"+reply_nums+"'>"+data.list[i].likeCnt+"</span> "
	       str += "  싫어요 <span id='replyDisLikeCount"+reply_nums+"'>"+data.list[i].dislikeCnt+"</span> "
	       str += "  기부금 <span id='replyMoney"+reply_nums+"'>"+data.list[i].money+"</span> "
	         
	    		    
	       if(username == userId){
			 str += "<button data-oper='modify' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>수정</button>"
		       +"<button data-oper='delete' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>삭제</button>"
	       } 
	        
	       if(username != userId){
	    	   str += " <button data-oper='like' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>좋아요</button>" 
		       +"<button data-oper='dislike' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>싫어요</button>"
		       +"<button data-oper='donateMoney' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>기부</button>"
		       +"<button data-oper='report' type='button' data-user_id='"+userId+"' data-nick_name='"+nickName+"'>신고</button>"
	       } 
				
	       str += "</span></div></div>";       
			    /*  str += "<sec:authorize access='isAuthenticated()'>" */
		       	/*   +"</sec:authorize>"  인증된사람만 보여주기*/
	     }
	     replyList.html(str);//댓글목록안에 채워주기
	     
	     showReplyPage(data.replyCnt);//댓글페이지 보여주기
	     
	     console.log("showReplyList끝");
	     
	     var replyCntVal = $("#replyCntVal");
	      
	     replyCntVal.html("댓글-"+replyCnt);   
	     
	   });//end function
	     
	 }//end showReplyList
	 
	 showReplyList(1);//댓글리스트 보여주기
		 
	/////////////////////////////////////////////////////////
	 var csrfHeaderName ="${_csrf.headerName}"; 
	 var csrfTokenValue="${_csrf.token}";
	    
	 $(document).ajaxSend(function(e, xhr, options) { 
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); //모든 AJAX전송시 CSRF토큰을 같이 전송하도록 셋팅
      });
	/////////////////////////////////////////////////////////
		 var replyRegisterBtn = $("#replyRegisterBtn");//댓글 등록 버튼
		 var reReplyRegisterBtn = $("#reReplyRegisterBtn");//대댓글 등록 버튼
		 var reReplyCancelBtn = $("#reReplyCancelBtn");//대댓글 등록 취소 버튼
		 var reply_contents = $("#reply_contents");//댓글 내용
		 var reReplyWriteForm = $(".reReplyWriteForm");
		 var parent_num;  
		 var order_step;  
	     var reply_level; 
	     var toUserId;
	     var toNickName;
	 <sec:authorize access="isAuthenticated()">   
	     var reply_id = '${userInfo.username}';//댓글 작성자 아이디
	 	 var reply_nickName = '${userInfo.member.nickName}';//댓글 작성자 닉네임
	 	 var board_id = '${board.userId}';
	 	 var board_title = '${board.title}';
   	</sec:authorize>

		 replyRegisterBtn.on("click",function(e){// 0. 댓글 등록 이벤트 설치
				
		      var reply = {
		    		reply_content:reply_contents.val(), //댓글 내용
		    		userId:reply_id,//댓글 작성자 아이디
		            num:numValue, //글번호 
		            nickName:reply_nickName //작성자 닉네임
		          };
			  
			 var alarmData = {
						target:board_id,
						commonVar1:board_title,
						commonVar2:board_num,
						kind:0,
						writerNick:reply_nickName,
						writerId:reply_id
			          };
			 
			var commonData ={ 
					replyVO:reply,
					alarmVO:alarmData
		 	}
		      
		     	 replyService.add(commonData, function(result){//댓글 등록
		        
				        //alert(result);
				        reply_contents.val("");//댓글등록후 폼 비우기
				        
				        showReplyList(-1);//댓글 목록 마지막 페이지 보여주기
			     }); 
		   });
	/////////////////////////////////////////////////////////댓글에 댓글
	
	$(".replyList").on("click",'button[data-oper="reReplyForm"]', function(event){//0. 대댓글 폼 버튼
		
		reReplyWriteForm.css("display","block"); 
	
		parent_num = $(this).data("parent_num");  
		order_step = $(this).data("order_step");  
		reply_level = $(this).data("reply_level");  
		toUserId = $(this).data("user_id");  
		toNickName = $(this).data("nick_name");  
		
	   });
	
	reReplyRegisterBtn.on("click",function(e){// 0. 대댓글 등록 버튼
		
		var reReply_contents = $("#reReply_contents");//댓글 내용
		
	      		var reply = {
		    		reply_content:reReply_contents.val(), //댓글 내용
		    		userId:reply_id,//댓글 작성자 아이디
		    		nickName:reply_nickName, //작성자 닉네임
		            toUserId:toUserId,//to 아이디
		            toNickName:toNickName, //to 닉네임
		            num:numValue, //글번호 
		            parent_num:parent_num,
		            order_step:order_step,
		            reply_level:reply_level
	       	   };
		  
			 var alarmData = {
						target:toUserId,
						commonVar1:board_title,
						commonVar2:board_num,
						kind:0,	
						writerNick:reply_nickName,
						writerId:reply_id
			  };
		 
			var commonData ={ 
					replyVO:reply,
					alarmVO:alarmData
		 	}
	      	
	     	 replyService.add(commonData, function(result){//대댓글 등록
	        	
	     			reReplyWriteForm.css("display","none"); 
	     	 
	     			reReply_contents.val("");//대댓글등록후 폼 비우기
			        
			        showReplyList(-1);//댓글 목록 마지막 페이지 보여주기
		     }); 
	   });
	
		reReplyCancelBtn.on("click",function(e){ 
			
			var reReply_contents = $("#reReply_contents");
			
				reReplyWriteForm.css("display","none"); 
		    	 
					reReply_contents.val("");
			});
	
	/////////////////////////////////////////////////////////이하는 댓글 수정,삭제,수정후 취소
	
	 	var RecentReplaceTag; //더미 <div>가 댓글 수정폼으로 교체되어지기전 백업해둔 현재 <div>태그
	 	var isReplaceTag = false;//더미 <div>가 댓글 수정폼으로 교체되었는지 체크여부
	 	var replyModFormId ;//현재 댓글 수정폼의 아이디
	     
	 	function checkUser(user_id,loginCheck,idCheck,likeCheck){
	 		
	 		if(!username){//로그인 체크
		  		  alert(loginCheck);
		  		  return true; 
		  	 } 
			
			if(idCheck){
				if(user_id  != username){
			 		  alert(idCheck);
			 		  return true; 
			 	 }
			}
			//alert(username); 
			if(likeCheck){//좋아요,싫어요,기부금 체크
				if(user_id  == username){
			 		  alert(likeCheck);
			 		  return true; 
			 	 }
			}
	 	}
	 	
	$(".replyList").on("click",'button[data-oper="modify"]', function(event){//1. 댓글목록의 수정버튼 이벤트,댓글 데이터 한줄 가져오기
		var loginCheck = "로그인후 수정이 가능합니다.";
		var idCheck = "자신이 작성한 댓글만 수정이 가능합니다.";
		var user_id = $(this).data("user_id");  
		//var orginal_nickname = $(this).data("orginal_nickname"); 
		 
		if(checkUser(user_id,loginCheck,idCheck)){
		return; 
		}
		
		if(isReplaceTag){//댓글 수정폼이 열려 있다면
			 RecentReplaceTag.replaceAll("#"+replyModFormId);//댓글 수정폼을  더미 <div>로 교체
			$(".selected").css("display", "list-item");//none해둔 수정 댓글은 다시 보이게하기 
		}  
		
		$(this.parentNode).addClass('selected').css("display","none");//수정할려는 댓글 한줄 안보이게
		
		  var reply_num = $(this).data("reply_num");//수정 할려는 댓글의 번호 가져오기
		  var currentReplyModForm = $('#replyModForm').clone();//모형 댓글 수정폼 복제해오기
		  
		  currentReplyModForm.attr('id', "replyModForm"+reply_num);//글번호 넣어서 아이디  바꿔주기
		  replyModFormId = currentReplyModForm.attr('id');//현재 댓글 수정폼의 아이디 저장 
		  
		  currentReplyModForm.find('#replyModFormCloseBtn').attr('id', "replyModFormCloseBtn"+reply_num); //댓글 수정폼 취소버튼 id 글번호 넣어서 바꿔주기
		  currentReplyModForm.find('#replyModFormModBtn').attr('id', "replyModFormModBtn"+reply_num); //댓글 수정폼 수정버튼 id 글번호 넣어서 바꿔주기
		  
		 RecentReplaceTag = $("#replace"+reply_num).clone();//더미 div를 복제해서 잠시 빼둠-추후 댓글 수정폼을 다시 되돌리기 위해
		    
		 currentReplyModForm.replaceAll("#replace"+reply_num);//더미 div를 댓글 수정폼 으로 교체    
		 
		 isReplaceTag = true;//교체 되어졌음을 확인 
		
		    var InputReply_content = currentReplyModForm.find("input[name='reply_content']");
		    var InputNickName = currentReplyModForm.find("input[name='nickName']");
		    var InputReply_num = currentReplyModForm.find("input[name='reply_num']");
		    
		  replyService.get(reply_num, function(Result){//1. 댓글 데이터 한줄 가져오기
			  InputReply_content.val(Result.reply_content);//ReplyVO의 reply_content
			  InputNickName.val(Result.nickName);//ReplyVO의 nickName
			  InputReply_num.val(reply_num);
			  
			  currentReplyModForm.css("display","block");//최종 댓글 수정 입력폼 사용자에게 보여주기   
			  
	/////////////////////////////////////////////////////// 

			  var replyModFormCloseBtn = $("#replyModFormCloseBtn"+reply_num); //댓글 수정폼 취소버튼 가져오기 
			  var replyModFormModBtn = $("#replyModFormModBtn"+reply_num);//댓글 수정폼 수정버튼 가져오기
			  
			  replyModFormModBtn.on("click", function(e){// 1-1. 댓글 수정 등록 
				   	 var reply = {
					  reply_num:InputReply_num.val(),
					  reply_content: InputReply_content.val(),
					  userId: user_id //시큐리티를 위해 넘겨줌
					   
					  };//수정폼의 값을 넘긴다
				   	  
				   	  replyService.update(reply, function(result){
				   	        
				   	    //alert(result); 
				   	      
				   	    showReplyList(pageNum);//수정후 댓글 페이지 유지하면서 리스트 다시불름
				   	 
				   	  });
				   	});
			    
			  replyModFormCloseBtn.on("click", function(e){//1-2. 댓글 수정 취소 
				  RecentReplaceTag.replaceAll("#replyModForm"+reply_num); //수정 취소시 댓글 수정폼을 다시  더미 <div>로 교체  
				 	    
				 	   $(".selected").css("display", "list-item");//숨겨둔 댓글 한줄 다시 보이게
				}); 
		  });
	});// 1.이벤트 함수 끝
///////////////////////////////////////////////////////
	$(".replyList").on("click",'button[data-oper="delete"]', function(event){//2. 댓글 삭제 이벤트 설치
		
		var loginCheck = "로그인후 삭제가 가능합니다.";
		var idCheck = "자신이 작성한 댓글만 삭제가 가능합니다.";
		var user_id = $(this).data("user_id"); 
		
		if(checkUser(user_id,loginCheck,idCheck,null)){
			return;
		}
		
		if(func_confirm('정말 삭제 하시겠습니까?')){ 
			var reply_num = $(this).data("reply_num");
			//replyService.remove(reply_num,orginal_nickname, function(result){
			replyService.remove(reply_num,user_id, function(result){
		   	      //alert(result);
		   	      showReplyList(pageNum);//삭제후 댓글 페이지 유지하면서 리스트 다시불름 
	   	  }); 
		}
	});//2. 이벤트 함수 끝 
	
///////////////////////////////////////////////////////
	$(".replyList").on("click",'button[data-oper="like"]', function(event){//3. 댓글 좋아요 버튼 이벤트 설치
		
		var loginCheck = "로그인후 좋아요를 눌러주세요.";
		var likeCheck = "자신의 댓글에는 좋아요를 할 수 없습니다.";
		var user_id = $(this).data("user_id");
		var reply_num = $(this).data("reply_num");
		
		if(checkUser(user_id,loginCheck,null,likeCheck)){ 
			return;
		}
		
		var likeData = {reply_num:reply_num,//댓글번호
						userId:username//접속 아이디
				};

		var alarmData = { 
					target:board_id,
					commonVar1:board_title,
					commonVar2:board_num,
					kind:5,
					writerNick:reply_nickName,
					writerId:reply_id
		          };
		
		var commonData ={
				replyLikeVO : likeData,
			 	alarmVO     : alarmData
	 	}

		replyService.updateReplyLike(commonData, function(result){
		 
		var replyLikeCount = $("#replyLikeCount"+reply_num);
			replyLikeCount.html(result);
			//console.log(result); 
		  });
		//추후 좋아요를 눌르면 이미지변경까지 취소하면 이미지변경 추가해보자
	});//3. 댓글 좋아요 버튼 이벤트 설치
	
///////////////////////////////////////////////////////
	$(".replyList").on("click",'button[data-oper="dislike"]', function(event){//4. 댓글 싫어요 버튼 이벤트 설치
		
		var loginCheck = "로그인후 싫어요를 눌러주세요.";
		var likeCheck = "자신의 댓글에는 싫어요를 할 수 없습니다.";
		var user_id = $(this).data("user_id");
		var reply_num = $(this).data("reply_num");
		
		if(checkUser(user_id,loginCheck,null,likeCheck)){
			return;
		}
		
		var dislikeData = {reply_num:reply_num,//댓글번호
						      userId:username//접속 아이디
			};
	
		var alarmData = { 
				target:board_id,
				commonVar1:board_title,
				commonVar2:board_num,
				kind:6,
				writerNick:reply_nickName,
				writerId:reply_id
	          };
		
		var commonData ={ 
				replyDisLikeVO : dislikeData,
			 	alarmVO     : alarmData
	 	}
		
		replyService.updateReplyDisLike(commonData, function(result){
		 
		var replyDisLikeCount = $("#replyDisLikeCount"+reply_num);
			replyDisLikeCount.html(result);
			//console.log(result); 
 	 });
	//추후 좋아요를 눌르면 이미지변경까지 취소하면 이미지변경 추가해보자
	});//4. 댓글 싫어요 버튼 이벤트 설치
	
		$("#like").on("click",function(event){//3. 좋아요 버튼 이벤트 설치
			var loginCheck = "로그인후 좋아요를 눌러주세요.";
			var likeCheck = "자신의 글에는 좋아요를 할 수 없습니다.";
			var user_id = $(this).data("user_id");
			
			if(checkUser(user_id,loginCheck,null,likeCheck)){
				return;  
			}
			
			var likeData = {num:numValue,//글번호
							userId:username//접속 아이디
							};
			
			 var alarmData = { 
						target:board_id,
						commonVar1:board_title,
						commonVar2:board_num,
						kind:1,
						writerNick:reply_nickName,
						writerId:reply_id
			          };
			  
			 var commonData ={
					 	boardLikeVO : likeData,
					 	alarmVO     : alarmData
			 	}
			 
		   	replyService.updateLike(commonData, function(result){
		   	
		   	 
				   	var likeCount = $("#likeCount");
				  	likeCount.html(result);
		   				//console.log(result); 
				     }); 
		   	//추후 좋아요를 눌르면 이미지변경까지 취소하면 이미지변경 추가해보자
		   	});
	   	
	   	$("#dislike").on("click",function(event){//3. 싫어요 버튼 이벤트 설치
			
			var loginCheck = "로그인후 싫어요를 눌러주세요.";
			var likeCheck = "자신의 글에는 싫어요를 할 수 없습니다.";
			var user_id = $(this).data("user_id");
			
			var alarmData = { 
					target:board_id,
					commonVar1:board_title,
					commonVar2:board_num,
					kind:2,
					writerNick:reply_nickName,
					writerId:reply_id
		          };
			  
			if(checkUser(user_id,loginCheck,null,likeCheck)){
				return; 
			}
			
			var dislikeData = {   
							 	   num:numValue,//글번호
								userId:username//접속 아이디
					};
			
			var commonData ={ 
					    boardDisLikeVO : dislikeData,
					 	alarmVO     : alarmData
			 	}
			
			replyService.updateDisLike(commonData, function(result){
			   	 
			   	var dislikeCount = $("#dislikeCount");
			   	
			   	dislikeCount.html(result);
			   		//console.log(result);
	   	    });
	   	});
	   	
///////////////////////////////////////////////////////이하 게시판,댓글 기부 관련	
	   	var donateBackGround = $("#donateBackGround");
		var donateModal = $("#donateModal");
		var donatedId;
		var inputMoney;//기부금액
		var myCash;//내 캐시
		var option;//게시글 기부 or 댓글 기부 선택
		var reply_num;//댓글 번호
	
		
		function donateModalClose(){//모달창 가리기 함수
   			donateBackGround.css("display","none");
   			donateModal.css("display","none"); 
   		}
		
		donateBackGround.on("click",function(){//1. 모달창 취소 이벤트1
			donateModalClose();
		});
		
		$("#modalCloseBtn").on("click",function(event){//2. 모달창 취소 이벤트2
   			donateModalClose();
   		});
		
		
		$(".replyList").on("click",'button[data-oper="donateMoney"]', function(event){//3. 댓글 기부 모달폼 버튼 이벤트
			
			var loginCheck = "로그인후 기부를 해주세요.";
			var giveCheck = "자신의 댓글에는 기부를 할 수 없습니다.";
				donatedId = $(this).data("user_id");
				reply_num = $(this).data("reply_num");
				inputMoney = 0;
			
			if(checkUser(donatedId, loginCheck, null, giveCheck)){
				return;
			}
			
			replyService.getUserCash(username, function(result){//나의 잔여 캐시 가져오기
				
				donateModal.find("input[name='myCash']").val(parseInt(result));
				myCash = parseInt(result);
				donateBackGround.css("display","block");
				donateModal.css("display","block");
				option = 'reply';
			
	   	    });
	   	
   		});//3.이벤트 끝
			
	
   		$("#donateMoney").on("click",function(event){//4. 게시글 기부 모달폼 열기 버튼 이벤트
		
			var loginCheck = "로그인후 기부를 해주세요.";
			var giveCheck = "자신에게는 기부를 할 수 없습니다.";
				donatedId = $(this).data("user_id");
				inputMoney = 0;
		
			if(checkUser(donatedId, loginCheck, null, giveCheck)){
				return;
			}
			
			replyService.getUserCash(username, function(result){//나의 잔여 캐시 가져오기
				
				donateModal.find("input[name='myCash']").val(parseInt(result));
				myCash = parseInt(result);
				donateBackGround.css("display","block");
				donateModal.css("display","block");
				option = 'board';
	   	    });
	   	
   		});//4.이벤트 끝
   		 
   		$("#modalSubmitBtn").on("click",function(event){//5.게시글 or 댓글 기부 하기 등록 버튼 이벤트
   			
   			inputMoney = donateModal.find("input[name='giveCash']").val();
   		
   			if(myCash < inputMoney){
				alert("보유 캐시가 부족합니다.");
				donateModalClose();
				return;
			}
   			
   			if(option === 'board'){//게시글 기부시
   				var donateData = {num 	    : numValue, //글번호
								  userId    : username, //기부하는 아이디
								  donatedId : donatedId, //기부받는 아이디
								  money     : inputMoney, //기부금액
								  cash 	    : myCash //내 캐시
								 };
   			
   				var alarmData = { 
   						target:board_id,
   						commonVar1:board_title,
   						commonVar2:board_num,
   						kind:3,
   						writerNick:reply_nickName,
   						writerId:reply_id
   			          };
   				
   				var commonData ={ 
   						donateVO    : donateData,
					 	alarmVO     : alarmData
			 	}
		
				replyService.updateDonation(commonData, function(result){
				
					var boardMoney = $("#boardMoney");
				   	boardMoney.html(parseInt(result));
				   	
					donateModalClose();
					donateModal.find("input").val("");
					
					alert("기부 하였습니다."); 
					
		   	    });
   			}else if(option === 'reply'){//댓글 기부시
   				
   				
   				var replyDonateData = {
				   					   num 	     : numValue, //글번호
					   				   reply_num : reply_num, //댓글번호
									   userId  	 : username, //기부하는 아이디
									   donatedId : donatedId, //기부받는 아이디
									   money     : inputMoney, //기부금액
									   cash 	 : myCash //내 캐시
								 };
   			
   				var alarmData = { 
   						target:board_id,
   						commonVar1:board_title,
   						commonVar2:board_num,
   						kind:4,
   						writerNick:reply_nickName,
   						writerId:reply_id
   			          };
   				
   				var commonData ={ 
   						replyDonateVO    : replyDonateData,
					 	alarmVO          : alarmData
			 	}
				
				replyService.updateReplyDonation(commonData, function(result){
				
					var replyMoney= $("#replyMoney"+reply_num);
					replyMoney.html(parseInt(result));
				   	
					donateModalClose();
					donateModal.find("input").val("");
					
					alert("기부 되었습니다.");  
		   	    });
   			}
   		});//6.이벤트 끝
///////////////////////////////////////////////////////기부 관련 끝
	 	 
	 	 $("#report").on("click",function(event){//4. 신고 이벤트
	 		 
	 		var reason;   
	 			reason = prompt('신고 사유를 입력해주세요');
	 			
	 		if(reason == null)
	 				return;
	 		 
	 		<sec:authorize access="isAuthenticated()">   
		  		  var reportKind = '게시글';
		  		  var reportingId = '${userInfo.username}';
		  		  var reportingNick = '${userInfo.member.nickName}';
		  		  var reportedId = '${board.userId }';
		  		  var reportedNick = '${board.nickName }';
		  		  var board_num = '${board.num}';
			</sec:authorize>
		    
	 		var reportData = {  reportKind  : reportKind,
				 				reportingId : reportingId, 
				 				reportingNick : reportingNick, 
				 				reportedId : reportedId, 
				 				reportedNick : reportedNick, 
				 				board_num : board_num, 
				 				reason : reason
			 };
	 		//console.log(reportData);
	 		
	 		replyService.report(reportData, function(result){
				 if(result == 'success'){
					 alert("신고완료되었습니다.");
				}
				 else if(result == 'fail'){
					 alert("잠시후 재시도해주세요");
					 }
				});
	 		
	 	});//4.이벤트 끝 
	 	 
	 	
	$(".replyList").on("click",'button[data-oper="report"]', function(event){//3. 댓글 신고 버튼 이벤트
			
			var loginCheck = "로그인후 신고 해주세요.";
			var reportCheck = "자신의 댓글에는 신고 할 수 없습니다.";
			var	reportedId = $(this).data("user_id");
			var	reportedNick = $(this).data("nick_name");
			
			if(checkUser(reportedId, loginCheck, null, reportCheck)){
				return;
			}
			
			var reason;   
 			reason = prompt('신고 사유를 입력해주세요');
 			
	 		if(reason == null)
	 				return;
	 		 
	 		<sec:authorize access="isAuthenticated()">   
		  		  var reportKind = '댓글';
		  		  var reportingId = '${userInfo.username}';
		  		  var reportingNick = '${userInfo.member.nickName}';
		  		  var board_num = '${board.num}';
			</sec:authorize>
		    
	 		var reportData = {  reportKind  : reportKind,
				 				reportingId : reportingId, 
				 				reportingNick : reportingNick, 
				 				reportedId : reportedId, 
				 				reportedNick : reportedNick, 
				 				board_num : board_num, 
				 				reason : reason
			 };
	 		//console.log(reportData);
	 		
	 		replyService.report(reportData, function(result){
				 if(result == 'success'){
					 alert("신고완료되었습니다.");
				}
				 else if(result == 'fail'){
					 alert("잠시후 재시도해주세요");
					 }
				});
	   	
   		});//3.이벤트 끝
	 	 
///////////////////////////////////////////////////////신고 끝
	 	 
		$("#scrap").on("click",function(event){//4. 스크랩 이벤트
			
				var num = $(this).data("num");
				
			<sec:authorize access="isAuthenticated()">   
			    var myId = '${userInfo.username}';//나의 아이디
			</sec:authorize>
			    
			var scrapData = {num  : num, //글번호
							userId : myId //내 아이디
					 };
			 	 
			replyService.ScrapBoard(scrapData, function(result){//스크랩
					 if(result == 'success'){
						 alert("스크랩 하였습니다.");
					}
					 else if(result == 'cancel'){
						 alert("스크랩을 취소하였습니다.");
						 }
					 else if(result == 'fail'){
						 alert("잠시후 재시도해주세요");
						 }
				});
		});//4.이벤트 끝 

		
	 	var pageNum = 1;
	    var replyPage = $(".replyPage");
	    
    function showReplyPage(replyCnt){//댓글 페이지 함수
    	if(replyCnt == 0){//댓글삭제후 댓글이 하나도없다면
    		replyPage.html("");
    		return;
    	}
    
      var endNum = Math.ceil(pageNum / 10.0) * 10; 
      /* Math.ceil() : 소수점 이하를 올림한다. */ 
      var startNum = endNum - 9;
      var prev = startNum != 1; 
      var next = false; 
      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	       					 /* 10.0은 보여줄 댓글의 갯수 */
	      }
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	  var str = "<ul>";
	      	
	      if(prev){ 
	    	  
	        	str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        
		        var active = pageNum == i? "active":"";
		          
		        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'> " +i+ " </a></li>"; 
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
      str += "</ul></div>";
      
      //console.log(str);
      
      replyPage.html(str);
    }
	     
	    replyPage.on("click","li a", function(e){//4. 페이지 링크 클릭시 이벤트
		       e.preventDefault();
		       
		       var targetPageNum = $(this).attr("href");
		       
		       //console.log("targetPageNum: " + targetPageNum);
		       
		        pageNum = targetPageNum;
		        
		       showReplyList(pageNum);
	     });    
	    
	    $(document).ready(function(){//첨부파일 즉시 함수
	    	  
	    	  (function(){
	    	  
	    	    var num = '<c:out value="${board.num}"/>';
	    	   
	    	    $.getJSON("/dokky/board/getAttachList", {num: num}, function(arr){
	    	        
	    	       //console.log(arr);
	    	       
	    	       var str = "";
	    	       
	    	       $(arr).each(function(i, attach){
	    	       
	    	         if(attach.fileType){ //image type
	    	           var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
	    	           
	    	           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
	    	           str += "<img src='/dokky/display?fileName="+fileCallPath+"'>";
	    	           str += "</div>";
	    	           str +"</li>";
	    	         }else{
	    	           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
	    	           str += "<span> "+ attach.fileName+"</span><br/>";
	    	           str += "<img src='/dokky/resources/img/attach.png'></a>";
	    	           str += "</div>"; 
	    	           str +"</li>";
	    	         }
	    	       });
	    	       
	    	       $(".uploadResult ul").html(str);
	    	       
	    	     });//end getjson
	    	    
	    	  })();//end function
	    	  
	    	  $(".uploadResult").on("click","li", function(e){
	    	      
	    	    //console.log("view image");
	    	    
	    	    var liObj = $(this);
	    	    
	    	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
	    	    
	    	    if(liObj.data("type")){
	    	      showImage(path.replace(new RegExp(/\\/g),"/"));
	    	    }else {
	    	    	  /* replyService.download(path, function(data) {
	    	    		  alert(data); 
	    		  		  alert("다운완료");
	    			    }); */
	    	    	self.location ="/dokky/download?fileName="+path 
	    	    }
	    	    
	    	  });
	    	  
	    	  function showImage(fileCallPath){
	    	    
	    	    $(".bigPictureWrapper").css("display","flex").show();
	    	    
	    	    $(".bigPicture")
	    	    .html("<img src='/dokky/display?fileName="+fileCallPath+"' >")
	    	    .animate({width:'100%', height: '100%'}, 1000);
	    	  }

	    	  $(".bigPictureWrapper").on("click", function(e){
	    	    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
	    	    setTimeout(function(){
	    	      $('.bigPictureWrapper').hide();
	    	    }, 1000);
	    	  });
	    	  
	    	});
	      
		$(".replyList").on("click",'.userMenu', function(event){//해당 댓글 메뉴바 보이기 이벤트
			
			event.preventDefault();
		
			if($(".addBlockClass").length > 0){
				$(".addBlockClass").css("display","none"); 
				$(".addBlockClass").removeClass('addBlockClass'); 
			} 
		
			var	menu_kind = $(this).data("menu_kind"); 
			var	reply_num = $(this).data("reply_num");
			 
			if(menu_kind == 'from'){
					var userMenubar = $("#userMenubar_reply_from_"+reply_num);
			}else if(menu_kind == 'to'){
					var userMenubar = $("#userMenubar_reply_to_"+reply_num);
			}
					userMenubar.css("display","block"); 
					userMenubar.addClass('addBlockClass'); 
	 	}); 
		 
		$(".userMenu").on("click",function(event){//해당 게시판 메뉴바 보이기 이벤트

			event.preventDefault();
		
			if($(".addBlockClass").length > 0){
				$(".addBlockClass").css("display","none"); 
				$(".addBlockClass").removeClass('addBlockClass'); 
			}  
				var UserMenubar_board = $("#UserMenubar_board");
				UserMenubar_board.css("display","block"); 
				UserMenubar_board.addClass('addBlockClass');
	 	}); 
	  
		$('html').click(function(e) { //html안 Usermenu, hideUsermenu클래스를 가지고있는 곳 제외하고 클릭하면 숨김 이벤트발생
			if( !$(e.target).is('.userMenu, .hideUsermenu') ) {  //("Usermenu") || $(e.target).hasClass("perid-layer")) {
			    var userMenu = $(".userMenubar");
				userMenu.css("display","none"); 
			} 
		}); 
	    
</script>
</body>
</html>


 
