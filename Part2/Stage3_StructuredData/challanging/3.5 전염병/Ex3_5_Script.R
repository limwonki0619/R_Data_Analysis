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
     theme_bw(base_family = "jalnan", base_size = 18) +
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
              theme_bw(base_family = "jalnan", base_size = 18) +
              labs(title = "1군 전염병 발병현황 + 월별(단위:건수) 출처:통계청") + 
              theme(plot.title = element_text(family = "jalnan", face="bold", hjust=0.5, size=15, color="grey20"),
                     axis.title = element_blank())

# 결과 3. 월별 발병 현황 (A형 간엽 제외)

data3 <- select(data2, -A형간염)
data3$월별 <- factor(data3$월별, levels=unique(data3$월별)) # 월별 순서 지정\

data3 %>% 
  melt(id=c("월별"), variable.name = "전염병", value.name = "발병현황") %>%
    ggplot(aes(x=월별, y=발병현황, group=전염병, color=전염병)) +
    geom_line(linetype=2) +
    geom_point(size=3) + 
    geom_hline(yintercept = seq(200,800,200), color="grey20", linetype=3) +
     theme_bw(base_family = "jalnan", base_size = 18) +
     labs(title = paste0("1군 전염병 발병현황(A형간염 제외)","\n","월별(단위:건수)  출처:통계청")) + 
     theme(plot.title = element_text(family = "jalnan", face="bold", hjust=0.5, size=15, color="grey20"),
           axis.title = element_blank())
