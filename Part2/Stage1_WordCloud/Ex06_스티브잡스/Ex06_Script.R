getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage1_WordCloud/Ex06_스티브잡스")
getwd()

# 참고자료 : https://kuduz.tistory.com/1090

#--------------------------------------------------------------#
#--------------------- Part 2 Visualization -------------------#
#------------------- Section 1 : Wordcloud2 -------------------#
#--------------------------------------------------------------#

rm(list = ls())

# tm(text mining) 패키지를 이용한 영문서 분석 

install.packages("tm")
library(tm)
library(wordcloud2)

# 1. 패키지 동작 확인

data1 <- readLines("data/tm_test1.txt"); class(data1)
corp1 <- Corpus(VectorSource(data1)) # 벡터일 경우 VectorS~ 데이터 프레임일 경우 DataS~
                                     # tm패키지가 처리할 수 있는 형태인 Corpus(말뭉치)로 변환  
inspect(corp1)                       # documents 4는 tm패키지가 작업할 수 있는 형태를 의미

tdm <- TermDocumentMatrix(corp1)
m <- as.matrix(tdm)

corp2 <- tm_map(corp1, stripWhitespace)    # 공백제거 
corp2 <- tm_map(corp2, tolower)            # 대문자를 소문자로 변경 
corp2 <- tm_map(corp2, removeNumbers)      # 숫자 제거
corp2 <- tm_map(corp2, removePunctuation)  # 숫자 제거 마침표, 콤마 등의 특수문자 제거

sword2 <- c(stopwords("en"),"and","but","not")
corp2 <- tm_map(corp2, removeWords, sword2)

tdm2 <- TermDocumentMatrix(corp2)

m2 <- as.matrix(tdm2)
colnames(m2) <- 1:length(data1)

freq1 <- sort(rowSums(m2), decreasing = T)
head(freq1, 20)

class(as.table(freq1))
findFreqTerms(tdm2,2) # 특정 횟수 이상 언급된 것들만 출력 

# 테이블 형태로 변경 후 wordcloud2 데이터에 입력
wordcloud2(as.table(freq1), size=0.5, col="random-light", backgroundColor="black", fontFamily='나눔바른고딕',
                        minRotation=0, maxRotation=0)

?wordcloud2
# 스티브 잡스 연결문 분석 --------------------------------------------------
rm(list = ls())

data1 <- readLines("data/steve.txt"); class(data1)
corp1 <- Corpus(VectorSource(data1)) # 벡터일 경우 VectorS~ 데이터 프레임일 경우 DataS~
# tm패키지가 처리할 수 있는 형태인 Corpus(말뭉치)로 변환  
inspect(corp1)                       # documents 4는 tm패키지가 작업할 수 있는 형태를 의미

tdm <- TermDocumentMatrix(corp1)
m <- as.matrix(tdm)

corp2 <- tm_map(corp1, stripWhitespace)    # 공백제거 
corp2 <- tm_map(corp2, tolower)            # 대문자를 소문자로 변경 
corp2 <- tm_map(corp2, removeNumbers)      # 숫자 제거
corp2 <- tm_map(corp2, removePunctuation)  # 숫자 제거 마침표, 콤마 등의 특수문자 제거

sword2 <- c(stopwords("en"),"and","but","not")
corp2 <- tm_map(corp2, removeWords, sword2)

tdm2 <- TermDocumentMatrix(corp2)

m2 <- as.matrix(tdm2)
freq1 <- sort(rowSums(m2), decreasing = T)
freq2 <- freq1[freq1 > 3]


wordcloud2(as.table(freq2), size = 0.5, minSize = 0, gridSize =  -10,
           fontFamily = 'Segoe UI', fontWeight = 'bold',
           color = 'random-light', backgroundColor = "black",
           minRotation = 0, maxRotation = 0, shuffle = FALSE,
           rotateRatio = 100, shape = 'circle', ellipticity = 1,
           widgetsize = NULL, figPath = NULL, hoverFunction = NULL)
