setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage3_StructuredData/challanging/3.1 baseball")
getwd()

library(extrafont)

loadfonts() # 설치된 폰트 확인 

windowsFonts(hanna=windowsFont("BM HANNA 11yrs old")) # 폰트이름 변경 
windowsFonts(dohyeon=windowsFont("BM DoHyeon"))
windowsFonts(jalnan=windowsFont("Jalnan"))
windowsFonts(binggrae=windowsFont("Binggrae Taom"))

# --------------------------------------------------------

pro <- read.csv("data/야구성적.csv")

library(dplyr)
library(ggplot2)
library(reshape2)

# 도전미션 3-1 프로야구 선수들이 밥값을 하나요? 

# 프로야구선수 밥값은 하고 있나?
pro %>% 
  mutate(OPS = 장타율+출루율) %>%
  mutate(연봉대비OPS = round(OPS/연봉,1)) %>% 
    ggplot(aes(x=선수명,y=연봉대비OPS,fill=선수명)) +
    geom_bar(stat="identity", color="black") +
    geom_hline(yintercept = 0.1, linetype=2, color="black", lwd=1) + # 수평선 긋기
    geom_text(aes(x=선수명,y=연봉대비OPS+0.03, label=paste0(연봉대비OPS,"%")), size = 5) +
      theme_bw(base_family = "hanna", base_size = 20) +
      theme(axis.text.x = element_text(angle=45, vjust=0.5)) +
      theme(axis.title.x = element_blank()) +
      theme(legend.position = "none") +
      labs(title = "프로야구선수 밥값은 하고 있나?") +
      theme(plot.title = element_text(family = "jalnan",face="bold",hjust=0.5,size = 15, color = "grey20"))

# 2013년 프로야구 선수별 주요 성적

pro %>%
  select(선수명,안타,득점,출루율,타율,도루,볼넷,타점,홈런) %>% 
  melt(id=c("선수명"), variable.name = "능력지표", value.name = "능력치") %>%
    ggplot(aes(x=능력지표,y=능력치,fill=능력지표)) + 
    geom_bar(width=1,stat="identity", color="black") +
    coord_polar() +
    facet_wrap(~선수명) +
    theme_bw(base_family = "jalnan", base_size = 14) +
    labs(title = "2013년 프로야구 선수별 주요 성적 ") + 
    theme(plot.title = element_text(family = "jalnan", face="bold", hjust=0.5, size=15, color="grey20")) +
    theme(axis.text.y = element_blank()) +
    theme(axis.title = element_blank()) 

# 2013년 프로야구 선수별 연봉대비 출루율 및 타점율 
str(pro)

pro %>% 
  mutate(연봉대비출루율 = 출루율/연봉*100) %>%
  mutate(연봉대비타점율 = (타점/안타)/연봉*100) %>% 
  select(선수명, 연봉대비출루율, 연봉대비타점율) %>%
  melt(id=c("선수명"), variable.name ="지표", value.name ="능력치" ) %>%
    ggplot(aes(x=선수명,y=능력치, group=지표, color=지표)) +
      geom_segment(aes(x=선수명,xend=선수명,y=0,yend=능력치), color="grey50") +
      geom_point(size=2) + 
      geom_text(aes(x=선수명,y=능력치+1.5,label=round(능력치,1),family="dohyeon")) +
      facet_wrap(~지표) +
        theme_bw(base_family = "jalnan", base_size = 18) +
        theme(axis.text.y = element_blank(),
              axis.text.x = element_text(angle = 45, vjust = 0.5, size=8),
              axis.title = element_blank(), 
              legend.position = "none")



      
      