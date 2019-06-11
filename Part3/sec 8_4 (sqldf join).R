getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part3/data")
setwd("D:/limworkspace/R_Data_Analysis/Part3")
getwd()

#--------------------------------------------------------------#
#----------------- section 8-4 : sqldf package ----------------#
#--------------------------------------------------------------#


# 8.4 sqldf packages ------------------------------------------------------------------------------------------------------------

install.packages("sqldf")
library(sqldf)
library(googleVis)
Fruits
# 8.4.1 모든 데이터 가져오기 ----------------------------------------------------------------------------------------------------
sqldf('SELECT * from Fruits')                                # 대소문자 구별 

# 8.4.2 조건에 맞는 정보 조회하기 - WHERE절 사용하기 ----------------------------------------------------------------------------
sqldf("SELECT * from Fruits WHERE Fruit='Apples'")           # "" '' 사용주의 
sqldf('SELECT * from Fruits WHERE Fruit=\'Apples\'')

# 8.4.3 출력되는 행 수 제어하기 - limit -----------------------------------------------------------------------------------------
sqldf("SELECT * from Fruits limit 3")                        # limit 0,3 과 같은 의미
sqldf("SELECT * from Fruits limit 3, 5")                     # 출력 범위 설정이 가능 (4번행 ~ 이후 5개 행)

# 8.4.4 정렬해서 출력하기 - ORDER BY --------------------------------------------------------------------------------------------
sqldf("SELECT * from Fruits ORDER BY year")
sqldf("SELECT * from Fruits ORDER BY year DESC")

# 8.4.5 그룹함수 사용하기 -------------------------------------------------------------------------------------------------------
sqldf("SELECT  Fruit, sum(Sales) FROM Fruits 
        GROUP BY Fruit" ) # , 주의

sqldf("SELECT Fruit, sum(Sales), sum(Expenses), sum(Profit) FROM Fruits 
        GROUP BY Fruit" )

sqldf("SELECT year, avg(Sales), avg(Expenses), avg(Profit) FROM Fruits 
        GROUP BY year")

sqldf("SELECT year, avg(Sales), avg(Expenses), avg(Profit) FROM Fruits 
        GROUP BY year 
        ORDER BY avg(Profit) DESC")

# 8.4.6 Sub Query 사용하기 - 조건에맞는 행 찾기 ---------------------------------------------------------------------------------
# 8.4.6.1 단일행 서브쿼리 사용하기 - 서브쿼리에서 하나의 행만 출력하기 ( = 을 사용) ---------------------------------------------
sqldf('SELECT max(Sales), min(Sales) FROM Fruits')
sqldf('SELECT max(Sales), min(Sales) FROM Fruits')
sqldf("SELECT * FROM Fruits WHERE Sales=
        (SELECT min(Sales) FROM Fruits)")

sqldf("SELECT * FROM Fruits WHERE Expenses=
        (SELECT max(Expenses) FROM Fruits)")

# 8.4.6.2 다중행 서브쿼리 사용하기 - 서브쿼리에서 여려행 출력하기 ( IN 을 사용) -------------------------------------------------
sqldf("SELECT * FROM Fruits WHERE Sales IN
        (SELECT Sales FROM Fruits WHERE Sales > 50)")

# 8.4.7 join --------------------------------------------------------------------------------------------------------------------
list.files()
song <- read.csv("song.csv", header = F, fileEncoding = 'utf8') # 인코딩 주의 
colnames(song) <- c('_id',"title","lyrics","girl_group_id"); sonng

girl_group <- read.csv("girl_group.csv", header = F, fileEncoding = 'utf8') # 인코딩 주의 
colnames(girl_group) <- c('_id',"name","debut"); str(girl_group)

# 8.4.7.1 INNER JOIN 
sqldf("SELECT gg._id, gg.name ,gg.debut, s.title
      FROM girl_group AS gg
      INNER JOIN song AS s
      ON gg._id = s.girl_group_id")               # join 조건 

sqldf("SELECT gg._id, gg.name ,gg.debut, s.title
      FROM girl_group AS gg
      JOIN song AS s
      ON gg._id = s.girl_group_id")               # INNER가 없어도 작동은 가능하나.. 가급적이면 사용하자 


# 8.4.8 UPDATE / DELETE - 데이터 변경 및 삭제 (실제로 값을 저장하려면 변수할당을 해야함) ----------------------------------------
sqldf(c("UPDATE Fruits SET Profit=60 WHERE Fruit='Apples' AND Year=2008",
        "SELECT * FROM Fruits"))

sqldf(c("DELETE FROM Fruits WHERE Fruit='Apples' AND Year=2008",
        "SELECT * FROM Fruits"))
