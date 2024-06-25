show tables;

create table board2 (
  idx  int not null auto_increment,		/* 게시글의 고유번호 */
  mid  varchar(20) not null,					/* 게시글 올린이 아이디 */
  nickName varchar(20) not null,			/* 게시글 올린이 닉네임 */
  title varchar(100)   not null,			/* 게시글 제목 */
  content text not null,							/* 글 내용 */
  readNum int default 0,							/* 글 조회수 */
  hostIp  varchar(40) not null,				/* 글 올린이 IP */
  openSw	char(2)  default 'OK',			/* 게시글 공개여부(OK:공개, NO:비공개) */
  wDate		datetime default now(),			/* 글쓴 날짜 */
  good		int default 0,							/* '좋아요' 클릭 횟수 누적 */
  complaint char(2) default 'NO',			/* 신고글 유무(신고당한글:OK, 정상글:NO) */
  primary key(idx),										/* 기본키 : 고유번호 */
  foreign key(mid) references member2(mid)
);

drop table board2;
desc board2;
select * from board2;

insert into board2 values (default,'admin','관리맨','게시판 서비스를 시작합니다.','즐거운 게시판생활이 되세요.',default,'192.168.50.20',default,default,default,default);

/* 댓글 달기 */
create table boardReply2 (
  idx       int not null auto_increment,	/* 댓글 고유번호 */
  boardIdx  int not null,						/* 원본글(부모글)의 고유번호-외래키로 지정 */
  mid				varchar(20) not null,		/* 댓글 올린이의 아이디 */
  nickName	varchar(20) not null,		/* 댓글 올린이의 닉네임 */
  wDate			datetime	default now(),/* 댓글 올린 날짜/시간 */
  hostIp		varchar(50) not null,		/* 댓글 올린 PC의 고유 IP */
  content		text not null,					/* 댓글 내용 */
  primary key(idx),
  foreign key(boardIdx) references board2(idx)
  on update cascade
  on delete restrict
);
desc boardReply2;

insert into boardReply2 values (default, 33, 'kms1234', '김장미', default, '192.168.50.12','글을 참조 했습니다.');
insert into boardReply2 values (default, 32, 'kms1234', '김장미', default, '192.168.50.12','다녀갑니다.');
insert into boardReply2 values (default, 34, 'kms1234', '김장미', default, '192.168.50.12','멋진글이군요...');

select * from boardReply2;

select * from board2;
select * from board2 where idx = 9;  /* 현재글 */
select idx,title from board2 where idx > 9 order by idx limit 1;  /* 다음글 */
select idx,title from board2 where idx < 9 order by idx desc limit 1;  /* 이전글 */

-- 시간으로 비교해서 필드에 값 저장하기
select *, timestampdiff(hour, wDate, now()) as hour_diff from board2;

-- 날짜로 비교해서 필드에 값 저장하기
select *, datediff(wDate, now()) as date_diff from board2;

-- 관리자는 모든글 보여주고, 일반사용자는 비공개글(openSw='NO')과 신고글(complaint='OK')은 볼수없다. 단, 자신이 작성한 글은 볼수 있다.
select count(*) as cnt from board2;
select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO';
select count(*) as cnt from board2 where mid = 'hkd1234';

select * from board2 where openSW = 'OK' and complaint = 'NO';
select * from board2 where mid = 'hkd1234';
select * from board2 where openSW = 'OK' and complaint = 'NO' union select * from board2 where mid = 'hkd1234';
select * from board2 where openSW = 'OK' and complaint = 'NO' union all select * from board2 where mid = 'hkd1234';

select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board2 where mid = 'hkd1234';
select sum(a.cnt) from (select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board2 where mid = 'hkd1234') as a;

select sum(a.cnt) from (select count(*) as cnt from board2 where openSW = 'OK' and complaint = 'NO' union select count(*) as cnt from board2 where mid = 'hkd1234' and (openSW = 'NO' or complaint = 'OK')) as a;

/* 댓글수 연습 */
select * from board2 order by idx desc;
select * from boardReply2 order by boardIdx, idx desc;

-- 부모글(33)의 댓글만 출력
select * from boardReply2 where boardIdx = 33;
select boardIdx,count(*) as replyCnt from boardReply2 where boardIdx = 33;

select * from board2 where idx = 33;
select *,(select count(*) from boardReply2 where boardIdx = 33) as replyCnt from board2 where idx = 33;
select *,(select count(*) from boardReply2 where boardIdx = b.idx) as replyCnt from board2 b;



/*  view  /  index 파일 연습 */
select * from board2 where mid = 'admin';

create view adminView as select * from board2 where mid = 'admin';

select * from adminView;

show tables;

show full tables in javaclass where table_type like 'view';

drop view adminview;

desc board2;

create index nickNameIndex on board2(nickName);

show index from board2;

alter table board2 drop index nickNameIndex;


