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
      theme_bw(base_family = "jalnan", base_size = 20) +
      labs(title = "마포09번 마을버스 이용 현황 분석", y="승ㆍ하차인원(만 명)") + 
      theme(plot.title = element_text(family = "jalnan", face="bold", hjust=0.5, size=15, color="grey20"),
        axis.title.x = element_blank(),
        axis.text.x = element_text(angle = 90),
        legend.position = "top")

  