getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")
testfile <- read.csv("학생시험결과_전체점수.csv")

str(testfile)

testfile$이름
testfile[1,3]
testfile[,4]
head(testfile)
View(testfile)
colnames(testfile)[5] <- "환산점수"

testfile <- cbind(testfile, data.frame(grade = rep(c("A","B","C"),nrow(testfile)))); testfile

names(testfile)
colnames(testfile)[7] <- "등급"

testfile2 <- rbind(testfile, data.frame(순위=30,
                                        이름="김준호",
                                        조=3,
                                        점수=45,
                                        환산점수=57.8,
                                        성취율=0.50,
                                        등급="A")); testfile2

subset(testfile, 점수<45 | 성취율>0.80)
subset(testfile, 조!=3 & 환산점수 < 75)
subset(testfile, 조==4 & 성취율>=0.8 | 등급=='B' & 점수 <= 10)

names(testfile)
subset(testfile, select = c('순위','점수','등급'))
subset(testfile, select = c(순위,점수,등급))             # select 옵션에서는 ''가 상관없으나 되도록이면 안헷갈리게 ''사용하자. 


testfile3 <- NULL
testfile4 <- NULL
testfile3 <- testfile2[1:40,]; testfile3
testfile4 <- testfile2[40:nrow(testfile2),]; testfile4

rbind_test <- rbind(testfile3,testfile4); rbind_test
cbind_test <- cbind(testfile3,testfile4); cbind_test     # 행의 개수가 다르면 cbind 불가

testfile[seq(nrow(testfile),round(nrow(testfile)/2)),]

rm(list = ls())

# aggregate, apply 계열 함수 -----------------------------------------------------------

getwd()
list.files()
data1 <- read.csv("data1.csv"); str(data1)
data2 <- read.csv("1-4호선승하차승객수.csv"); str(data2)

str(data2)
subset(data2, 승차 >= 350000 & 하차 <= 500000)

install.packages("stringr")
library(stringr)

data2[which(nchar(data2[,2])==3),2] <- paste0(0,data2[which(nchar(data2[,2])==3),2]); data2
data2$새로운시간 <- paste(str_sub(data2[,2],1,2),
                         str_sub(data2[,2],3,4), sep=":"); data2$시간 <- NULL; data2

# 연습문제 1

apply(data1[,-1],2,sum) # 1 : 행, 2: 열
apply(data2[,-1],1,sum)

# 연습문제 2
str(data2)
attach(data2)
tapply(승차, 노선번호, sum)
tapply(하차 ,노선번호, sum)
apply(data2[,3:4],2,sum)

aggregate(승차+하차 ~ 노선번호,data2,sum)
aggregate(승차~노선번호,data2,sum)
aggregate(하차~노선번호,data2,sum)

# 연습문제 3
str(airquality)
aggregate(Ozone ~ Month, airquality, mean) 

install.packages("reshape2")
library(reshape2)
melt_air <- melt(airquality, id=c("Month","Day"),na.rm=T); str(melt_air)
aggregate(value~Day,melt_air,mean0)
