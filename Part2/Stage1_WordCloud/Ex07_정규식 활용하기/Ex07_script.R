getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage1_WordCloud/Ex07_정규식 활용하기")
getwd()

rm(list = ls())

library(rJava)
library(KoNLP)
library(wordcloud2)
library(stringr)

list.files("data")

alert <- readLines("data/oracle_alert_testdb.log"); head(alert,3)
error_1 <- gsub(" ", "_", alert)

head(unlist(error_1),10)
error_2 <- unlist(error_1)
error_2 <- Filter(function(x){nchar(x) >= 5}, error_2)
error_3 <- grep("^ORA-+", error_2, value = T)             # ORA- 패턴으로 시작하는 벡터를 1개 이상 찾기 
error_4 <- str_split_fixed(error_3,":",2)[,1]
error_4 <- str_split_fixed(error_4,"_",2)[,1]


errorcount <- table(error_4)
head(sort(errorcount, decreasing = T), 20)

top_errorcount <- sort(errorcount[errorcount > 30],decreasing = T)

wordcloud2(top_errorcount, size = 0.1,
           fontFamily = 'Segoe UI', fontWeight = 'bold',
           color = 'random-light', backgroundColor = "black",shuffle = TRUE,
           shape = "circle", minRotation = 0, maxRotation = 0)





?wordcloud2
# 정규식 참고자료 : https://github.com/limwonki0619/R_Data_Analysis/blob/master/Part3/sec10%20(regular%20expression).R
