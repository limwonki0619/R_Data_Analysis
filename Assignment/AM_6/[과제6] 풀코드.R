# wordcloud 그리기
# 원 그래프 그리기 (top10)
# 막대그래프 (top10)
# ppt로 작성
# 소스코드 / 결과물 

rm(list = ls())

setwd("D:/limworkspace/R_Data_Analysis/Assignment/AM_6")
getwd()

library(tm)
library(stringr)
library(dplyr)
library(ggplot2)
library(RColorBrewer)

# 데이터 전처리 

text <- readLines("data/hiphop.txt"); class(text)
text2 <- str_replace_all(text,"[[:punct:]]","")
corp1 <- Corpus(VectorSource(text2)) 

corp2 <- tm_map(corp1, stripWhitespace)    # 공백제거 
corp2 <- tm_map(corp2, tolower)            # 대문자를 소문자로 변경 
corp2 <- tm_map(corp2, removeNumbers)      # 숫자 제거

## 불용어 처리

gsub_txt <- readLines("gsubfile.txt")
stopwd <- c(stopwords("en"), gsub_txt)
corp2 <- tm_map(corp2, removeWords, stopwd)

tdm <- TermDocumentMatrix(corp2) %>% as.matrix()

hiphop <- head(sort(rowSums(tdm), decreasing = T),30) 

# hiphop 가사 top 10 워드 클라우드 

wordcloud2(as.table(hiphop), size=0.5, col="random-light", backgroundColor="black", fontFamily='나눔바른고딕')

# hiphop 가사 top 10 파이 그래프 그리기

hiphop_top10 <- hiphop %>% head(10) 
df_hiphop_top10 <- as.data.frame(hiphop_top10) %>% 
                   cbind(lyrics=c("like","girl","today","know","wanna","flex","역사","fly","만세","baby"))

colnames(df_hiphop_top10) <- c("Freq","lyrics")

df_hiphop_top10 %>% 
  mutate(pct = round(Freq/sum(Freq)*100,1)) %>%
  mutate(ylabel = paste0(pct,"%")) %>%
  arrange(desc(lyrics)) %>%                     #
  mutate(ypos = cumsum(Freq) - Freq/2) %>%
    ggplot(aes(x="", y=Freq, fill=lyrics)) +
    geom_bar(width=1, stat="identity",color="black") +
    coord_polar("y", start=0) +
      geom_text(aes(y=ypos, label=paste0(Freq,"회")),color='white',family="jalnan") + 
      theme(axis.text.x=element_text(color='black')) +
      theme_bw(base_family = "binggrae", base_size = 10) +
      labs(title="힙합 가사 top 10 빈도 파이차트", x="Freq") +
      theme(plot.title = element_text(family = "jalnan", face = "bold", hjust = 0.5, size = 15, color = "grey20"))


df_hiphop_top10 %>%
  ggplot(aes(x=reorder(lyrics, -Freq), y=Freq, fill=lyrics, horiz=T)) + 
  geom_col() +
  theme_bw() + 
  labs(title="힙합 가사 top 10 막대차트") +
  theme_bw(base_family = "binggrae", base_size = 15) +
  theme(plot.title = element_text(family = "jalnan", face = "bold", hjust = 0.5, size = 15, color = "grey20")) +
  theme(axis.title = element_blank()) +
  theme(legend.position = 'none') +
  geom_text(aes(y=Freq-2, label = paste(Freq,"회")),color="white",family="jalnan")



