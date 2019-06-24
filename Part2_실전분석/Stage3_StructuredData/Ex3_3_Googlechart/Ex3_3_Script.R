setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage3_StructuredData/Ex3_3_Googlechart")
getwd()

data <- read.csv("data/2013년_서울_구별_주요과목별병원현황_구글용.csv")

install.packages("googleVis")
library(googleVis)

hos <- gvisColumnChart(data, options = list(title="지역별 병원현황",height=400,weight=500))

header <- hos$html$header
hos$html$header  <- gsub('charset=utf-8','charset=euc-kr',header)

plot(hos)
