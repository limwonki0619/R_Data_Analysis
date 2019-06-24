getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage3_StructuredData/Ex3_4 Insurance")
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

price <- read.csv("data/연도별요양기관별보험청구금액_2004_2013_세로.csv")

melt_price <- melt(count,id=c("년도"), variable.name = "병원종류", value.name = "금액")

melt_price$금액 <- melt_price$금액/100000

melt_price %>% 
  ggplot(aes(x=년도,y=금액,color=병원종류)) +
    geom_line() + 
    geom_point(size=2) + 
      theme_bw(base_family = "dohyeon") +
      theme(axis.text.x = element_text(angle=45, vjust = 0.5)) +
      labs(title="2003~2014 연도별 요양기관별 보험청구금액", y="보험건수") + # 타이틀 및 축 타이틀 변경 
     theme(plot.title = element_text(family = "jalnan", face = "bold", hjust = 0.5, size = 15, color = "grey20"))

