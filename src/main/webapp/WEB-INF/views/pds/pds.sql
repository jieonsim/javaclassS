show tables;

create table pds2 (
  idx   int not null auto_increment,	/* 자료실 고유번호 */
  mid   varchar(20) not null,					/* 올린이 아이디 */
  nickName varchar(20)  not null,			/* 올린이 닉네임 */
  fName		 varchar(200) not null,			/* 업로드시의 화일명 */
  fSName   varchar(200) not null, 		/* 실제 서버에 저장되는 파일명 */
  fSize		 int	not null,							/* 업로드되는 파일의 총 사이즈 */
  title    varchar(100) not null,			/* 업로드파일의 간단 제목 */
  part		 varchar(20)  not null,			/* 파일분류(학습/여행/음식/__/기타) */
  fDate    datetime  default now(),		/* 업로드한 날짜 */
  downNum	 int  default 0,						/* 다운 받은 횟수 */
  openSw	 char(3) default '공개',			/* 파일 공개여부(공개/비공개) */
  /* pwd      varchar(100),     					파일 비공개시 암호설정 sha256 암호화 */
  hostIp	 varchar(30)  not null,			/* 업로드한 클라이언트 IP */  
  content text,												/* 업로드 파일의 상세 설명 */
  primary key(idx),
  foreign key(mid) references member2(mid)
);

desc pds2;
