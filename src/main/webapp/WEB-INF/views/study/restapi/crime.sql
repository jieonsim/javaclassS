show tables;

create table crime(
	idx int not null auto_increment primary key,
	year int comment '발생년도',
	police varchar(20) not null comment '경찰서',
	robbery int comment '강도',
	theft int comment '절도',
	murder int comment '살인',
	violence int comment '폭력'
);


desc crime;

select * from crime order by year;


select year,sum(robbery) as totRobbery,sum(murder) as totMurder,sum(theft) as totTheft,sum(violence) as totViolence,
    avg(robbery) as avgRobbery,avg(murder) as avgMurder,avg(theft) as avgTheft,avg(violence) as avgViolence
    from crime where year = 2015 and police like '서울%';