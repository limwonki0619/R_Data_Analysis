getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part3/data")
setwd("D:/limworkspace/R_Data_Analysis/Part3")
getwd()

#--------------------------------------------------------------#
#----------------- section 9 : 조건문과 반복문 ----------------#
#--------------------------------------------------------------#

# 9.1 비교 조건에 사용되는 연산자 

#     == 같다
#     != 다르다
#     >= 이상
#     >  초과
#     <= 이하
#     <  미만

# 9.2 if 조건문 - 조건이 2개일 경우 ------------------------------------------------------------------------------------------------------------------

# if(조건식) { <조건이 맞을때 실행될 식 } 
#       else { <조건이 아닐 때 실행될 식> } 

myAbs <- function(x){
  if (x >= 0) {
    return(x)
    } else {
      return(-x)}       # else 유무는 상관이 없음
}

myAbs(-4.2)


myAbs2 <- function(x){
  if (x >= 0) {
    return(x)
    } return(-x)
}

myAbs2(-4.2)


myf1 <- function(x){
  if (x > 0) {
    return(x*x)
  } else {
    return(0)
  }
}
myf1(4.6)
myf1(-2.4)

# 9.3 if~else if 조건문 - 조건이 3개 이상일 경우 ------------------------------------------------------------------------------------------------------

# if(조건식) { <조건식 1일 때 실행될 문장>}
#  else if(조건식2) { <조건식 1일 때 실행될 문장 }
#        else { <조건식이 1,2 모두 아닐 때 실행될 문장 }

myf2 <- function(x) {
  if(x>0){
    return(2*x)
  } else if(x==0) {
    return(0)
  } else {
    return(-2 * x)
  }
}
myf2(4.6)
myf2(0)
myf2(-2.4)

# 9.4 ifelse(a,b,c) : a가 참이면 b를 출력, 거짓이면 c를 출력 ------------------------------------------------------------------------------------------

no <- 1:100
result <- ifelse(no%%2==0,"짝","홀")
ifelse(no%/%no==0,"소수","정수")

# if 연습문제 
# 1. 
myf1 <- function(x) {
  # return(ifelse(x > 5, 1, 0))
  if(x>5) {
    return(1)
  } else {
    return(0)
  }
}

myf1(4)

# 2.
myf2 <- function(x) {
  # return(ifelse(x > 0, 1, 0))
  if(x>0){
    return(1)
  } else {
    return(0)
  }
}

myf2(-3)

# 3. 
myf3 <- function(a,b) {
  # return(ifelse(a>b, a-b, b-a))
  if(a>b){
    return(a-b)
  } else {
    return(b-a)
  }
}

myf3(2,4)
myf3(3,2)

# 4. 
myf4 <- function(x) {
  if(x<0){
    return(0)
  } else if(x<=5 & x>=1) {
    return(1)
  } else if(x > 5) {
    return(10)
  } else {
    return(-1)
  }
} 

myf4(6)

# 5. 
myf5 <- function(x) {
  if(x=="Y"||x=="y"){
    print("Yes")
  } else {
    print("NOT Yes")
  }
}

xx <- c(T, T, F)
yy <- c(F, T, F)

xx & yy  # elemnet 전체
xx && yy # 대표값 하나 


myf6 <- function(x) {
  if(x %in% c("Y","y")){
    print("Yes")
  } else {
    print("NOT Yes")
  }
}

scan()        # 정수만
scan(what='') #문자를 읽을 수 있음 
myf5("Ye")
myf6("yo")

# 6.

myintD <- function(a, b, c) {
  D = b * b - 4*a*c
  if (D==10^(--10)) {
    return(2)
  } else if (D>0) {
    return(1)
  } else {
    return(0)
  }
} 

a <- 1.0000000000000001  
b <- -2.00000000000000001
c <- 1.0000000000000000000002

myintD(a,b,c)


myreadD <- function(a, b, c) { # 실수데이터일 경우 취급주의가 필요
  D = b * b - 4*a*c
  if (abs(D) < 1e-5){ # 실수 데이터에서 ==는 abs(x-y) < 1e-5로 사용한다. 
    return(1)
  } else if (D > 0 ){
    return(2)
  } else {
    return(0)
  }
}
myreadD(a,b,c)
  
  









