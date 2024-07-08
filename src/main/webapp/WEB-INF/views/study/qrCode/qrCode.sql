/* qrCode.sql */
show tables;

create table qrCode (
  idx       int not null auto_increment primary key,
  mid       varchar(20) not null,
  name      varchar(20) not null,
  email     varchar(50) not null,
  movieName varchar(50) not null,		/* 영화제목명 */
  movieDate varchar(50) not null,		/* 영화 상영일자 */
  movieTime varchar(50) not null,		/* 영화 상영시간 */
  movieAdult int not null,					/* 성인 티켓수 */
  movieChild int not null,					/* 소인 티켓수 */
  publishDate varchar(30) not null, /* QR코드 발행일자 */
  qrCodeName  varchar(80) not null, /* QR코드 이미지 파일명 */
  foreign key(mid) references member2(mid)
);
desc qrCode;
drop table qrCode;
