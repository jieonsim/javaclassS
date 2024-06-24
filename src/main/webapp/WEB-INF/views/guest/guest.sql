show tables;

CREATE TABLE guest2 (
	idx INT NOT NULL auto_increment PRIMARY KEY, /*방명록 고유번호*/
	name VARCHAR(20) NOT NULL, /*방명록 작성자 성명*/
	content text NOT NULL, /*방명록 글 내용*/
	email VARCHAR(60), /*메일 주소 */
	homePage VARCHAR(60), /*홈페이지주소(블로그주소, 인스타그램주소)*/
	visitDate datetime DEFAULT now(), /*방문일자*/
	hostIp VARCHAR(30) NOT NULL /*방문자의 접속 IP*/
);

DESC guest2;
insert into guest2 values (default, '관리자', '방명록 서비스를 시작합니다.', 'cjsk1126@naver.com', 'cjsk1126.tistory.com', default, '192.168.50.20');
SELECT * FROM guest2;
select count(*) from guest2;

