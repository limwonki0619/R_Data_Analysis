getwd()
setwd("D:/limworkspace/R_Data_Analysis/Assignment/AM_5")
getwd()

# [과제5]

rm(list=ls())
install.packages("rJava")
install.packages("KoNLP")
install.packages("wordcloud2")
library(dplyr)
library(stringr)
library(rJava)
library(KoNLP)
library(wordcloud)
library(wordcloud2)

rm(list = ls())

seoul_all_1 <- readLines("data/응답소_2015_all.txt") %>% str_remove_all("=") 
seoul_all_2 <- sapply(seoul_all_1, extractNoun, USE.NAMES = F)
seoul_all_3 <- unlist(seoul_all_2) 

seoul_all_3 <- str_replace_all(seoul_all_3,"[^[:alpha:]]","")     # 한글, 영어 외에는 삭제  
seoul_all_3 <- str_replace_all(seoul_all_3," ","")
seoul_all_3 <- str_replace_all(seoul_all_3,"동성애자","동성애")

gsub_txt <- readLines("gsubfile.txt")
for (i in 1:length(gsub_txt)) {
  seoul_all_3  <- gsub((gsub_txt[i]),"",seoul_all_3)
}

seoul_all_4 <- Filter(function(x) { nchar(x) >= 2 & nchar(x) <= 7 }, seoul_all_3)

wordcount <- head(sort(table(seoul_all_4), decreasing = T),45)
wordcloud2(wordcount, size=0.8, 
           col="random-light", backgroundColor="black",
           fontFamily='나눔바른고딕')

