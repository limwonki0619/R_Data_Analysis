getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage1_WordCloud/Ex03_제주")
getwd()

#--------------------------------------------------------------#
#--------------------- Part 2 Visualization -------------------#
#------------------- Section 1 : Wordcloud2 -------------------#
#--------------------------------------------------------------#

# 참고자료 : https://kuduz.tistory.com/1090
#            https://junhewk.github.io/text/2017/06/18/single-word-analysis-korean-poem/
# tidyverse 패키지는 아직 한글을 지원하지 않는것으로 보임.. 다만 영문을 분석할 때는 유용한 툴
# 쓰고자 할때는 구글 번역 api를 통해 한글을 번역

install.packages("rJava")
library(rJava)
install.packages("KoNLP")
library(KoNLP)
install.packages("wordcloud2")
library(wordcloud2)

###
rm(list = ls())
###-----------------------------------------------------

useSejongDic() # 세종사전 호출 
mergeUserDic(data.frame(readLines("data/제주도여행지.txt"), "ncn"))                      # 사용자가 원하는 단어를 추가 *** 중요
                                                                                    # buidDictionary() 곧 이 함수를 사용해야함
# stringr 패키지를 이용한 전처리 -----------------------

library(stringr)

txt <- readLines("data/jeju.txt"); head(txt,3)           # 텍스트파일을 벡터형태로 받음
place <- sapply(txt, extractNoun, USE.NAMES = F)      # extracNoun은 한글 문장에서 명사만 출력 | USE.NAME 옵션은 벡터의 원래 이름을 나타낸다
cdata <- unlist(place); head(place,20)  

# 정규표현식 참고자료 : https://m.blog.naver.com/PostView.nhn?blogId=easternsun&logNo=220201798414&proxyReferer=https%3A%2F%2Fwww.google.com%2F

place <- str_replace_all(cdata,"[^[:alpha:]]","")     # 한글, 영어 외에는 삭제  
place <- gsub(" ","", place)


gsub_txt <- readLines("제주도여행코스gsub.txt")
for (i in 1:length(gsub_txt)) {
  place <- gsub((gsub_txt[i]),"",place)
}

place <- Filter(function(x){nchar(x) >= 2}, place)

wordcount <- head(sort(table(place), decreasing = T),50)

wordcloud2(wordcount, size=0.5, col="random-light", backgroundColor="black", fontFamily='나눔바른고딕')

