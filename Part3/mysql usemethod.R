getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")
setwd("D:/limworkspace/R_lecture/Part3")
getwd()

#--------------------------------------------------------------#
#---------- Mysql in R : R-DBMS 관계형 데이터베이스 -----------#
#--------------------------------------------------------------#

# 1. 관계형 데이터베이스 Relational DBMS 
# 2. 계층적 데이터베이스 Hierarchical DBMS
# 3. 네트워크 데이터베이스 Network DBMS
# 4. NoSql : Not only sql // sql 뿐만아니라 // monggoDB

# R-DBMS 언어는 크게 세 가지 https://ko.wikipedia.org/wiki/SQL

#        1. Data Control Language (DCL) - DB전문가, DB관리자들이 주로 사용 // DBMS 종류마다 언어가 다름 
#   ***  2. Data Manipulation Language (DNL) - DMBS 언어끼리 사용언어가 비슷함 // 주로 이 언어를 학습 
#     *  3. Data Definition Language (DDL) - 비교적 비슷

# 1. mysql 설치방법 ---------------------------------------------------------------------------------------

# mysql 실습파일 확인 
# mysql 설치 https://dev.mysql.com/downloads/mysql/5.7.html#downloads 
# .NET framework 설치 https://dotnet.microsoft.com/download/dotnet-framework/net452
# root pw - smartdata
# cmd -> cd program files\MySQL\MySQL Server 5.7\bin
# mysql -u root -p 
# create user 'smartuser'@'localhost' identified by 'smartpass';
# grant all privileges on *.* to 'smartuser'@'localhost';
# flush privileges;

# Heidisql 10.5 설치 https://www.heidisql.com/download.php
# 신규 -> 사용자 (smartuser) / smartpass 
# 도구 -> 환경설정(d2coding) -> 작업용 database 생성 ->

# 작업용 database 생성 
  create database ezen
    default character set utf8
    default collate utf8_general_ci;

# 테이블 생성 
USE ezen;  # 사용할 데이터베이스 지정 
CREATE TABLE if NOT EXISTS address_book ( # address_book이라는 데이터베이스가 이미 존재하지 않는다면, 새로운 데이터베이스 생성 
    NO int UNSIGNED NOT NULL auto_increment, # 정수가 아닌것은 넣지 않고, 빈칸도 채우지 않는다 // auto_increment : 중복을 막아줌, NOT NULL : 반드시 데이터가 채워져서 들어가야함 
    NAME VARCHAR(10) NOT NULL, # varchar(n) : 지정된 길이보다 짧은 데이터가 입력될 시 나머지 공간은 채우지 않는다. // 유연함  
    tel VARCHAR(14), # 데이터를 입력해도되고 안해도됨
    nickname VARCHAR(20) DEFAULT '별명', # 빈칸일 경우 '별명'이 입력됨
    PRIMARY KEY(NO) # Key : unique한 값을 지정해줘야 한다 // 키값으로 no를 설정   
    ) AUTO_INCREMENT=10001 DEFAULT CHARSET=UTF8; # 추가적으로 no가 10001번 부터 시작 // 한글을 처기하기 위해 charset=utf8

USE ezen;
desc address_book; # address_book 테이블 확인

# 테이블 조회
show tables;
desc address_book;

# 테이블 제거
drop table [테이블 명];
create table tmp (
  id int,
  name varchar(10)
);
drop table tmp;

# 테이블 이름 변경 
rename table [테이블 명] to [새 테이블명];
rename table tmp to tmp_table;

# 테이블 변경
# add : 컬럼추가
# drop : 컬럼삭제
# changer 컬럼명 변경, 컬럼자료형 변경
# modify : 컬럼순서 바꾸기

# 1. 컬럼추가 - add
ALTER TABLE addr_book ADD gender CHAR(2) NOT NULL;
DESC addr_book;

ALTER TABLE addr_book ADD email VARCHAR(20) NOT NULL AFTER tel; # after로 위치지정 가능 
# 2. 컬럼삭제 - drop
ALTER TABLE addr_book drop nickname;
DESC addr_book;

# 3. 컬럼명 변경, 컬럼 자료형 변경 - change
ALTER TABLE addr_book CHANGE NO adid INT(8); # 데이터 타입도 설정을 해야함
DESC addr_book;

# 4. 컬럼순서 바꾸기 - modify
ALTER TABLE addr_book MODIFY gender CHAR(2) AFTER NAME;
DESC addr_book;

# 5. 데이터 조회
# 5.1 조건 - select 

SELECT * FROM city;
SELECT * FROM city WHERE countrycode = 'KOR';
SELECT * FROM city WHERE countrycode LIKE 'KOR';                          # city 데이터 베이스 내에서 countrycode 변수가 kor인 것을 찾아라
SELECT * FROM city WHERE district LIKE 'kyonggi';                         # city 데이터 베이스 내에서 district 변수가 kyonggi인 것을 찾아라
SELECT * FROM city WHERE district LIKE 'kyonggi' AND population > 500000; # city 데이터 베이스 내에서 district 변수가 kyonggi인 것을 찾고
                                                                          # 그리고 population 변수가 500000 이상인 것을 찾아라 

SELECT DISTRICT FROM city WHERE countrycode='KOR';                        # 특정컬럼만 지정해서 가져오기 
SELECT DISTINCT DISTRICT FROM city WHERE countrycode='KOR';               # distinct : 중복되는 값 제거 

  
SELECT * FROM city WHERE district LIKE 'Taejon' OR 
  district LIKE 'chungchongbuk' OR district LIKE 'chungchongnam';              # 조건에 맞는 데이터 가져오기 

SELECT * FROM city WHERE countrycode LIKE 'kor' and population > 1000000 AND ID%2 = 1; # 짝수만 가져오기

SELECT * FROM city WHERE countrycode='KOR' AND population BETWEEN 1000000 AND 2000000;
SELECT * FROM city WHERE countrycode='KOR' AND NAME LIKE 'tae%';               # name이 tae로 시작하는 데이터 가져오기

  
# 5.2 순서 order by

SELECT * FROM city WHERE district LIKE 'kyonggi' ORDER BY NAME;                # order by '컬럼명' 컬럼을 기준으로 정열 
SELECT * FROM city WHERE district LIKE 'kyonggi' ORDER BY population DESC;     # population을 기준으로 정렬하되 내림차순
  
SELECT * FROM city WHERE countrycode='KOR' ORDER BY district;
SELECT * FROM city WHERE countrycode='KOR' ORDER BY district, population desc; # 조건을 하나이상 가능 

  #  R  vs mysql 
  #  %%     %
  #  &      and
  #  |      or 
  #  >= <=  between and  
  
# 5.3 함수이용
  
SELECT MAX(population) FROM city WHERE countrycode='kor';
SELECT min(population) FROM city WHERE countrycode='kor';
SELECT avg(population) FROM city WHERE countrycode='kor';
SELECT sum(population) FROM city WHERE countrycode='kor';

SELECT sum(population), max(population), avg(population),
sum(population) FROM city WHERE countrycode='kor';                            # 한번에 다루기 
  
# 5.4 그루핑

SELECT GROUP_CONCAT(NAME) FROM city WHERE district='chungchongnam';

SELECT GROUP_CONCAT(DISTINCT district) FROM city WHERE countrycode='kor';

SELECT district, COUNT(*) FROM city WHERE countrycode='kor' GROUP BY district; # district를 기준으로 그룹을 한 후 해당하는 district의 개수를 세라 
  
SELECT district, COUNT(*) FROM city WHERE countrycode='kor'
  GROUP BY district HAVING COUNT(*)=6;                                         # count가 6인 데이터만 가져와라

SELECT district, COUNT(*) FROM city WHERE countrycode='kor'                    # count가 6이상인 데이터만 가져와라
  GROUP BY district HAVING COUNT(*)>=6;    
  
SELECT district, COUNT(*) FROM city WHERE countrycode='kor'
  GROUP BY district HAVING COUNT(*)>=6 ORDER BY COUNT(*) desc;                 # 그리고 count를 기준으로 내림차순 정렬을 해라
  
SELECT countrycode, COUNT(*) FROM city 
  GROUP BY countrycode HAVING COUNT(*) >=50;                                   # countrycode가 50개 이상인 나라를 출력 
  
  
# 5.5 데이터 병합 - inner join

SELECT city.NAME, city.Population, country.NAME FROM city
  INNER JOIN country ON city.CountryCode = country.CODE
  WHERE city.countrycode='kor';
  
SELECT city.NAME, city.Population, country.NAME FROM city                      # select
  INNER JOIN country ON city.CountryCode = country.CODE
  WHERE city.population > 7000000                                              # filter
  ORDER BY city.Population desc;                                               # arrange 
  
SELECT city.NAME, city.Population, country.NAME FROM city
  INNER JOIN country ON city.CountryCode = country.CODE
  WHERE city.population > 7000000
  ORDER BY city.Population desc
  LIMIT 5;                                                                     # head

# 5.6 데이터 삽입     

DESC eagles; # 테이블 구조 보기 
  
INSERT INTO	eagles VALUES (37,'노시환','내야수','경남고','우투우타'),
                          (46,'송은범','투수','동산고','우투우타'),
                          (48,'채드밸','투수','S.Doyle','좌투우타'),
                          (44,'서폴드','투수','Bellmont','우투우타'),
                          (53,'김민우','투수','용마고','우투우타'),
                          (17,'김범수','투수','북일고','좌투좌타'),
                          (50,'이성열','내야수','순천효천고','우투좌타'),
                          (43,'정은원','내야수','인천고','우투좌타'),
                          (27,'변우혁','내야수','북일고','우투우타'),
                          (30,'호잉','외야수','-','우투좌타');
SELECT * FROM eagles; 

# 5.7 데이터 갱신 및 삭제
  
UPDATE eagles SET highschool='hoying' WHERE backNo=30;
UPDATE eagles SET POSITION='외야수' WHERE backNo=50;

  #SELECT * FROM eagles; 

DELETE FROM eagles WHERE backNo=30 OR backNo=44; 

  #SELECT * FROM eagles; 

# 6. 뷰(보조테이블) 생성
  
CREATE VIEW pitcher AS SELECT * FROM eagles
  WHERE POSITION LIKE '투수';
SELECT * FROM pitcher;	

CREATE VIEW outfielder AS SELECT * FROM eagles
  WHERE POSITION LIKE '외야수';
SELECT * FROM outfielder;	
  
CREATE VIEW infielder AS SELECT * FROM eagles
  WHERE POSITION LIKE '내야수';
SELECT * FROM infielder;

DROP VIEW infielder;
  
CREATE VIEW infielder 
  AS SELECT  backNo, NAME, highschool, hand FROM eagles
  WHERE POSITION LIKE '내야수';
SELECT * FROM infielder;
  
# 7. 날짜 다루기
  
ALTER TABLE eagles ADD birthday DATE;
DESC eagles;

UPDATE eagles SET birthday ='1995-10-03' WHERE backNo=30;
UPDATE eagles SET birthday ='2000-03-18' WHERE backNo=17;
UPDATE eagles SET birthday ='2000-12-03' WHERE backNo=37;
UPDATE eagles SET birthday ='2000-01-17' WHERE backNo=43;
UPDATE eagles SET birthday ='1984-03-17' WHERE backNo=46;    
UPDATE eagles SET birthday ='1989-05-18' WHERE backNo=48;
UPDATE eagles SET birthday ='1989-05-18' WHERE backNo=50;
UPDATE eagles SET birthday ='1989-05-18' WHERE backNo=53;    
UPDATE eagles SET birthday ='2000-06-19' WHERE backNo=27;  
SELECT * FROM eagles;

SELECT NOW(), CURDATE(), CURTIME();
SELECT * FROM eagles ORDER BY birthday;
SELECT NAME, DATE_FORMAT(birthday, "%y%m%d") FROM eagles ORDER BY birthday;
SELECT NAME, DATE_FORMAT(birthday, "%Y%M%D") FROM eagles ORDER BY birthday;
  
  
# 8. Join
  
CREATE TABLE girl_group (
    _id INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(32) NOT NULL,
    debut DATE NOT NULL,
    hit_song_id int
  ) DEFAULT CHARSET=UTF8;
  
CREATE TABLE song (
    _id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(32) NOT NULL,
    lyrics VARCHAR(32)
  ) DEFAULT CHARSET=UTF8;
  
INSERT INTO song VALUES (101, 'Tell Me', 'tell me tell me tetetete tel me');
INSERT INTO song (title, lyrics) 
  VALUES ('Gee', 'GEE GEE GEE GEE GEE BABY BABY'),
  ('미스터', '이름이 뭐야 미스터'),
  ('Abracadabra', '이러다 미쳐 내가 여리여리'),
  ('8282', 'Give me a call baby baby'),
  ('기대해', '기대해'),
  ('I Don\`t care', '다른 여자들의 다리를'),
  ('Bad Girl Good Girl', '앞에선 한 마디 말도'),
  ('피노키오', '뉴에삐오'),
  ('별빛달빛', '너는 내 별빛 내 마음의 별빛'), 
  ('A', 'A 워오우 워오우워 우우우'),
  ('나혼자', '나 혼자 밥을 먹고 나 혼자 영화 보고'), 
  ('LUV', '설레이나요 '),
  ('짧은치마', '짧은 치마를 입고 내가 길을 걸으면'),
  ('위아래', '위 아래 위위 아래'), 
  ('Dumb Dumb' , '너 땜에 하루종일');
  
INSERT INTO girl_group (NAME, debut, hit_song_id) 
  VALUES ('원더걸스', '2007-02-10', 101),
  ('소녀시대', '2007-08-02', 102), 
  ('카라', '2009-07-30', 103),
  ('브라운아이드걸스', '2008-01-17', 104), 
  ('다비치', '2009-02-27', 105),
  ('2NE1', '2009-07-08', 107), 
  ('f(x)', '2011-04-20', 109),
  ('시크릿', '2011-01-06', 110), 
  ('레인보우', '2010-08-12', 111);
  
INSERT INTO girl_group (name, debut) 
  VALUES  ('애프터 스쿨', '2009-11-25'), 
  ('포미닛', '2009-08-28');
  
SELECT gg._id, gg.NAME, s.title     # Inner join
  FROM girl_group AS gg             # AS : aliasing
  INNER JOIN song AS s 
  ON s._id = gg.hit_song_id;  
  
  
  

# 연습문제 - mysql실습 

# 1. 2009년도에 데뷔한 걸그룹 정보는?
SELECT * FROM girl_group WHERE debut BETWEEN '2009-01-01' AND '2009-12-31';


# 2. 2009년에 데뷔한 걸그룹의 히트송은?
SELECT gg._id, gg.NAME AS '걸그룹이름', gg.debut AS '데뷔일', s.title AS '제목'
  FROM girl_group AS gg 
  LEFT OUTER JOIN song AS s
  ON s._id = gg.hit_song_id
  WHERE debut BETWEEN '2009-01-01' AND '2009-12-31';
  #where debut like '2009%'

# 3. 대륙별로 국가숫자, GNP합, GNP 평균은
SELECT  Continent, COUNT(*), sum(GNP), avg(GNP) FROM country 
  GROUP BY Continent;

# 4. 아시아 대륙에서 인구가 가장 많은 도시 10개를 내림차순으로 보여라 (대륙명, 국가명, 도시명, 인구수)
SELECT country.continent, country.NAME, city.district, city.population
  FROM country 
  INNER JOIN city
  ON country.CODE = city.CountryCode
  WHERE country.continent='Asia'
  ORDER BY city.population DESC LIMIT 10;

# 5. 전 세계에서 인구가 가장 많은 10개 도시에서 사용하는 공식언어는? (도시명, 인구수, 언어명)
SELECT c.NAME AS '도시명', c.population AS '인구수', cl.LANGUAGE AS '언어명'
  FROM city AS c 
  INNER JOIN countrylanguage AS cl
  ON c.CountryCode = cl.CountryCode
  WHERE cl.IsOfficial=true
  ORDER BY c.Population DESC limit 10;

# 참고 : mysql data type : http://www.incodom.kr/DB_-_%EB%8D%B0%EC%9D%B4%ED%84%B0_%ED%83%80%EC%9E%85/MYSQL

  
# 테이블 export / import 

USE ezen;
SELECT * FROM song;
SELECT * FROM girl_group;


SHOW VARIABLES LIKE "secure_file_priv";
SELECT * FROM girl_group INTO OUTFILE
  'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/girl_group.csv'
  FIELDS TERMINATED BY ','    # 구분자를 ,로 설정 -> csv파일 
  LINES TERMINATED BY '\r\n'; # 

SHOW VARIABLES LIKE "secure_file_priv";
SELECT * FROM song INTO OUTFILE
  'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/song2.csv'
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\r\n';



# 2. sqldf packages *** -----------------------------------------------------------------------------------


