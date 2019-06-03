getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")
testfile <- read.csv("학생시험결과_전체점수.csv")

str(testfile)

testfile$이름
testfile[1,3]
testfile[,4]
head(testfile)
View(testfile)
colnames(testfile)[5] <- "환산점수"

testfile <- cbind(testfile, data.frame(grade = rep(c("A","B","C"),nrow(testfile)))); testfile

names(testfile)
colnames(testfile)[7] <- "등급"

testfile2 <- rbind(testfile, data.frame(순위=30,
                                        이름="김준호",
                                        조=3,
                                        점수=45,
                                        환산점수=57.8,
                                        성취율=0.50,
                                        등급="A")); testfile2

subset(testfile, 점수<45 | 성취율>0.80)
subset(testfile, 조!=3 & 환산점수 < 75)
subset(testfile, 조==4 & 성취율>=0.8 | 등급=='B' & 점수 <= 10)

names(testfile)
subset(testfile, select = c('순위','점수','등급'))
subset(testfile, select = c(순위,점수,등급))             # select 옵션에서는 ''가 상관없으나 되도록이면 안헷갈리게 ''사용하자. 


testfile3 <- NULL
testfile4 <- NULL
testfile3 <- testfile2[1:40,]; testfile3
testfile4 <- testfile2[40:nrow(testfile2),]; testfile4

rbind_test <- rbind(testfile3,testfile4); rbind_test
cbind_test <- cbind(testfile3,testfile4); cbind_test     # 행의 개수가 다르면 cbind 불가

testfile[seq(nrow(testfile),round(nrow(testfile)/2)),]

rm(list = ls())

# aggregate, apply 계열 함수 -----------------------------------------------------------

getwd()
list.files()
data1 <- read.csv("data1.csv"); str(data1)
data2 <- read.csv("1-4호선승하차승객수.csv"); str(data2)

str(data2)
subset(data2, 승차 >= 350000 & 하차 <= 500000)

install.packages("stringr")
library(stringr)

# 원하는 행 추출하기 *** ---------------------------------------------------------------

data2[nchar(data2$시간)==3,2] <- paste0(0,data2[nchar(data2$시간)==3,2]); data2


data2$새로운시간 <- paste(str_sub(data2[,2],1,2),
                          str_sub(data2[,2],3,4), sep=":"); data2$시간 <- NULL; data2

# 연습문제 1

apply(data1[,-1],2,sum) # 1 : 행, 2: 열
apply(data2[,-1],1,sum)

# 연습문제 2
str(data2)
attach(data2)
tapply(승차, 노선번호, sum)
tapply(하차 ,노선번호, sum)
apply(data2[,3:4],2,sum)

aggregate(승차+하차 ~ 노선번호,data2,sum)
aggregate(승차~노선번호,data2,sum)
aggregate(하차~노선번호,data2,sum)

# 연습문제 3
str(airquality)
aggregate(Ozone ~ Month, airquality, mean) 
install.packages("reshape")
install.packages("reshape2")
library(reshape2)
library(reshape)  # cast() 함수는 reshape 패키지에

melt_air <- melt(airquality, id=c("Month","Day"),na.rm=T); str(melt_air)
aggregate(value~Day,melt_air,mean)
aggregate(value~variable+Month,melt_air,median)
cast(melt_air, Day ~ Month ~variable, mean, na.rm=T)

# 변수다루기 dplyr packages -------------------------------------------------------------------
install.packages("dplyr")
library(dplyr)
library(googleVis)

attach(Fruits)
Fruits_2 <- filter(Fruits, Expenses > 80); Fruits_2
Fruits_3 <- filter(Fruits, Expenses > 90 & Sales > 90); Fruits_3
Fruits_4 <- filter(Fruits, Expenses > 90 | Sales > 80); Fruits_4
Fruits_5 <- filter(Fruits, Expenses == 79 | Expenses == 91); Fruits_5
Fruits_6 <- select(Fruits[,1:4], -Location) ; Fruits_6

Fruits %>% group_by(Fruit) %>% summarise(average = sum(Sales, na.rm=T))
Fruits %>% group_by(Fruit) %>% summarise(Sales = sum(Sales),
                                         Profit = sum(Profit))

# dplyr - mpg 연습문제 다시한번 풀어보기
library(dplyr)
library(ggplot2)

# 1. 
str(mpg)
displ4down <- mpg %>% filter(displ <= 4) %>% summarise(mean_hwy = mean(hwy))
displ5up <- mpg %>% filter(displ >= 5) %>% summarise(mean_hwy = mean(hwy))
displ4down; displ5up

# 2.
mpg %>% 
    filter(manufacturer %in% c('audi','toyota')) %>%
    group_by(manufacturer) %>%
    summarise(mean_cty = mean(cty))

# 3. 
mpg %>% 
    filter(manufacturer %in% c('chevrolet','ford','honda')) %>%
    summarise(total_hwy_mean = mean(hwy))

# 4. 
mpg_data <- mpg %>% select(class, cty)

# 5.
mpg_data %>% 
         filter(class %in% c('suv','compact')) %>%
         group_by(class) %>%
         summarise(mean_cty = mean(cty))
# 6. 
mpg %>%
    select(manufacturer, class, model, hwy) %>%
    filter(manufacturer == 'audi') %>%
    arrange(desc(hwy)) %>%
    head(5)

# 7. 
mpg %>% 
    select(manufacturer, model, cty, hwy) %>%
    mutate(합산연비변수 = cty+hwy, 평균연비변수 = 합산연비변수/2) %>%
    arrange(desc(평균연비변수)) %>%
    head(3)
    
# 8-9
mpg %>% 
    select(class, cty) %>%
    group_by(class) %>% 
    summarise(mean_cty = mean(cty)) %>%
    arrange(desc(mean_cty))

# 10.
mpg %>%
    select(manufacturer, hwy) %>%
    group_by(manufacturer) %>%
    summarise(mean_hwy = mean(hwy)) %>%
    arrange(desc(mean_hwy)) %>% 
    head(3)

# 11.
mpg %>% 
    select(manufacturer, class) %>%
    group_by(manufacturer) %>%
    summarise(count = n()) %>% 
    arrange(desc(count))


# stringr 함수 연습
#---------------------------------chapter1 url parsing

hk_url <- "http://search.hankyung.com/apps.frm/search.news?query=%EC%A0%84%EA%B8%B0%EC%9E%90%EB%8F%99%EC%B0%A8&page="

hk_urls <- NULL
for (x in 0:5){
  hk_urls[x+1] <- paste(hk_url, as.character(x),sep = "")
}

urls <- NULL
for(url in hk_urls){
  html <- read_html(url)
  urls <- c(urls, html %>% html_nodes(".txt_wrap") %>% html_nodes("a") %>% html_attr("href") %>% unique())
}

library(stringr)
raw_urls <- urls[str_detect(urls, 'economy/article')]; raw_urls
class(urls) 
# 조건문 -------------------------------------------------------------------------------------------

f_plus <- function(x) {
  if(x>0) {return(x)}
  else {return(-x)} 
  }

f_plus(-3)

mf1 <- function(x) { 
  if (x > 0) { x <- x^2
  return(x)}
  else {x <- x*0 
  return(x)}
}
mf1(-3)

mf2 <- function(x){
  if (x>0) {x <- x*2 
  return(x)}
    else if (x == 0) {x <- x*0 
    return(x)}
      else {x <- x*2
      return(x)}
}

mf2(-3)
mf2(0)
mf2(3)

no <- seq(1:10); no
ifelse(no%%2==0,"짝수","홀수")

# 연습문제 

# 1.
myf1 <- function(x){
  if(x>0){ 
  return(1)}
    else{ 
    return(0)}
  }

# 2.
myf2 <- function(x){
  if(x>=0){
  return(1)}
    else{
    return(0)}
}

myf3 <- function(a,b){
  if(a>b){
  return(a-b)}
    else{
    return(b-a)}
}

myf4 <- function(x){
  if(x<0){ 
  return(0)}
    else if(x>=1 & x <=5){
    return(1)}
      else { 
      return(10)}
}


myf5 <- function(x){
  if(x=='Y'|x=='y'){return("yes")}
  else{return("Not Yes")}
}

myf5("y")
var1 <- readLines("채소.txt")


x <- 0
while(x<5){x <- x+1;
if(var1[x]=="버섯") next; print(var1[x]);
}

for(i in seq(10,30,10)){
  print(str_c(i,"번 학생 손드세요"))
}
# ------------------------------------------------------------------------------