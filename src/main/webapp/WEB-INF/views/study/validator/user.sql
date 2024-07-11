show tables;

desc user;
drop table user;

create table user (
	idx int not null auto_increment primary key,
	mid varchar(10) not null,
	name varchar(30) not null,
	age int default 20,
	address varchar(15) default '서울'
);

insert into user values (default, 'admin', '관리자', 33, '청주');
insert into user values (default, 'hkd1234', '홍길동', default, default);
insert into user values (default, 'kms1234', '김말숙', default, '인천');
insert into user values (default, 'ikj1234', '이기자', 25, default);

select * from user;

create table user2 (
	mid varchar(4) not null,
	job varchar(10)
);