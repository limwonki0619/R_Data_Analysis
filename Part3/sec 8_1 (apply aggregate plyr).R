getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")
setwd("D:/limworkspace/R_lecture/Part3")
getwd()

#--------------------------------------------------------------#
#--------- section 8 : 데이터를 다루는 다양한 함수 ------------#
#--------------------------------------------------------------#

# 8.1 많이 사용되는 기본 함수들 ------------------------------------------------------------------------------------------

# 8.1.1 기본 함수들 ------------------------------------------------------------------------------------------------------
# ??(함수명) : 함수의 문법이나 옵션이 궁금할 때 찾아보는 방법 

vec1 <- c(1:5); vec1                        
vec2 <- c('a','b','c'); vec2
max(vec1)                      
max(vec2)                                     # 문자에 적용할 때는 '알파벳 순서'
mean(vec1)                     
mean(vec2)                                    # 문자의 평균은 말이 안됨                     
min(vec1)                        
median(vec1)                       
sum(vec1)                
var(vec1)                                     # 표본분산 : 제곱합 / n-1 
sd(vec1)                          

# 8.1.2 aggregate (함계, 총계) 함수 *** -----------------------------------------------------------------------------------
install.packages("googleVis")
library(googleVis)

# aggregate( 계산이 될 열 ~ 기준이 될 열 , 데이터, 함수 )
str(Fruits)
Fruits$Date <- seq(as.Date("2010-01-01"),as.Date("2018-01-01"),by='year'); Fruits$Date

aggregate(Sales ~ Year, Fruits, sum)           # Fruits 데이터의 연도[기준]별 총[함수] 판매량[계산]
aggregate(Profit ~ Year, Fruits, mean)        
aggregate(Sales ~ Fruit+Location, Fruits, max) # 추가조건은 +를 사용


Fruits2 <- Fruits[which(Fruits$Date >= '2011-01-01' & Fruits$Date <= '2014-01-01'),]
aggregate(Sales ~ Location, Fruits2, sum)
aggregate(Sales ~ Location, subset(Fruits, Date >= '2011-01-01' & Date <= '2014-01-01'), sum)

Fruits[4:5,3] <- "West"
Fruits[3,3] <-"East"

aggregate(Sales ~ Location+Fruit, Fruits, sum)
class(Fruits$Date)

attach(Fruits)
tapply(Sales,subset(Date>='2011-01-01'),sum)  # tapply는 subset 불가
detach(Fruits)

# 8.1.3 apply 함수 - Matrix 상대하기---------------------------------------------------------------------------------------

mat1 <- matrix(c(1:6), nrow = 2, byrow = T); mat1

apply(mat1, 1, sum)                            # 욥션 1 - 행 단위 계산
apply(mat1, 2, sum)                            # 옵션 2 - 열 단위 계산 
apply(mat1, 1, prod)                           # 행 단위 곱셈 
apply(mat1[,c(2,3)],1 ,sum)                    # 범위 단위로 계산이 가능 

# 8.1.4 lapply 함수, sapply 함수---------------------------------------------------------------------------------------

# lapply : list 형태에서 적용할 수 있는 apply 계열 함수 
# sapply : list 형태를 vector 형태로 출력해 주는 apply 계열의 함수 

list1 <- list(Fruits$Sales); list1
list2 <- list(Fruits$Profit); list2

lapply(c(list1,list2), max)                    # list 형태에 적용 
sapply(c(list1,list2), max)                    # list -> Vector

lapply(c(Fruits[,c(4,5)]),max)                 # list 형태 그대로 출력 
sapply(c(Fruits[,c(4,5)]),max)                 # vector 형태로 출력

# 8.1.5 tapply 함수, mapply 함수---------------------------------------------------------------------------------------

# tapply : Factor 형태의 데이터를 처리하는 apply 계열의 함수 

attach(Fruits)                                 # tapply를 사용하기 전 attach 명령이 반드시 필요함 
tapply(Sales, Fruit, sum)                      # attach 함수로 dataset에 접근 
tapply(Sales, Year, sum)

# mapply : Vector나 list  형태로 데이터들이 있을 때 data frame 처럼 연산을 해주는 함수

vec1 <- c(1:5)
vec2 <- seq(10,50, by=10); vec2
vec3 <- seq(100,500, by= 100); vec3

mapply(sum, vec1, vec2 ,vec3)

rm(list=ls())

# apply 계열 연습문제 -------------------------------------------------------------------------------------------------------------

data1 <- NULL
data1 <- read.csv("data1.csv", header = T)
str(data1)

# 1.1 연도별 합계 
apply(data1[,-1], 2, sum)                    # 열을 기준으로 계산  apply(데이터, 방향(1:행 2:열), 적용함수)

# 1.2 연령대별 합계                          # 행을 기준으로 계산 
apply(data1[,-1],1,sum)

# 2.1 노선 번호별 승차 인원수 합
data2 <- read.csv("1-4호선승하차승객수.csv")

attach(data2)   # 데이터 프레임 활성화로 변수명을 바로 접근 가능하게 함                               
tapply(승차, 노선번호,sum)                   # tapply(출력값, 기준컬럼, 적용함수)

# 2.2 노선 번호별 하차 인원수 합 
tapply(하차, 노선번호, sum)
    
# 2.3 승차 하차 인원수 합 
apply(data2[,c(3:4)],2,sum)
sapply(data2[,c(3:4)],sum)                   # sapply(데이터, 적용함수)

# 2.4 노선 번호별 승하차 인원수 합
str(data2)
aggregate(승차 + 하차 ~ 노선번호,data2,sum)  # aggregate(계산될 열 ~ 기준될 열, 데이터, 함수)

# 2.5 노선 번호별 승차 인원수 합 
aggregate(승차 ~ 노선번호,data2,sum)

# 2.6 노선 번호별 하차 인원수 합 
aggregate(하차 ~ 노선번호,data2,sum)

detach(data2)   # 활성화 해제 
tm(list=ls())


# 8.1.6 한꺼번에 차이 구하기 - sweep 함수 ---------------------------------------------------------------------------------

mat1 <- matrix(seq(1:9), nrow = 3, byrow = 2); mat1
a <- c(1,1,3); a       # 기준에 따라 각각 1,2,3 번째 행(1) 또는 열(2)을 의미
sweep(mat1,2,a)        # sweep(데이터, 방향, 요소)
                       # mat1을 열 기준으로 첫번째 열은 1, 2번째 열도1, 3번째 열은 3만큼 뺴라 

# 8.1.7 elements 개수 구하기 - length 함수 ---------------------------------------------------------------------------------

b <- c(1:5); length(b) # length 요소의 개수를 세어줌
length(Fruits)         # 데이터 프레임은 변수(열)의 개수를 세어줌 

# 8.1.8 plyr packages - apply 함수에 기반해 데이터와 출력변수를 배열로 치환하여 처리하는 패키지 ----------------------------

install.packages("plyr")
library(plyr)

#                 출력형테  array   data frame    list   nothing
#       입력형태
#        array              aaply      adply     alply     a_ply
#     data frame            daply      ddply*    dlply*    d_ply
#        list               laply      ldply*    llply     l_ply
#    n replicates           raply      rdply     rlply     r_ply
# function arguments        maply      mdply     mlply     m_ply

# * : 자주쓰이는 함수들 

# ex)
airquality # 데이터
str(airquality)

ddply(airquality,"Month",summarise,mean=mean(Temp)) # summarise : 새로운 데이터 프레임에 결과값 산출
ddply(airquality,"Month",transform,mean=mean(Temp)) # transform : 결과겂을 기존 데이터에 새로운 컬럼으로 추가
ddply(subset(airquality,Ozone >= 30),"Month",summarise, mean = mean(Temp)) # 조건식 추가 가능 
