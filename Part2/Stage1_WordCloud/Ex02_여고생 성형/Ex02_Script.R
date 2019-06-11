getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage1_WordCloud/Ex02_여고생 성형")
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage1_WordCloud/Ex02_여고생 성형/data")
getwd()

#--------------------------------------------------------------#
#--------------------- Part 2 Visualization -------------------#
#------------------- Section 1 : Wordcloud2 -------------------#
#--------------------------------------------------------------#

install.packages("rJava")
library(rJava)
install.packages("KoNLP")
library(KoNLP)
install.packages("wordcloud")
library(wordcloud)
install.packages("wordcloud2")
library(wordcloud2)

useSejongDic() # 세종사전 호출 
mergeUserDic(data.frame("사용자 임의 설정 단어", "ncn"))                        # 사용자가 임의로 설정한 단어를 사전에 추가 
mergeUserDic(data.frame(readLines("추가단어.txt", "ncn")))                      # 추가단어가 많을 때는 따로 파일을 만들어서 실행 


###
rm(list = ls())

###-----------------------------------------------------

data1 <- readLines("remake.txt"); head(data1,3)       # 텍스트파일을 벡터형태로 받음
data2 <- sapply(data1, extractNoun, USE.NAMES = F)    # extracNoun은 한글 문장에서 명사만 출력 | USE.NAME 옵션은 벡터의 원래 이름을 나타낸다
data3 <- unlist(data2); head(data3,20)                                                                                 

data3 <- gsub("\\d+", "", data3); data3               # 모든 숫자 없애기 
data3 <- gsub("쌍수", "쌍꺼풀", data3); data3   
data3 <- gsub("쌍커풀", "", data3); data3   
data3 <- gsub("메부리코", "매부리코", data3); data3
data3 <- gsub("코을", "코끝", data3); data3 
data3 <- gsub("\\.", "", data3); data3   
data3 <- gsub(" ", "", data3); data3   
data3 <- gsub("\\", "", data3); data3                # gsub("변경 전","변경 후",데이터) : 불필요한 문자 찾아 바꾸기 | 정규표현식 사용 
data3 <- gsub("하이닥-네이버", "", data3); data3 

gsub_txt <- readLines("gsubfile.txt", encoding = "UTF-8")                       # 가끔 텍스트 파일이 인코딩이 안될 경우도 있음 
for (i in 1:length(gsub_txt)) {
  data3 <- gsub((gsub_txt[i]), "", data3)
}

data4 <- Filter(function(x) { nchar(x) >= 2 & nchar(x) <= 7 }, data3) 

wordcount <- head(sort(table(data4), decreasing = T),15)

library(wordcloud2)
wordcloud2(wordcount, size=0.5, col="random-light", backgroundColor="black", fontFamily='나눔바른고딕')


