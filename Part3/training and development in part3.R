getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")
testfile <- read.csv("학생시험결과_전체점수.csv")

setwd("D:/limworkspace/R_lecture/Part3")

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
