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

# create database ezen
#  default character set utf8
#  default collate utf8_general_ci;


# 2. sqldf packages *** -----------------------------------------------------------------------------------


