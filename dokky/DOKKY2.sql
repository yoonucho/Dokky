
## DB 설계 단계

### 1. 업무 요구사항 파악

### 2. 개념적 설계 : 

 	- ER 다이어그램(Entity Relationship Diagram)을 통해 요구사항을 개념적으로 표현

 	- 개념적 데이터 모델링 : 현실의 업무를 뜯어내서 개념을 찾아내는것. 내가 하고자하는 일에는 어떠한 개념들이 있고 각각의 개념들이 어떻게 상호작용하는지 파악한 업무에서 개념을 뽑아내는것

 	- 개념적 데이터 모델링이 주는 효용 : 현실에서 개념을 축출하는 필터를 제공, 개념에 대해서 다른사람과 대화하게 해주는 언어로서 작용 
 	
 	- ER 다이어그램(개체-관계 다이어그램): 현실 세계에 존재하는 데이터와 그들 간의 관계를 사람이 이해할 수 있는 형태로 명확하게 표현하기 위해서 가장 널리 사용되고 있는 모델

 	- ER 다이어그램 : 현실로부터 개념을 인식하는 도구이면서 다른사람도 알아볼 수 있게 하는 도구 

 	- erd는 현실을 3개의 관점으로 바라본다.
 
 	- 예를들어 내 프로젝트에서는 글, 댓글, 사용자등의 개념들이 있다. 이것들을 Entity라 하고 후에 테이블로 전환될것
 	- 제목,생성일,본문은 속성 attribute 표의 컬럼이 됨
 	
 	- 정보 : 정보를 발견하고 다른사람에게 표현할 수 있게 해줌 (제목,생성일,본문)
 	- 그룹 : 연관된 정보를 그룹해서 인식하고 다른사람에게 표현할 수 있게 해줌 (글)
 	- 관계 : 정보 그룹사이의 관계를 인식하고 그것을 다른사람에게 표현할 수 있게 해줌 (글과 사용자는 쓰다의 관계),(글과 댓글은 소속의 관계)
 	
 	Entity > table
 	attribute > column
 	relation  > pk,fk 가 될것임 > 관계형 데이터 
 	tuple > row 행

### 3. 논리적 설계 

관계 모델(Relation model)을 통해 개념적 설계를 논리적으로 표현
논리적데이터모델링 : 관계형 데이터베이스에 맞게 잘구성해야함 관계형 데이터 베이스 패러다임에 맞는 표로서  
우리가 만들었던 생각햇던 개념을 표로 전환하는작업 

### 4. 물리적 설계 

실제 디스크와 같은 물리 저장장치에 데이터를 저장할 수 있도록 표현
물리적 데이터 모델링 : sql 코드를 작성해서 실제표를 만드는것

---
- 데이터모델링이란 문제를 현실로부터 뜯어내서 추상화과정을 거쳐서 컴퓨터라는 새로운 현실로 옮겨담는작업

## 1. 개념적 설계 - Database ERD

---

## 2. 논리적 설계 -

총 16개의 테이블
#### 1) 게시판 테이블
#### 2) 댓글 테이블
#### 3) 회원 테이블
#### 4) 권한 테이블
#### 5) 쪽지 테이블
#### 6) 업로드 테이블
#### 7) 인증 테이블
#### 8) 게시글 좋아요 테이블
#### 9) 게시글 싫어요 테이블
#### 10) 댓글 좋아요 테이블
#### 11) 댓글 싫어요 테이블
#### 12) 스크랩 테이블
#### 13) 캐시내역 테이블
#### 14) 신고 테이블 
#### 15) 방문자 테이블
#### 16) 알림 테이블

---

## 3. 물리적 설계 - 오라클의 SQL

### 1) 게시판
create table `DK_BOARD` (
	
  `category` number(10,0) not null,  -- 0~5번 게시판
  `board_num` number(10,0),	--PK --글번호
  `title` varchar2(200) not null,	--글제목
  `nickName` varchar2(50) not null,	--작성자 닉네임
  `userId` varchar2(50) not null,	-- 작성자 아이디
  `content` varchar2(4000) not null,	--글 내용
  `regDate` date default sysdate,	--글 작성날짜
  `updateDate` date default sysdate,	-- 글 수정 날짜
  `likeCnt` number(10,0) default 0,	-- 좋아요 수
  `dislikeCnt` number(10,0) default 0,	--싫어요 수
  `money` number(10,0) default 0,	--기부금액
  `hitCnt` number(10,0) default 0,	--조회수
  `replyCnt` number(10,0) default 0,	--댓글수
  constraint `PK_DK_BOARD` primary key(board_num)	--PK
  
);
	
create sequence `seq_dk_board`;
	
---

### 2) 댓글
create table `DK_REPLY` (
	
`reply_num` number(10,0), --pk
`board_num` number(10,0) not null, --게시글 번호
`reply_content` varchar2(4000) not null,--댓글 내용
`nickName` varchar2(50) not null,  --댓글 작성자 닉네임
`userId` varchar2(50) not null, --댓글 작성자 아이디
`toUserId` varchar2(50), --댓글의 답글 보낼 아이디
`toNickName` varchar2(50),--댓글의 답글 보낼 닉네임
`replyDate` date default sysdate,--작성날짜
`updateDate` date default sysdate, --수정날짜
`likeCnt` number(10,0) default 0, --좋아요 수
`dislikeCnt` number(10,0) default 0, --싫어요 수
`money` number(10,0) default 0, --기부금
`group_num` number(10,0) not null,--댓글 묶음 번호 , 그룹을 이루는 번호
`order_step` number(10,0) not null,--댓글 출력 순서
`depth` number(10,0) not null--댓글 깊이 depth = 루트글인지,답변글인지,답변에 답변글

);

alter table `DK_REPLY` add constraint `pk_reply` primary key (reply_num);

alter table `DK_REPLY` add constraint `fk_reply_board` foreign key (board_num) references `DK_BOARD`(board_num) on delete cascade;

create sequence `seq_dk_reply`

create index `idx_reply` on `DK_REPLY`(board_num desc, reply_num asc);

---
	
### 3) 회원 
create table `dk_member`(

  `member_num` number(10,0) unique,
  `userId` varchar2(50) primary key,
  `userPw` varchar2(100) not null,
  `nickName` varchar2(100) not null unique,
  `cash` number(10,0) default 0,
  `bankName` varchar2(50),
  `account` varchar2(50),
  `regDate` date default sysdate, 
  `loginDate` date default sysdate,
  `enabled` char(1) default '1'--enabled는 스프링 시큐리티에서 사용하는 값. 현재 사용자 계정이 유효한가를 의미
  
);

create sequence `seq_dk_member`

---

### 4) 권한 
create table `dk_member_auth` (

`userId` varchar2(50) not null,
`auth` varchar2(50) default 'ROLE_USER',
constraint `fk_member_auth` foreign key(userId) references `dk_member`(userId)

);

---

### 5) 쪽지 
create table `DK_NOTE` (

`note_num` number(10,0),--PK --쪽지 번호
`content` varchar2(4000) not null, --쪽지 내용
`from_nickname` varchar2(50) not null, --보낸 닉네임
`from_id` varchar2(50) not null, --보낸 아이디
`to_nickname` varchar2(50) not null, --받는 닉네임
`to_id` varchar2(50) not null, --받는 아이디
`regdate` date default sysdate, --쪽지 작성날짜
`read_check` varchar2(10) DEFAULT 'NO',--쪽지 읽음 체크
`from_check` varchar2(10) DEFAULT 'NO',--보낸쪽지함 삭제 체크
`to_check` varchar2(10) DEFAULT 'NO',--받은쪽지함 삭제 체크
constraint `PK_DK_NOTE` primary key(note_num) --PK

);

create sequence `seq_dk_note`;

---

### 6) 업로드 
create table `dk_attach`(

`uuid` varchar2(100) not null,
`uploadPath` varchar2(200) not null,-- 실제 파일이 업로드된 경로
`fileName` varchar2(100) not null, --파일 이름을 의미
`fileType` char(1) default 'I', --이미지 파일 여부를판단
`board_num` number(10,0) -- 해당 게시물 번호를 저장

);

alter table `dk_attach` add constraint `pk_attach` primary key (uuid);
alter table `dk_attach` add constraint `fk_board_attach` foreign key (board_num) references `DK_BOARD`(board_num);

---

### 7) 인증 
create table `persistent_logins` ( 

`username`varchar(64) not null,
`series` varchar(64) primary key,
`token` varchar(64) not null,
`last_used` timestamp not null

);

---

### 8) 게시글 좋아요 
create table `dk_board_like` (

`userId` varchar2(50) not null,
`board_num` number(10,0) not null,
`likeValue` varchar2(50) not null,--좋아요 눌르면 push,다시 눌르면 pull
constraint `fk_board_like` foreign key(board_num) references `DK_BOARD`(board_num) on delete cascade

);

---

### 9) 게시글 싫어요 
create table `dk_board_dislike` ( 

`userId` varchar2(50) not null,
`board_num` number(10,0) not null,
`dislikeValue` varchar2(50) not null,--싫어요 눌르면 push,다시 눌르면 pull
constraint `fk_board_dislike` foreign key(board_num) references `DK_BOARD`(board_num) on delete cascade

);

---

### 10) 댓글 좋아요 
create table `dk_reply_like` ( 

`userId` varchar2(50) not null,
`reply_num` number(10,0) not null,
`likeValue` varchar2(50) not null,--좋아요 눌르면 push,다시 눌르면 pull
constraint `fk_reply_like` foreign key(reply_num) references `DK_REPLY`(reply_num) on delete cascade

);

---

### 11) 댓글 싫어요 
create table `dk_reply_dislike` ( 

`userId` varchar2(50) not null,
`reply_num` number(10,0) not null,
`dislikeValue` varchar2(50) not null,--싫어요 눌르면 push,다시 눌르면 pull
constraint `fk_reply_dislike` foreign key(reply_num) references `DK_REPLY`(reply_num) on delete cascade

);

---

### 12) 스크랩 
create table `dk_scrap` (

`scrap_num` number(10,0),
`userId` varchar2(50) not null,
`board_num` number(10,0) not null,
`regDate` date default sysdate,
constraint `pk_scrap` PRIMARY KEY (scrap_num),
constraint `fk_scrap` foreign key(board_num) references `dk_board`(board_num) on delete cascade
     
);

create sequence `seq_dk_scrap`

---

### 13) 캐시내역 
create table `dk_cash` (

`cash_num` number(10,0),--pk
`cashKind` varchar2(50) not null, --충전,환전,기부하기,기부받기
`cashAmount` number(10,0) not null,
`regDate` date default sysdate, 
`userId` varchar2(50) not null,
`nickName` varchar2(50) not null,  --댓글 작성자 닉네임
`specification` varchar2(50), --미승인/승인완료
`board_num` number(10,0) default 0,
`reply_num` number(10,0) default 0,
constraint `pk_cash` PRIMARY KEY (cash_num)

);
	
create sequence `seq_dk_cash`

---

### 14) 신고  
create table `dk_report` (
	
`report_num` number(10,0), --pk
`reportKind` varchar2(50) not null, --게시글,댓글
`reportingId` varchar2(50) not null, --신고 하는자 아이디
`reportingNick` varchar2(50) not null, --신고 하는자 닉네임
`reportedId` varchar2(50) not null, --신고 받는자 아이디
`reportedNick` varchar2(50) not null, --신고 받는자 닉네임
`board_num` number(10,0) default 0, --글번호  
`reason` varchar2(200) not null, --사유
`regDate` date default sysdate, --신고날짜
constraint `pk_report` PRIMARY KEY (report_num)

);

create sequence `seq_dk_report`
	
---

### 15) 방문자 
CREATE TABLE `dk_visitor`(
	 
`visitor_num` number(10,0), --기본키
`ip` varchar(100) not null, --접속자 아이피
`visit_time` date default sysdate,  --접속자 접속시간
`refer` varchar(300), --접속자가 어느사이트를 타고 들어왔는지
`agent` varchar(400) not null, --접속자 브라우저 정보
constraint `pk_visitor` PRIMARY KEY (visitor_num)

)

create sequence `seq_dk_visitor`
	
---

### 16) 알림 
CREATE TABLE `dk_alarm`(
 
`alarmNum` number(10,0), --기본키
`checking` VARCHAR2(10) DEFAULT 'NO',
`target` VARCHAR2(50) NOT NULL,
`writerNick` VARCHAR2(50) NOT NULL,
`writerId` VARCHAR2(50) NOT NULL,
`kind` VARCHAR2(10) NOT NULL,--1~9
`commonVar1` VARCHAR2(200),
`commonVar2` VARCHAR2(200),
`regdate` date default sysdate,
constraint `pk_alarm` PRIMARY KEY (alarmNum)

)

create sequence `seq_dk_alarm`

---
