getwd()
setwd("D:/limworkspace/R_lecture/Part2/Stage1_WordCloud/Ex01_서울시 응답소")
setwd("D:/limworkspace/R_lecture/Part2/Stage1_WordCloud/Ex01_서울시 응답소/data")
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
install.packages("wordcloud2")
library(wordcloud2)

# --------------------------------------------------------------------------------------------------

useSejongDic() # 세종사전 호출 
mergeUserDic(data.frame("사용자 임의 설정 단어", "ncn")) # 사용자가 임의로 설정한 단어를 사전에 추가 





















