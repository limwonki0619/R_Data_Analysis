setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage4_ChoroplethMap")
getwd()

library(extrafont)
loadfonts() # 설치된 폰트 확인 

windowsFonts(hanna=windowsFont("BM HANNA 11yrs old")) # 폰트이름 변경 
windowsFonts(dohyeon=windowsFont("BM DoHyeon"))
windowsFonts(jalnan=windowsFont("Jalnan"))
windowsFonts(binggrae=windowsFont("Binggrae Taom"))
windowsFonts(nanum=windowsFont("나눔바른고딕"))

rm(list=ls())


# Choropleth Map(단계 구분도 그리기)
# 패키지 
install.packages("ggiraphExtra")
install.packages("mapproj")
install.packages("tibble")
install.packages("maps")
install.packages("mapdata")
install.packages("mapproj")
install.packages("gridExtra") # ggplot2 여러개 그리기 

library(ggiraphExtra)
library(tibble)
library(maps)
library(mapdata)
library(ggplot2)
library(mapproj)
library(gridExtra)  

# 미국 주별 주요 범죄 분포도 --------------------------------------------------------------------

# 데이터 확인 

str(USArrests)
head(USArrests)
summary(USArrests)


# rowname 추출 방법 1
rownames(USArrests) # 행 이름 추출 해보기
USArrests$state <- rownames(USArrests)

# rowname 추출 방법 2
install.packages("tibble")
library(tibble)

crime <- rownames_to_column(USArrests, var = "State")
crime$State <- tolower(crime$State)
# 미국의 주 지도 데이터 

install.packages("maps")
library(maps)
install.packages("mapdata")
library(mapdata)
library(ggplot2)

states_map <- map_data("state")

install.packages("mapproj")
library(mapproj)

ggChoropleth(data = crime, aes(fill=Murder, map_id=State), map=states_map)
ggChoropleth(data = crime, aes(fill=Murder, map_id=State), map=states_map, interactive = T)


install.packages("gridExtra")
library(gridExtra)  

str(crime)

m <- ggChoropleth(data = crime, aes(fill=Murder, map_id=State), map=states_map) +
  labs(title = "미국 주별 살인범죄 분포", subtitle="(단위 : 인구 10만명당 건수)", x="경도", y="위도") + 
  theme_bw(base_family = "nanum", base_size = 14) +
  theme(plot.title = element_text(family="jalnan", face="bold", size=15, hjust=0.5, color="darkblue")) +
  theme(plot.subtitle = element_text(face="bold",size=10, hjust=1))


a <- ggChoropleth(data = crime, aes(fill=Assault, map_id=State), map=states_map) +
  labs(title = "미국 주별 강도범죄 분포", subtitle="(단위 : 인구 10만명당 건수)", x="경도", y="위도") + 
  theme_bw(base_family = "nanum", base_size = 14) +
  theme(plot.title = element_text(family="jalnan", face="bold", size=15, hjust=0.5, color="darkblue")) +
  theme(plot.subtitle = element_text(face="bold",size=10, hjust=1))

r <- ggChoropleth(data = crime, aes(fill=Rape, map_id=State), map=states_map) +
  labs(title = "미국 주별 강간범죄 분포", subtitle="(단위 : 인구 10만명당 건수)", x="경도", y="위도") + 
  theme_bw(base_family = "nanum", base_size = 14) +
  theme(plot.title = element_text(family="jalnan", face="bold", size=15, hjust=0.5, color="darkblue")) +
  theme(plot.subtitle = element_text(face="bold",size=10, hjust=1))

u <- ggChoropleth(data = crime, aes(fill=UrbanPop, map_id=State), map=states_map) +
  labs(title = "미국 주별 도시비율 분포", subtitle="(단위 : 인구 10만명당 건구)", x="경도", y="위도") + 
  theme_bw(base_family = "nanum", base_size = 14) +
  theme(plot.title = element_text(family="jalnan", face="bold", size=15, hjust=0.5, color="darkblue")) +
  theme(plot.subtitle = element_text(face="bold",size=10, hjust=1))

grid.arrange(m,r,a,u,ncol=2)



# 대한민국 시도별 인구 단계 구분도 만들기--------------------------

install.packages("stringi")
install.packages("devtools") # github 자료 받기
library(stringi)
library(devtools)
library(dplyr)

devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)

# 대한민국 시도별 인구 데이터 준비하기 
str(changeCode(korpop1))

korpop1 <- rename(korpop1, 총인구_명 = pop, 행정구역별_읍면동=name) # rename(data, new, old)
korpop1 <- rename(korpop1, a = 남자_명)
korpop1 <- rename(korpop1, b = 여자_명)

str(changeCode(korpop1))
str(changeCode(korpop2))

korpop2
# 단계 구분도 만들기
library(ggplot2)
library(ggiraphExtra)
library(mapproj)

ggChoropleth(data = korpop1, 
             aes(fill = pop, 
                 map_id=code,
                 tooltip = name),
                 map = kormap1, interactive = T)

ggChoropleth(data = korpop2, # 
             aes(fill = 총인구_명, 
                 map_id=code,
                 tooltip = name,
                 label=행정구역별_읍면동), 
                 map = kormap2, interactive = T)

# 대한민국 시도별 결핵 환자 수 단계 구분도 만들기

str(changeCode(tbc))

ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name),
             map = kormap1, interactive = T)

