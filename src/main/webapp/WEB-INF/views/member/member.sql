show tables;

create table member2 (
  idx       int not null auto_increment,/* 회원 고유번호 */
  mid       varchar(30) not null,				/* 회원 아이디(중복불허) */
  pwd       varchar(100) not null,			/* 회원 비밀번호(SHA256 암호화 처리) */
  nickName  varchar(20) not null,				/* 회원 별명(중복불허/수정가능) */
  name		  varchar(20) not null,				/* 회원 성명 */
  gender    char(2)	not null default '남자',	/* 회원 성별 */
  birthday  datetime default now(),			/* 회원 생일 */
  tel			  varchar(15),								/* 전화번호 : 010-1234-5678 */
  address   varchar(100),								/* 주소(다음 API 활용) */
  email		  varchar(60) not null,		  	/* 이메일(아이디/비밀번호 분실시에 사용)-형식체크필수 */
  homePage  varchar(60),								/* 홈페이지(블로그)주소 */
  job			  varchar(20),								/* 직업 */
  hobby		  varchar(100),								/* 취미(2개이상 선택가능, 구분자는 '/'로 처리한다. */
  photo		  varchar(100) default 'noimage.jpg', /* 회원 사진 */
  content   text,												/* 회원 소개 */
  userInfor char(3) default '공개',			/* 회원 정보 공개여부(공개/비공개) */
  userDel   char(2)  default 'NO',			/* 회원 탈퇴신청여부(NO:현재 활동중, OK:탈퇴신청중) */
  point		  int default 100,						/* 회원 누적포인트(가입포인트100점, 1회방문시 10포인트증가, 1일 최대 50포인트까지 허용, 물건구매시 100원당 1포인트 증가 */
  level     int default 3,							/* 회원등급(0:관리자, 1:우수회원, 2:정회원, 3:준회원, 99:비회원, 999:탈퇴신청회원 */
  visitCnt  int default 0,							/* 총 방문횟수 */
  startDate datetime default now(),			/* 최초 가입일 */
  lastDate  datetime default now(),			/* 마지막 접속일 */
  todayCnt  int default 0,							/* 오늘 방문한 횟수 */
  /* salt      char(8) not null, */			/* 비밀번호 보안을 위한 salt */
  /* primary key (idx,mid) */
  primary key (idx),
  unique(mid)
);
desc member2;

insert into member2 values (default,'admin','1234','관리맨','관리자','남자',default,'010-1234-4567','050/서울시/그린아파트/100동/101호','abc@atom.com','http://wwww.atom.com','학생','등산',default,'관리자입니다.',default,default,default,default,default,default,default,default);

select * from member2;

drop table member2;


select lastDate, now(), timestampdiff(day, lastDate, now()) as deleteDiff from member2;

/* 실시간 DB채팅 테이블 설계 */
create table member2Chat (
  idx   int  not null auto_increment primary key,
  nickName varchar(20) not null,
  chat  varchar(100) not null
);
desc member2Chat;

insert into member2Chat values (default,'admin','안녕1');
insert into member2Chat values (default,'hkd1234','안녕2');
insert into member2Chat values (default,'kms1234','안녕3');
insert into member2Chat values (default,'admin','안녕4');
insert into member2Chat values (default,'hkd1234','안녕5');
insert into member2Chat values (default,'admin','안녕6');
insert into member2Chat values (default,'kms1234','안녕7');
insert into member2Chat values (default,'hkd1234','안녕8');
insert into member2Chat values (default,'admin','안녕9');
insert into member2Chat values (default,'kms1234','안녕10');
insert into member2Chat values (default,'admin','안녕11');
insert into member2Chat values (default,'hkd1234','안녕12');
insert into member2Chat values (default,'kms1234','안녕13');
insert into member2Chat values (default,'admin','안녕14');
insert into member2Chat values (default,'hkd1234','안녕15');
insert into member2Chat values (default,'admin','안녕16');
insert into member2Chat values (default,'kms1234','안녕17');
insert into member2Chat values (default,'hkd1234','안녕18');
insert into member2Chat values (default,'admin','안녕19');
insert into member2Chat values (default,'hkd1234','안녕20');
insert into member2Chat values (default,'hkd1234','안녕21');
insert into member2Chat values (default,'admin','안녕22');
insert into member2Chat values (default,'hkd1234','안녕23');

select * from member2Chat order by idx desc limit 20;
select m.* from (select * from member2Chat order by idx desc limit 20) m order by idx;
