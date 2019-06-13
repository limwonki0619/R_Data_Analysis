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

# 프로야구 선수 분석 ---------------------------------------------------------- 

# 프로야구선수 밥값은 하고 있나?
pro %>% 
  mutate(OPS = 장타율+출루율) %>%
  mutate(연봉대비OPS = round(OPS/연봉,1)) %>% 
  ggplot(aes(x=선수명,y=연봉대비OPS,fill=선수명)) +
  geom_bar(stat="identity", color="black") +
  geom_hline(yintercept = 0.1, linetype=2, color="black", lwd=1) + # 수평선 긋기
  geom_text(aes(x=선수명,y=연봉대비OPS+0.03, label=paste0(연봉대비OPS,"%")), size = 3) +
  theme_bw(base_family = "hanna", base_size = 10) +
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
  theme_bw(base_family = "jalnan", base_size = 10) +
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
  geom_text(aes(x=선수명,y=능력치+1.5,label=round(능력치,1),family="dohyeon"), size=3) +
  facet_wrap(~지표) +
  theme_bw(base_family = "jalnan", base_size = 5) +
  theme(axis.text.y = element_blank(),
        axis.text.x = element_text(angle = 45, vjust = 0.5, size=8),
        axis.title = element_blank(), 
        legend.position = "none")




# 전염병 발병현황 -----------------------------------------------------------------------


setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage3_StructuredData/challanging/3.5 전염병")
getwd()

library(extrafont)

windowsFonts(hanna=windowsFont("BM HANNA 11yrs old")) # 폰트이름 변경 
windowsFonts(dohyeon=windowsFont("BM DoHyeon"))
windowsFonts(jalnan=windowsFont("Jalnan"))
windowsFonts(binggrae=windowsFont("Binggrae Taom"))

data <- read.csv("data/1군전염병발병현황_년도별.csv")

library(dplyr)
library(ggplot2)
library(reshape2)

# 결과 1. 년도별 발병 현황

data %>%
  melt(id=c("년도별"), variable.name = "전염병", value.name = "발병현황") %>%
  ggplot(aes(x=년도별, y=발병현황, group=전염병, color=전염병)) +
  geom_line(linetype=2) +
  geom_point(size=4) +
  geom_hline(yintercept = seq(0,6000,2000), color="grey20", linetype=4) +
  theme_bw(base_family = "jalnan", base_size = 14) +
  labs(title = "1군 전염병 발병현황 + 년도별(단위:건수) 출처:통계청") + 
  theme(plot.title = element_text(family = "jalnan", face="bold", hjust=0.5, size=15, color="grey20"),
        axis.title = element_blank(),
        axis.text.x = element_text(angle = 45, vjust=0.5))

# 결과 2. 월별 발병 현황 

data2 <- read.csv("data/1군전염병발병현황_월별.csv")
data2$월별 <- factor(data2$월별, levels=unique(data2$월별)) # 월별 순서 지정

data2 %>% melt(id=c("월별"), variable.name = "전염병", value.name = "발병현황") %>%
  ggplot(aes(x=월별, y=발병현황, group=전염병, color=전염병)) +
  geom_line(linetype=2) +
  geom_point(size=3) + 
  geom_hline(yintercept = seq(200,800,200), color="grey20", linetype=3) +
  theme_bw(base_family = "jalnan", base_size = 14) +
  labs(title = "1군 전염병 발병현황 + 월별(단위:건수) 출처:통계청") + 
  theme(plot.title = element_text(family = "jalnan", face="bold", hjust=0.5, size=15, color="grey20"),
        axis.title = element_blank())

# 결과 3. 월별 발병 현황 (A형 간엽 제외)

data3 <- select(data2, -A형간염)
data3$월별 <- factor(data3$월별, levels=unique(data3$월별)) # 월별 순서 지정

data3 %>% 
  melt(id=c("월별"), variable.name = "전염병", value.name = "발병현황") %>%
  ggplot(aes(x=월별, y=발병현황, group=전염병, color=전염병)) +
  geom_line(linetype=2) +
  geom_point(size=3) + 
  geom_hline(yintercept = seq(200,800,200), color="grey20", linetype=3) +
  theme_bw(base_family = "jalnan", base_size = 14) +
  labs(title = paste0("1군 전염병 발병현황(A형간염 제외)","\n","월별(단위:건수)  출처:통계청")) + 
  theme(plot.title = element_text(family = "jalnan", face="bold", hjust=0.5, size=15, color="grey20"),
        axis.title = element_blank())





# 3.7 마포 마을버스 이용 현황 분석 -------------------------------------------------------------

setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage3_StructuredData/challanging/3.7 마포")
getwd()

library(extrafont)

windowsFonts(hanna=windowsFont("BM HANNA 11yrs old")) # 폰트이름 변경 
windowsFonts(dohyeon=windowsFont("BM DoHyeon"))
windowsFonts(jalnan=windowsFont("Jalnan"))
windowsFonts(binggrae=windowsFont("Binggrae Taom"))

library(reshape2)

mapo <- read.csv("data/마포09번이용현황.csv")
mapo$정류소명 <- paste0(1:length(mapo$정류소명),". ",mapo$정류소명)
mapo$정류소명 <- factor(mapo$정류소명, levels=unique(mapo$정류소명)) # 버스정류장 순서정하기 

mapo %>% 
  melt(id=c("정류소명"),variable.name = "승ㆍ하차인원") %>% 
  ggplot(aes(x=정류소명, y=value/10000,fill=승ㆍ하차인원)) +
  geom_bar(stat="identity", position = "stack") +
  geom_hline(yintercept = seq(0,8,2), linetype=2,color="grey10") +
  theme_bw(base_family = "jalnan", base_size = 10) +
  labs(title = "마포09번 마을버스 이용 현황 분석", y="승ㆍ하차인원(만 명)") + 
  theme(plot.title = element_text(family = "jalnan", face="bold", hjust=0.5, size=15, color="grey20"),
        axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 90),
        legend.position = "top")


