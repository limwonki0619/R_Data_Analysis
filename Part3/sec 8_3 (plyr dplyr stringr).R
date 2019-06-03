getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")
setwd("D:/limworkspace/R_lecture/Part3")
getwd()

#--------------------------------------------------------------#
#------------------ section 8 : 다양한 함수 -------------------#
#--------------------------------------------------------------#

# 8.5 데이터 핸들링 - plyr packages ----------------------------------------------------------------------------------------

#                 출력형태  array   data frame   list      nothing
#       입력형태
#        array              aaply      adply     alply     a_ply
#     data frame            daply      ddply*    dlply*    d_ply
#        list               laply      ldply*    llply     l_ply
#    n replicates           raply      rdply     rlply     r_ply
# function arguments        maply      mdply     mlply     m_ply

# * 자주 쓰이는 함수 
# 다양한 출력형태를 나타냄 

install.packages("plyr")
library(plyr)
rm(list = ls())
list.files()

fruits <- read.csv( "fruits_10.csv" ); fruits

# ddply(data, 기준컬럼, 적용함수 or 결과물)

ddply(fruits, 'name', summarise, sum_qty = sum(qty),                    # 변수 생성 
                                 sum_price = sum(price)                 # summarise는 새로운 dfm을 생성 
      )                                                                 # 기준컬럼 별로 데이터 생성 

ddply(fruits, 'name', summarise, max_qty = max(qty),                    # 다양한 함수 적용이 가능 
                                 min_price = min(price)                 # summarise = group_by와 같은 기능  
      )

ddply(fruits, c('year','name'), summarise, max_qty = max(qty),          # 다양한 함수 적용이 가능 
                                           min_price = min(price)       # summarise = group_by와 같은 기능  
      )

ddply(fruits, c('year','name'), transform, sum_qty = sum(qty),
                                 pct_qty = (100*qty)/sum(qty)           # transform은 컬럼을 기존 데이터와 함께 나타냄
      )


# 8.6 데이터 핸들링 - dplyr packages ********** ----------------------------------------------------------------------------

install.packages('dplyr')
library(dplyr)
list.files()

data1 <- read.csv("2013년_프로야구선수_성적.csv")
str(data1)

# 8.6.1 filter(데이터 ,조건) - 조건을 줘서 원하는 데이터만 얻는 기능 -------------------------------------------------------

data2 <- filter(data1, 경기 > 120 ); data2
data3 <- filter(data1, 경기 > 120 & 득점 > 80); data3
data4 <- filter(data1, 포지션 == '1루수' | 포지션 == '3루수'); data4          
data5 <- filter(data1, 포지션 %in% c('1루수','2루수')); data5            # %in% 포함하고 있는지 묻는 연산자

# 8.6.2 select(데이터, 컬럼명) - 특정 컬럼만 선택해서 사용하는 기능 --------------------------------------------------------

select(data1, 선수명, 포지션, 팀)                                        # 원하는 컬럼 선택         
select(data1, 순위:타수)                                                 # :로 범위지정 가능 
select(data1, -홈런, -타점, -도루)                                       # 해당 컬럼을 제외 
select(data1, -홈런:-도루)

data1 %>%                                                                # %>%(pipe) :  여러문장을 조합해서 한 문장처럼 사용 가능 
  select(선수명, 팀, 경기, 타수) %>% 
  filter(타수 > 400) 
  
# 8.6.3 arrange(정렬하고자 하는 변수) - 데이터를 오름차순 or 내림차순으로 정렬 (= sorting) ---------------------------------

data1 %>% 
  select(선수명, 팀, 경기, 타수) %>% 
  filter(타수 > 400) %>%
  arrange(desc(타수))                                                    # desc(변수) : 내림차순 정렬 

data1 %>% 
  select(선수명, 팀, 경기, 타수) %>% 
  filter(타수 > 400) %>%
  arrange(desc(경기), desc(타수))                                        # 순서대로 정렬 기준이 정해짐 

# 8.6.4 mutate(새로운 변수 = 함수) - 기존의 변수를 활용하여 새로운 변수를 생성 (with %>%) ----------------------------------

data2 <- data1 %>%
           select(선수명, 팀, 출루율, 장타율) %>%
           mutate(OPS = 출루율 + 장타율) %>%                             # 새로운 변수 생성 
           arrange(desc(OPS))

# 8.6.5 summarise - 다양한 함수를 통해 주어진 데이터를 집계한다 (with group_by) --------------------------------------------

str(data1)
data1 %>% 
  group_by(팀) %>%
  summarise(average = mean(경기, na.rm = T))                             # 평균 경기 출장수, 결측치 제거 

data1 %>% 
  group_by(팀) %>%
  summarise_each(funs(mean), 경기, 타수)

data1 %>% 
  group_by(팀) %>%
  mutate(OPS = 출루율 + 장타율) %>%                                      # 여러개의 변수에 함수를 적용할 때 사용 
  summarise_each(funs(mean), 장타율, 출루율, 타율, OPS) %>%              # summarise_each(funs(함수), 변수들)
  arrange(desc(OPS))                                                     # deprecated 오류는 앞으로 기능을 변경할 것을 암시

data1 %>% 
  group_by(팀) %>%
  mutate(OPS = 출루율 + 장타율) %>%                                      
  summarise_each(list(mean), 장타율, 출루율, 타율, OPS) %>%              # 하나 일 떄는 funs 대신 list 사용 
  arrange(desc(OPS))     

data1 %>% 
  group_by(팀) %>%
  summarise_each(funs(mean, n()), 경기, 타수)                            # 개수도 포함 

# dplyr 연습문제 1

library(googleVis)
attach(Fruits)

Fruits_2 <- filter(Fruits, Expenses > 80); Fruits_2
Fruits_3 <- filter(Fruits, Expenses > 90 & Sales > 90); Fruits_3
Fruits_4 <- filter(Fruits, Expenses > 90 | Sales > 80); Fruits_4

Fruits_5 <- filter(Fruits, Expenses %in% c(79,91)); Fruits_5
Fruits_5 <- filter(Fruits, Expenses == 79 | Expenses == 91); Fruits_5

Fruits_6 <- select(Fruits[,1:4], -Location); Fruits_6
Fruits_7 <- Fruits %>% group_by(Fruit) %>% summarise(average = sum(Sales, na.rm = T)); Fruits_7
Fruits_8 <- Fruits %>% group_by(Fruit) %>% summarise(Sales = sum(Sales),
                                                     Profit = sum(Profit)); Fruits_8

Fruits_8 <- Fruits %>% group_by(Fruit) %>% summarise_each(list(sum),Sales,Profit); Fruits_8
                                                  
rm(list=ls())

# 8.7 데이터 핸들링 - reshape2 packages ***** ------------------------------------------------------------------------------


install.packages("reshape2")
library(reshape2)
fruits <- read.csv( "fruits_10.csv" ); fruits

fruits
# 8.8 데이터 핸들링 - stringr packages ****** ------------------------------------------------------------------------------


