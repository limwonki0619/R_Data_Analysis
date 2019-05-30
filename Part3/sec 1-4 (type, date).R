#--------------------------------------------------------------#
#               코딩에서 가장 중요한 것 두 가지                #
#                                                              #
#                        1. Indentation                        #
#                                                              # 
#                        2. Comment                            #
#--------------------------------------------------------------#


#--------------------------------------------------------------#
#----------------  section 1 ~ 3 : R 기본설정 -----------------#
#--------------------------------------------------------------#


# 1.1 작업용 기본 디렉토리 설정 ---------------------------------------------------------

getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")

# 1.2 print와 cat -----------------------------------------------------------------------

print(1+2)
1+2
print('a')
"a"
'string'
print(pi)
print(3.1457,digit=3)              # digit 옵션으로 나타낼 자리수 지정 가능 (반올림)

print(3,4)                         # print는 한가지 타입만 출력
print(3,"a")                       # 두 가지 타입은 error 

cat(3,4)                           # cat 다양한 형태의 타입은 출력가능 단, 행렬이나 리스트는 출력 불가
cat(3,"a")
cat(1,':','a','\n,',2,':','b')     # \n은 줄 바꾸기 
cat(list(1,2,3,4,5))               # error
3; 4; 5;                           # 세미콜론으로 한 줄에 여러 작업을 동시에 할 수 있다
1+2; 3+4; pi*5+5


#---------------------------------------------------------------#
#--------------------- section 4 : Data Type -------------------#
#---------------------------------------------------------------#

# 4.1 숫자형(numeric)과 주요 산술연산자 ----------------------------------------------------

print(5/2)
print(5%/%2)            # %/% 나눗셈의 몫을 구한다.
print(5%%2)             # %%  나눗셈의 나머지를 구한다. 
print(5^2)

100000+100000           # 2e+05 = 2*(10^5)
1 / 1000000             # 1e-06 = 1*(10^(-6))

'1'+'2'                          # Error: 문자형이라서 error 
as.numeric('1')+as.numeric('2')  # 문자형을 숫자형으로 변환 


# 4.2 문자형(character) --------------------------------------------------------------------

'First'
"Second"
first                   # Error: 문자형의 데이터가 아닌 변수 형태

first <- 1              # 변수 설정 후 변수를 호출하면 해당하는 값을 출력
first

class(1)
class('1')
class(first)


# 4.3 FALSE와 TRUE -------------------------------------------------------------------------

3 & 0                   # 3 and 0의 의미로 T * F 이므로 출력값은 F
3 & 1                   # 3 and 1의 의미로 T * T 이므로 출력값은 T

3 | 0                   # 3 or 0 의 의미로 T + F 이므로 출력값은 T
3 : 1                   # 3 or 1 의 의미로 T + T 이므로 출력값은 T

!0                      # 0(FALSE, 거짓)이 아닌 것이므로 출력값은 T
!1                      # 1(TRUE, 참)이 아닌 것이므로 출력값은 F

class(!0)


# 4.4 NA형(logical) & NULL형(null) ----------------------------------------------------------

                        # NA : 잘못된 값이 들어올 경우 발생 (Not Applicable, Not Available)
                        # NULL : 값이 없을 경우 발생 

cat(1,NA,2)             # NA가 그대로 출력된다 
cat(1,NULL,2)           # NULL값이 제거되고 출력된다 

sum(1,NA,2)             # NA를 더하니까 결과가 NA로 출력된다 
sum(1,NULL,2)           # NULL값은 제외한 나머지 값만 더해서 결과가 출력된다 
sum(1,NA,2, na.rm=T)    # NA를 제거(옵션 na.rm=T) 한 후 함수를 수행한다 


# 4.5 범주형(Factor) -----------------------------------------------------------------------

factor_test <- read.csv("factor_test.txt")

View(factor_test)
factor1 <- factor(factor_test$blood); factor1   # factor_test의 blood 변수를 factor형으로 지정하고 factor1에 저장 
gender1 <- factor(factor_test$sex); gender1

summary(factor1)         # factor를 요약해서 보여준다 
summary(gender1)

factor2 <- factor(factor_test$blood,stringAsFactor=F)


# 5.1 기본 방법으로 날짜와 시간 제어하기 ---------------------------------------------------

Sys.Date()                                        # 대소문자 주의
Sys.time()                                        # 타임존 및 시간까지 출력
date()                                            # 미국시간이 출력

class(Sys.Date())                                 # 날짜의 자료형은 Date 타입
class("2019-05-30")
class(as.Date("2019-05-30"))

as.Date("2019/05/30")

as.Date("30/05/2019")                              # Date 포멧에 맞춰 작성
as.Date("19/05/30")

as.Date("30-05-2019",format="%d-%m-%Y")            # %d 일자를 숫자로 
as.Date("30052019",format="%d%m%Y")                # %m 월을 숫자로 
as.Date("2019-05-30",format="%Y-%m-%d")            # %b 월을 영어 약어로
                                                   # %B 월을 전체 이름으로 
                                                   # %y 년도를 숫자 두자리로
as.Date("2014년 11월 1일",format="%Y년 %m월 %d일") # %Y 년도를 숫자 네자리로 인식

as.Date(10, origin="2019-05-30")                   # 기준날짜에 +10일 이후 
as.Date(-10, origin="2019-05-30")                  # 기준날짜에 -10일 이전
as.Date(-55, date())                               # error 표준서식이 아님 
as.Date(-55, Sys.Date())
as.Date("2019-05-30")+5                            
as.Date("2019-05-30") - as.Date("2019-05-27")      # 날짜차이를 알고 싶을 때 단, 반드시 날짜형이어야함 
as.Date("2019-11-14") - Sys.Date()

# R에서 날짜를 언급할 때 POSIXlt와 POSIXct 두 가지 클래스가 있다
# POSIXlt는 날짜를 년 월 일로 표시하는 리스트형 클래스고 
# POSIXct는 날짜를 연속적인 데이터로 인식해서 1970년을 기준으로 초 단위로 계산해 시간차이까지 알 수 있다 

as.Date("2019-05-30 20:00:00") - as.Date("2019-05-30 18:30:00")        # POSIXlt
as.POSIXct("2019-05-30 20:00:00") - as.POSIXct("2019-05-30 18:30:00")  # POSIXct 시간차이를 알 때 유용


# 5.2 lubridate 패키지로 날짜와 시간 제어하기 ---------------------------------------------------

install.packages("lubridate")    # 패키지 설치
library(lubridate)               # 패키지 적용 

date <- Sys.Date(); print(date)  # 현재 날짜만 출력 2019-05-30"
date <- now(); print(date)       # 현재 날짜와 시간까지 출력  "2019-05-30 09:50:01 KST"

year(date)
month(date,label=T)
day(date)
wday(date,label = F)            # 요일을 숫자로 출력 
wday(date,label = T)            # 요일을 한글로 출력

date <- date - days(2); date
month(date) <- 2; date          # 날짜를 2월로 설정하기 

date <- now(); print(date)
date+months(3)
date <- hm("22:30"); date       # 시간, 분 설정하기 
date <- hms("22:30:15"); date   # 시간, 분, 초 설정하기 




