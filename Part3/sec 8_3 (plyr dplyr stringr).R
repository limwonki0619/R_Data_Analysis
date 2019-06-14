getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part3/data")
setwd("D:/limworkspace/R_Data_Analysis/Part3")
getwd()

#--------------------------------------------------------------#
#------------------ section 8 : 다양한 함수 -------------------#
#--------------------------------------------------------------#

# dplyr 참고자료 : https://rfriend.tistory.com/235

# 8.5 데이터 핸들링 - plyr packages ------------------------------------------------------------------------------------------------------------

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

fruits <- read.csv( "data/fruits_10.csv" ); fruits

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


# 8.6 데이터 핸들링 - dplyr packages ********** ------------------------------------------------------------------------------------------------

install.packages('dplyr')
library(dplyr)
list.files()

data1 <- read.csv("data/2013년_프로야구선수_성적.csv")
str(data1)

# 8.6.1 filter(데이터 ,조건) - 조건을 줘서 원하는 데이터만 얻는 기능 ---------------------------------------------------------------------------

data2 <- filter(data1, 경기 > 120 ); data2
data3 <- filter(data1, 경기 > 120 & 득점 > 80); data3
data4 <- filter(data1, 포지션 == '1루수' | 포지션 == '3루수'); data4          
data5 <- filter(data1, 포지션 %in% c('1루수','2루수')); data5            # %in% 포함하고 있는지 묻는 연산자

# 8.6.2 select(데이터, 컬럼명) - 특정 컬럼만 선택해서 사용하는 기능 ----------------------------------------------------------------------------

select(data1, 선수명, 포지션, 팀)                                        # 원하는 컬럼 선택         
select(data1, 순위:타수)                                                 # :로 범위지정 가능 
select(data1, -홈런, -타점, -도루)                                       # 해당 컬럼을 제외 
select(data1, -홈런:-도루)

data1 %>%                                                                # %>%(pipe) :  여러문장을 조합해서 한 문장처럼 사용 가능 
  select(선수명, 팀, 경기, 타수) %>% 
  filter(타수 > 400) 
  
# 8.6.3 arrange(정렬하고자 하는 변수) - 데이터를 오름차순 or 내림차순으로 정렬 (= sorting) ------------------------------------------------------

data1 %>% 
  select(선수명, 팀, 경기, 타수) %>% 
  filter(타수 > 400) %>%
  arrange(desc(타수))                                                    # desc(변수) : 내림차순 정렬 

data1 %>% 
  select(선수명, 팀, 경기, 타수) %>% 
  filter(타수 > 400) %>%
  arrange(desc(경기), desc(타수))                                        # 순서대로 정렬 기준이 정해짐 

# 8.6.4 mutate(새로운 변수 = 함수) - 기존의 변수를 활용하여 새로운 변수를 생성 (with %>%) -------------------------------------------------------

data2 <- data1 %>%
           select(선수명, 팀, 출루율, 장타율) %>%
           mutate(OPS = 출루율 + 장타율) %>%                             # 새로운 변수 생성 
           arrange(desc(OPS))

# 8.6.5 summarise - 다양한 함수를 통해 주어진 데이터를 집계한다 (with group_by) -----------------------------------------------------------------

str(data1)
data1 %>% 
  group_by(팀) %>%
  summarise(average = mean(경기, na.rm = T))                             # 평균 경기 출장수, 결측치 제거 

data1 %>% 
  group_by(팀) %>%
  summarise_each(list(mean), 경기, 타수)

data1 %>% 
  group_by(팀) %>%
  mutate(OPS = 출루율 + 장타율) %>%                                      # summarise_each : 여러개의 변수에 함수를 적용할 때 사용 
  summarise_each(list(mean), 장타율, 출루율, 타율, OPS) %>%              # summarise_each(funs(함수), 변수들)
  arrange(desc(OPS))                                                     # deprecated 오류는 앞으로 기능을 변경할 것을 암시

data1 %>% 
  group_by(팀) %>%
  mutate(OPS = 출루율 + 장타율) %>%                                      
  summarise_each(list(mean), 장타율, 출루율, 타율, OPS) %>%              # 원하는 변수들의 요약값 출력
  arrange(desc(OPS))     

data1 %>% 
  group_by(팀) %>%
  summarise_each(funs(mean, n()), 경기, 타수)                            # n() 함수로 개수도 포함 // n 함수는 funs로만 사용가능
library(reshape2)
library(ggplot2)

# dplyr 연습문제 1

library(googleVis)
attach(Fruits)

Fruits_2 <- filter(Fruits, Expenses > 80); Fruits_2
Fruits_3 <- filter(Fruits, Expenses > 90 & Sales > 90); Fruits_3
Fruits_4 <- filter(Fruits, Expenses > 90 | Sales > 80); Fruits_4

Fruits_5 <- filter(Fruits, Expenses %in% c(79,91)); Fruits_5
Fruits_5 <- filter(Fruits, Expenses == 79 | Expenses == 91); Fruits_5

Fruits_6 <- select(Fruits[,1:4], -Location); Fruits_6

Fruits_7 <- Fruits %>% 
            group_by(Fruit) %>% 
            summarise(average = sum(Sales, na.rm = T)); Fruits_7

Fruits_8 <- Fruits %>% 
            group_by(Fruit) %>% 
            summarise(Sales = sum(Sales),
                      Profit = sum(Profit)); Fruits_8

Fruits_8 <- Fruits %>% 
            group_by(Fruit) %>% 
            summarise_each(list(sum),Sales,Profit); Fruits_8
                                                  
rm(list=ls())

# 8.7 데이터 핸들링 - reshape2 packages ***** ---------------------------------------------------------------------------------------------------

install.packages("reshape2")
library(reshape2)
fruits <- read.csv("data/fruits_10.csv" ); fruits

melt(fruits, id = 'year')                                                 # melt : 녹이다 // id 값을 기준으로 long format 으로 변환  
melt(fruits, id = c('year','name'))
melt(fruits, id = c('year','name'), 
     variable.name = '변수명',
     value.name = '변수값')

mtest <- melt(fruits, id = c('year','name'), 
              variable.name = '변수명',                                   # variable을 임의로 바꿀 수 있다
              value.name = '변수값')                                      # value를 임의로 바꿀 수 있다 

# dcast(melt된 데이터, 기준컬럼 ~ 대상컬럼, 적용함수)
dcast(mtest, year+name ~ 변수명)                                          # dcast(data, 기준컬럼 ~ 대상컬럼, 적용함수)                  
dcast(mtest, name~변수명, mean, subset=.(name=='berry'))
dcast(mtest, name~변수명, sum, subset=.(name=='apple'))                   # subset 옵션으로 특정 변수만 출력 가능 

# 8.8 데이터 핸들링 - stringr packages ****** ---------------------------------------------------------------------------------------------------

install.packages("stringr")
library(stringr)

# 8.8.1 str_detect(data, '찾고자하는 문자') - 특정문자를 찾는 함수 ------------------------------------------------------------------------------
fruits_string <- c('apple','Apple','banana','pineapple')

str_detect(fruits_string, 'A')                                             # 대문자 A가 있는 단어 찾기 (논리값으로 출력)
str_detect(fruits_string, 'a')                                             # 소문자 a가 있는 단어 찾기 (논리값으로 출력)

str_detect(fruits_string, '^a')                                            # 첫 글자가 소문자 a인 단어 찾기 (논리값)
str_detect(fruits_string, 'e$')                                            # 끝나는 글자가 소문자 e인 단어 찾기 (논리값)
str_detect(fruits_string, '^[aA]')                                         # 시작하는 글자가 대문자 A 또는 소문자 a인 단어 찾기 (논리값)
str_detect(fruits_string, '[aA]')                                          # 단어에 소문자 a와 대문자 A가 들어 있는 단어 찾기 (논리값)
str_detect(fruits_string, regex('a', ignore_case = T))                     # 대소문자 구분을 안하도록 설정하는 함수 


# 8.8.2 str_count(data, '세고자 하는 문자) - 주어진 단어에서 해당 글자가 몇 번 나오는지 세는 함수   ---------------------------------------------

str_count(fruits_string, 'a')                                              # 'a'가 각각의 데이터에 몇번 포함하는지 출력 

# 8.8.3 str_c('chr1', 'chr2'|data) - 문자열을 합쳐서 출력  -------------------------------------------------------------
#       str_c == paste
#       str_c(sep="") == paste0

str_c('apple','banana')
str_c('Fruits : ' ,fruits_string)                                          # 문자에 벡터 데이터도 붙이기 가능 
str_c(fruits_string, " name is", fruits_string)
str_c(fruits_string, collapse = '')                                        # collapse 옵션으로 구분자 설정이 가능
str_c(fruits_string, collapse = ', ')

# 8.8.4 str_dup(data, 횟수) - data를 횟수만큼 반복해서 출력 -------------------------------------------------------------------------------------

str_dup(fruits_string, 3)

# 8.8.5 str_length('문자열') - 주어진 문자열의 길이를 출력 --------------------------------------------------------------------------------------
#       str_length == length

str_length(fruits_string)
str_length('과일')

# 8.8.6 str_locate('문자열, '문자') - 주어진 문자열에서 특정 문자의 처음, 마지막 위치를 출력 ----------------------------------------------------
 
str_locate(fruits_string, 'a')                                             # 대소문자 구별이 필요 // 처음 나오는 'a'의 위치를 출력
str_locate('apple', 'app')                                                 # 타 언어와 인덱스의 구간과 차별이 있음

# 8.8.7 str_repalce('chr1,'old,'new) - 이전 문자를 새로운 문자로 변경 // sub() 함수와 같은 기능 
#       str_replace == sub
#       str_replace_all == gsub

str_replace('apple','p','*')                                               # apple에서 첫번째 p를 *로 변경
str_replace('apple','p','++')                                              # apple에서 첫번째 p를 ++로 변경
str_replace_all('apple','p','*')                                           # apple에서 모든 p를 *로 변경 

# 8.8.8 str_split(문자열, '기준으로 나눌 문자) - 특정 문자를 기준으로 문자열을 나눠줌 -----------------------------------------------------------
fruits_string2 <- str_c('apple','/','orange','/','banana')
str_split(fruits_string2, '/')                                             # fruits_string2를 /를 기준으로 분리 // 결과값은 list로 출력
str_split_fixed(fruits_string2,'/',3)[,2]                                  # '/'을 기준으로 문자열을 지정된 자리수로 분리 // 뒤에 인덱싱으로 분리된 문자열 선택 가능 
str_split_fixed(fruits_string2,'/',3)[,1]

# 8.8.9 str_sub(문자열, start, end) - 문자열에서 지정된 길이 만큼의 문자를 잘라내줌 -------------------------------------------------------------
#       str_sub == substr 

fruits_string2
str_sub(fruits_string2, start=1, end=3)
str_sub(fruits_string2,1,3)                                                # start, end 없이도 가능 
str_sub(fruits_string2, -5)                                                # 뒤에서 다섯번 째 부터 문자열을 잘라냄 

# 8.8.10 str_trim() - 문자열의 가장 앞, 뒤의 공백을 제거해줌 ------------------------------------------------------------------------------------

str_trim(' apple banana berry       ')
str_trim('\t apple banana berry')
str_trim('       apple     bananan   berry  \n   ')

# 8.8.11 str_match(data, pattern) - 문자의 패턴이 매치하는 자리를 출력해줌 ----------------------------------------------------------------------
fruits_string <- c('apple','Apple','banana','pineapple')

str_detect(fruits_string, 'A')                                             # 대문자 A가 있는 단어 찾기 (논리값으로 출력)
str_match(fruits_string, 'A')                                              # 대문자 A가 있는 단어 찾기 (매칭되는 위치의 값만 출력)

# 8.8.12 원하는 행 추출하기 *** -----------------------------------------------------------------------------------------------------------------

data2[nchar(data2$시간)==3,2] <- paste0(0,data2[nchar(data2$시간)==3,2]); data2  # 1번 방법

data2$새로운시간 <- paste(str_sub(data2[,2],1,2),
                     str_sub(data2[,2],3,4), sep=":"); data2$시간 <- NULL; data2 # 2번 방법

library(googleVis)
Fruits

Fruits[str_detect(Fruits$Date, "10"),] # Fruits데이터의 Date열에서 "10"이 들어간 행만 추출 
Fruits[grep("10",Fruits$Date),]        # 같은 기능 
