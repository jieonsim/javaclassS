show tables;

create table kakaoAddress (
	address varchar(50) not null comment '지점명',
	latitude double not null comment '위도',
	longitude double not null comment '경도'
);


desc kakaoAddress;

drop table kakaoAddress;

select * from kakaoAddress order by address;

delete from kakaoAddress;