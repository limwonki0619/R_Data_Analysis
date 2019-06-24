getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage3_StructuredData/Ex03_4 Insurance")
getwd()

library(extrafont)

loadfonts() # 설치된 폰트 확인 


# 테스트 -------------------------------------------------------------------------------------------

windowsFonts(hanna=windowsFont("BM HANNA 11yrs old")) # 폰트이름 변경 
windowsFonts(dohyeon=windowsFont("BM DoHyeon"))
windowsFonts(jalnan=windowsFont("Jalnan"))
windowsFonts(binggrae=windowsFont("Binggrae Taom"))

# 년도별 기관별 보험청구 건수 분석 후 그래프로 보여주기 p159 ---------------------------------------
rm(list = ls())

count <- read.csv("data/연도별요양기관별보험청구건수_2001_2013_세로.csv")
year <- count$년도

count2 <- count[,2:11]/100000
count3 <- cbind(count2, year)

plot(count3[,1], xlab="", ylab="", ylim=c(0,6000), axes=FALSE, col="violet", type="o", lwd=2)
axis(1, at = 1:10, labels = year, las=2) # 1 : x축 las 라벨 방향
axis(2, las=1) # 2 : y축 

library(ggplot2)
library(reshape2)

meltdata <- melt(count,id=c("년도"), variable.name = "병원종류", value.name = "보험건수")

meltdata %>%
  ggplot(aes(x=년도,y=보험건수/100000,fill=병원종류)) +
    geom_bar(stat = "identity",position = "dodge") + 
    facet_wrap(~병원종류) +
    theme_bw(base_family = "dohyeon") +
    theme(axis.text.x = element_text(angle=45, vjust = 0.5)) +
    labs(title="2003~2014 연도별 요양기관별 보험청구건수", y="보험건수") + # 타이틀 및 축 타이틀 변경 
    theme(plot.title = element_text(family = "jalnan", face = "bold", hjust = 0.5, size = 15, color = "grey20"))


meltdata %>% 
  ggplot(aes(x=년도,y=보험건수/100000,color=병원종류)) +
   geom_line(lwd=1.2) +
   geom_point(size=3) +
   theme_bw(base_family = "dohyeon") +
   labs(title="2003~2014 연도별 요양기관별 보험청구건수", y="보험건수") + # 축 타이틀 변경 
   theme(plot.title = element_text(family = "jalnan", face = "bold", hjust = 0.5, size = 15, color = "grey20"))
