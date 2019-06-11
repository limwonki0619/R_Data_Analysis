getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage1_WordCloud/Ex01_서울시 응답소")
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage1_WordCloud/Ex01_서울시 응답소/data")
getwd()

#--------------------------------------------------------------#
#--------------------- Part 2 Visualization -------------------#
#------------------- Section 1 : Wordcloud2 -------------------#
#--------------------------------------------------------------#

# 1. 비정형 데이터를 분석 후 워드클라우드 생성하기

install.packages("rJava")
library(rJava)
install.packages("KoNLP")
library(KoNLP)
install.packages("wordcloud")
library(wordcloud)
install.packages("wordcloud2")
library(wordcloud2)

# --------------------------------------------------------------------------------------------------

useSejongDic() # 세종사전 호출 
mergeUserDic(data.frame("사용자 임의 설정 단어", "ncn"))                        # 사용자가 임의로 설정한 단어를 사전에 추가 
mergeUserDic(data.frame(readLines("추가단어.txt"),"ncn"))                      # 추가단어가 많을 때는 따로 파일을 만들어서 실행 

data1 <- readLines("seoul_new.txt"); head(data1,3); class(data1)                # 텍스트파일을 벡터형태로 받음
data2 <- sapply(data1, extractNoun, USE.NAMES = F); head(data2,3); class(data2) # extracNoun은 한글 문장에서 명사만 출력 | USE.NAME 옵션은 벡터의 원래 이름을 나타낸다
#test  <- lapply(data1, extractNoun); head(test,3); class(test)                 # sapply : input - vector | output - vector
                                                                                # lapply : input - vector | output - list // 여기서 결과는 같지만 USE.NAME 옵션을 사용할 수 없다.
                                                                                # unlist : list 형태의 입력값을 vector 형태로 쪼개기
data3 <- unlist(data2); head(data3,20); class(data3)                                                                                 

data3 <- gsub("\\d+", "", data3); data3                                         # gsub("변경 전","변경 후",데이터) : 불필요한 문자 찾아 바꾸기 | 정규표현식 사용 
data3 <- gsub("서울시", "", data3); data3                                       # 의미없는 데이터도 삭제
data3 <- gsub("서울", "", data3); data3
data3 <- gsub("요청", "", data3); data3
data3 <- gsub("제안", "", data3); data3
data3 <- gsub("시장", "", data3); data3
data3 <- gsub("님"  , "", data3); data3
data3 <- gsub("00"  , "", data3); data3
data3 <- gsub("-"   , "", data3); data3
data3 <- gsub("OO"  , "", data3); data3
data3 <- gsub("개선", "", data3); data3
data3 <- gsub("문제", "", data3); data3
data3 <- gsub("관리", "", data3); data3
data3 <- gsub("민원", "", data3); data3
data3 <- gsub("이용", "", data3); data3
data3 <- gsub("관련", "", data3); data3
data3 <- gsub("시장", "", data3); data3
data3 <- gsub("O",    "", data3); data3
data3 <- gsub(" ",    "", data3); data3

data4 <- Filter(function(x) { nchar(x) >= 2 & nchar(x) <= 7 }, data3)           # 문자열 필터링 

# 프로그래밍으로 불필요한 문자 제거하기 ------------------------------------------------------------------

gsub_txt <- readLines("gsubfile.txt", encoding = "UTF-8")                       # 가끔 텍스트 파일이 인코딩이 안될 경우도 있음 
for (i in 1:length(gsub_txt)) {
  data3 <- gsub((gsub_txt[i]), "", data3)
}

# --------------------------------------------------------------------------------------------------------

write(data4, "seoul_2.txt")
data5 <- read.table("seoul_2.txt"); data5; class(data5)



wordcount <- table(data5) 
wordcount2 <- head(sort(wordcount, decreasing = T),50)


#wordcloud(names(wordcount), freq = wordcount, scale = c(3,1), rot.per = 0.25, min.freq = 3,random.order=F, random.color=T, colors=palete)
#legend("top","서울시 응답소 요청사항 분석", cex=0.8, fill=NA, border=NA, bg="black",text.col="white")                # WC2에서는 안먹힘


set.seed(1234) # 프로그램 재현성 

wordcloud2(wordcount2, size=0.5, col="random-light", backgroundColor="black", fontFamily='나눔바른고딕')
# letterCloud(wordcount2, word="R") # 원하는 모양으로 만들기 다만, 버전이 안맞는 듯





# 코딩 단순화 해보기 -------------------------------------------------------------------------------------------------------------------------

#test1 <- Filter(function(x) { nchar(x) >= 1 }, data4); data4                   # 공란으로 변경된 문자들에서 크기가 1이상인 문자만 추출 
#test2 <- table(test1); test2                                                   # 텍스트 파일 저장 없이 하는방법








