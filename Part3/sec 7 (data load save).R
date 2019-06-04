getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")
setwd("D:/limworkspace/R_lecture/Part3")
getwd()

#--------------------------------------------------------------#
#               코딩에서 가장 중요한 것 두 가지                  #
#                                                              #
#                        1. Indentation                        #
#                                                              # 
#                        2. Comment                            #
#--------------------------------------------------------------#


#--------------------------------------------------------------#
#---------------- section 7 : 데이터 불러오기 ------------------#
#--------------------------------------------------------------#

# 7.1 파일이름 확인하기 - list.files() -----------------------------------------------------------------------------------

list.files()
list.files(recursive=T)     # 하위 디렉토리 내용까지 보여줌 
list.files(all.files=T)     # 숨김 파일까지 전부  보여줌

# 7.2 텍스트 파일 읽기 - scan() ---------- --------------------------------------------------------------------------------
                                                                           # scan()함수는 텍스프 파일을 읽고 배열에 저장한다. 
scan1 <- scan('scan_1.txt'); scan1; class(scan1);                          # scan_1.txt.는 숫자로 이뤄져 있다.
scan2 <- scan('scan_2.txt'); scan2; class(scan2);                          # scan_2.txt 는 소수점으로 이뤄져 있다. -> 소수점은 사라짐 
scan2 <- scan('scan_2.txt',what=''); scan2; class(scan2)                   # what 옵션을 통해 소수점 이하 자리까지 불러왔으나, 데이터는 문자형
scan3 <- scan('scan_3.txt',what=''); scan3; class(scan3)                   # 문자형을 읽을때도 what 옵션이 필요 단, console 창에 입력 
scan4 <- scan('scan_4.txt',what=''); scan4; class(scan4)               

input <- scan()                                                            # 사용자가 직접 값을 설정 가능 
input <- scan(what="");                                                    # 문자를 입력하고자 할 때는 what 옵션이 필요

# 7.3 텍스트 파일 한 줄로 읽기 - readline() ------------------------------------------------------------------------------

input3 <- readline(); input3                                               # 문장을 넣기 위해서는 readline() 함수를 사용  *대소문자 주의
input4 <- readline("Are you Ok?")                                          # 특정 문장을 넣을 수 있음

# 7.4 텍스트 파일 배열에 담기 - readLines() ------------------------------------------------------------------------------

# 7.5 텍스트 파일 데이터 프레임에 담기 - read.table() --------------------------------------------------------------------
                                                                           # 데이터를 불러오기 전 데이터 형태 파악 View()
fruits <- read.table("fruits.txt"); fruits; class(fruits)                  # header를 제외한 데이터 가져오기 
fruits <- read.table("fruits.txt",header = T); fruits; class(fruits)       # header = T 옵션으로 데이터를 읽을 때 첫째 행을 변수로 가져오기 
fruits2 <- read.table("fruits_2.txt"); fruits2;                            # 주석(#)은 빼고 데이터를 읽음 
fruits2 <- read.table("fruits_2.txt", skip = 2); fruits2                   # skip 옵션으로 건너뛸 행의 개수를 설정할 수 있음 
fruits2 <- read.table("fruits_2.txt", nrows = 2); fruits2                  # nrow 옵션으로 2번째 행부터 데이터를 가져올 수 있음

f2top <- read.table("fruits_2.txt", nrows = 2)                             # 파일을 위에서 2번 째 까지 가져오기 
f2bottom <- read.table("fruits_2.txt", skip = 3)                           # 파일을 3번 째 행 까지 스킵 후 가져오기  
f2top ;f2bottom

# 1 ~ 100     : nrow = 100 
# 101 ~ 200   : skip = 100, nrow = 100
# 201 ~ 300   : skip = 200, nrow = 100

# 7.6 csv 파일 읽기*** - read.csv() --------------------------------------------------------------------------------------

# csv : comma-separated values는 몇 가지 필드를 쉼표(,)로 구분한 텍스트 데이터 및 텍스트 파일이다.

fruits3 <- read.csv("fruits_3.csv"); fruits3                               # csv는 header가 디폴트
fruits4 <- read.csv("fruits_4.csv"); fruits4                               # 따라서 header를 설정하지 않으면 첫 번째 행을 header로 인식 
fruits4 <- read.csv("fruits_4.csv", header = F); fruits4                   # header가 없을 경우 header = F 옵션을 사용 

label <- c('NO','NAME','PRICE','QTY'); label                               # 변수명 생성 
fruits4 <- read.csv("fruits_4.csv",header = T, col.names = label); fruits4 # col.names 옵션으로 변수명을 설정할 수 있다. 

# 7.7 원하는 데이터를 sql쿼리로 불러오기 - read.csv.sql() ----------------------------------------------------------------

install.packages("googleVis")
library(googleVis)
install.packages("sqldf")
library(sqldf)

write.csv(Fruits,"Fruits_sql.csv", quote = F, row.names = F)                # csv 파일로 저장하기 
write.csv(Fruits,"Fruits_sql2.csv", quote = T, row.names = F)               # quote 옵션은 인용구 유무 설정  
fruits_2 <- read.csv.sql("Fruits_sql.csv",
                         sql = "SELECT * FROM file WHERE year = 2008")      # 해당 파일에서 year = 2008인 데이터만 가져오기

# **** 많이쓰이는 조건에 맞는 데이터 찾기 --------------------------------------------------------------------------------- 

Fruits[which(Fruits$Year==2008),]                                           # which() 함수는 논리값의 참값 위치를 알 수 있음 
subset(Fruits, Year==2008)                                                  # subset 함수로도 가능 

# 7.8 excel 파일 가져오기 - readxl() --------------------------------------------------------------------------------------

install.packages("readxl")
library(readxl)

fruits7 <- read_excel("fruits_6.xls",
                      sheet = "Sheet1",
                      range = "A2:D6",
                      col_names = T,
                      col_types = "guess",
                      na = 'NA'); fruits7; class(fruits7)

# Rstudio GUI -> File -> Import Dataset 으로도 가능 

# 참고) 64bit excel 파일 가져오기 - XLConnect packages 

install.packages("XLConnect")
library(XLConnect)
data1 <- loadWorkbook("fruits_6.xls", create = T)
data2 <- readWorksheet(data1,sheet="sheet1")                                # startRow, endRow, startCol, endCol 옵션으로 원하는 범위 지정 가능 

# 7.9 클립보드 내용을 사용해 데이터 프레임 생성하기 - read.delim()  ------------------------------------------------------

fruits6 <- read.delim("clipboard",header = T); fruits6



rm(list = ls())
