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

