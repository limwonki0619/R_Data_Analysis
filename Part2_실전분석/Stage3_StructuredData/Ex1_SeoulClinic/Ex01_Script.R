getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage3_StructuredData/Ex01_SeoulClinic")
getwd()

library(extrafont)

font_import(pattern = 'Jalnan') #폰트설치 
y
loadfonts() # 설치된 폰트 확인 


# 테스트 ------------------------------------------------------------

windowsFonts(hanna=windowsFont("BM HANNA 11yrs old")) # 폰트이름 변경 
windowsFonts(dohyeon=windowsFont("BM DoHyeon"))
windowsFonts(jalnan=windowsFont("Jalnan"))
windowsFonts(tb=windowsFont("TmonMonsori Black"))
windowsFonts(binggrae=windowsFont("Binggrae Taom"))
windowsFonts(nbg=windowsFont("나눔바른고딕"))

#--------------------------------------------------------------#
#------------------------ Structured Data ---------------------#
#--------------------------------------------------------------#

library(ggplot2)
library(dplyr)
library(reshape2)

# 인터랙티브 그래프 - plotly, ggplotly() ----------------------------------------------------

install.packages("plotly")
library(plotly)

data1 <- read.csv("data/2013년_서울_주요구별_병원현황.csv"); head(data1); class(data1)
data2 <- melt(data1,id=c("표시과목"),variable.name = "지역구", value.name = "병원수") # 변수이름 설정 

str(data12)

g1 <- data2 %>% 
  ggplot(aes(x=표시과목,y=병원수,fill=표시과목)) +
  geom_bar(stat="identity") +
  facet_wrap(~지역구) +
  theme_bw(base_family = "jalnan") +
  theme(legend.position = "none") +
  labs(title="2013년 서울 지역구별 병원 현황") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 0.5 ))   # x축 라벨을 옆으로 눕힙니다.

ggplotly(g1)

# 막대차트 = fill

g2 <- data2 %>% 
  ggplot(aes(x=지역구,y=병원수,fill=표시과목)) +
    geom_bar(stat = "identity", position = "fill", color="black") + # 막대 설정 옵션 
      theme_bw(base_family = "jalnan") + # 기본 폰트 
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +   # x축 라벨을 옆으로 눕힙니다.
      theme(axis.title.x = element_blank()) + # 축 라벨 삭제 (x,y 따로도 가능)
      labs(title="2013년 서울 지역구별 병원 현황") + # 타이틀 설정
      theme(plot.title = element_text(family = "jalnan", face = "bold", hjust = 0.5, size = 15, color = "grey20"))

ggplotly(g2)

# 막대차트 - dodge

g3 <- data2 %>% 
  ggplot(aes(x=지역구,y=병원수,fill=표시과목)) +
  geom_bar(stat = "identity", position = "dodge", color="black") + # 막대 설정 옵션 
  theme_bw(base_family = "jalnan", base_size = 13) + # 기본 폰트 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +   # angle 기울기, h 수평, v 수직
  theme(axis.title.x = element_blank()) + # 축 라벨 삭제 (x,y 따로도 가능)
  labs(title="2013년 서울 지역구별 병원 현황") + # 타이틀 설정
  theme(plot.title = element_text(family = "jalnan", face = "bold", hjust = 0.5, size = 15, color = "grey20"))

ggplotly(g3)

