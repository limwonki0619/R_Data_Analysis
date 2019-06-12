getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage2_Graphics/Ex01_제주코스 그래프")
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
library(stringr)
library(RColorBrewer)
###
rm(list = ls())
###-----------------------------------------------------

useSejongDic() # 세종사전 호출 
mergeUserDic(data.frame(readLines("data/제주도여행지.txt"), "ncn"))  # 사용자가 원하는 단어를 추가 *** 중요
# buidDictionary() 곧 이 함수를 사용해야함
# stringr 패키지를 이용한 전처리 -----------------------

library(stringr)

txt <- readLines("data/jeju.txt"); head(txt,3)                       # 텍스트파일을 벡터형태로 받음
place <- sapply(txt, extractNoun, USE.NAMES = F)                     # extracNoun은 한글 문장에서 명사만 출력 | USE.NAME 옵션은 벡터의 원래 이름을 나타낸다
cdata <- unlist(place); head(place,20)  

# 정규표현식 참고자료 : https://m.blog.naver.com/PostView.nhn?blogId=easternsun&logNo=220201798414&proxyReferer=https%3A%2F%2Fwww.google.com%2F

place <- str_replace_all(cdata,"[^[:alpha:]]","")                    # 한글, 영어 외에는 삭제  
place <- gsub(" ","", place)


gsub_txt <- readLines("data/제주도여행코스gsub.txt")
for (i in 1:length(gsub_txt)) {
  place <- gsub((gsub_txt[i]),"",place)
}

place <- Filter(function(x){nchar(x) >= 2}, place); class(place)

top10_wordcount <- head(sort(table(place), decreasing = T),10)

wordcloud2(top10_wordcount, size=0.5, col="random-light", backgroundColor="black", fontFamily='나눔바른고딕',
           minRotation=0, maxRotation=0)

# 다양한 그래프 그리기 -------------------------------------------------------------------------------

pie(top10_wordcount, col=rainbow(10),
    main = "제주도 추천 여행 코스 TOP 20")

pct <- round(top10_wordcount/sum(top10_wordcount)*100,1)             # 수치값을 함께 출력하기
lab <- paste0(names(top10_wordcount),"\n", pct, "%")

pie(top10_wordcount, col=brewer.pal(10,"RdGy"), labels = lab, cex=0.8,
    main = "제주도 추천 여행 코스 TOP 20")

# ggplot으로 pie 차트 그리기 

library(ggplot2)
library(dplyr)

df_top10 <- as.data.frame(top10_wordcount)
df_top10 %>% 
  ggplot(aes(x='', y=Freq, fill=place)) +
    geom_bar(width=1,stat="identity") +
    theme_bw() +
    coord_polar("y", start = 0)
              

df_top10 %>% 
  mutate(pct = round(Freq/sum(Freq)*100,1)) %>%
  mutate(ylabel = paste0(place,"\n",pct,"%")) %>%
  arrange(desc(place)) %>%                  # 레이블의 위치를 설정하기 위해 순서 변경
  mutate(ypos = cumsum(pct)-0.5*pct) %>%
  ggplot(aes(x='', y=Freq, fill=place)) +
  geom_bar(width=1, stat="identity") +
  geom_text(aes(y=ypos, label=ylabel),color='black') +
  coord_polar("y", start=pi/3) 

ggplot(성적, col=rainbow(10), aes(fill=성적$성명, ymax=성적$국어최고, 
                                ymin=성적$국어최소, xmax=10, xmin=0)) + 
  geom_rect() + 
  coord_polar(theta="y") +
  xlim(c(0, 10)) + 
  labs(title="도넛 차트")

# 기본 바 차트 그리기 -------------------------------------------------------------------------

pct <- round(top10_wordcount/sum(top10_wordcount)*100,1)

bp <- barplot(top10_wordcount, col=rainbow(10), cex.names = 0.7, las=2,ylim = c(0,25))          # las : 축 라벨 각도조절
text(x=bp, y=top10_wordcount*1.05, labels = paste0("(",pct,"%",")"), col="black", cex=0.7)
text(x=bp, y=top10_wordcount*0.9, labels = paste0(top10_wordcount,"건"), col="black", cex=0.7)



# 기본 바 세워서 그리기 -------------------------------------------------------------------------

bp <- barplot(top10_wordcount, col=rainbow(10), cex.names = 0.7, las=1,xlim = c(0,25), horiz = T) # 눞힐 때 xlim, ylim 구분 
text(x=top10_wordcount*0.9, y=bp, labels = paste0("(",pct,"%",")"), col="black", cex=0.7)
text(x=top10_wordcount*1.1, y=bp, labels = paste0(top10_wordcount,"건"), col="black", cex=0.7)

# 3d 파이차트 p140 ------------------------------------------------------------------------------



