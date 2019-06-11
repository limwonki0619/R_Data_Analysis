getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part3/data")
setwd("D:/limworkspace/R_Data_Analysis/Part3")
getwd()

#--------------------------------------------------------------#
#----------------- section 9 : 조건문과 반복문 ----------------#
#--------------------------------------------------------------#


# 9.5 while 반복문

number <- 0
while (number < 5) {
  print(number)
  number <- number + 1
}

number <- 0
while (number < 4) {
  print(number)
  if (number == 3) {
    break 
    }                       # break : 루프를 빠져나와라
    number <- number + 1                
}

number <- -1                # 10이하의 짝수를 나타내라
while (number < 10) {
  number <- number + 1
  if (number %% 2 == 1) {
    next 
  } else {
    print(number)
  }
}

number <- 0 # 10의 약수를 구하라 
while(number < 10) {
  number <- number + 1
  if( 10%%number == 0) { 
    print(number)
  } else { 
    next
  } 
}

# 9.6 for 반복문 - for (변수 in 범위)

for (i in 1:10) {
  print(i)
}

sum <- 0
for (i in 1:3) { # 1~100까지 모두 더하기
  sum <- sum + i 
}
print(sum)

sum <- 0
for (i in 1:100) { # 3의 배수 더하기 
  if (i%%3==0) {
    sum <- sum + i
  }
}

sum <- 0
for (i in seq(3,100,3)) { # 3의 배수 더하기2
  sum <- sum + i
}
print(sum)

multiple <- function(limit, number) { # number의 배수 구하기 limit 까지
  sum <- 0
  for (i in 1:limit) {
    if(i%%number == 0) {
      sum <- sum + i
    } 
  } 
  return(sum)
} 

multiple(1000, 4)


text <- readLines("채소.txt")
x <- 0
while (x < 5) { # 3번째 라인만 넘어가고 나머지 출력 
  x <- x+1
  if (x==3) { 
    next
  } else {
    print(text[x]) 
  }
}

x <- 0
while(x<5){
  x <- x+1
  if(text[x]=="버섯") {
    next 
  } else {
    print(text[x]) 
  }
}


# Nested for - loop 
while (T) {
  
for (i in 5:1) {
  line <- ''
  for (k in i:5) {
    line <- paste0(line,'#')
  }
  print(line)
}
for (i in 1:5) {
  line <- ''
  if (i != 1) {
    for(k in 1:(i-1))
    line <- paste0(line, ' ')
  }
  for (k in i:5) {
    line <- paste0(line, '#')
  }
  print(line)
}
break;
}



# for 연습문제 1
for (i in seq(10,30,10)) {
  print(paste0(i,'번 학생 손드세요'))
} 

text <- NULL
for (i in 1:10) {
  text[i] <- paste0(i*10,'번 학생 손드세요')
  print(text[i])
} 

text

# for 연습문제 2 - 구구단
for (i in 2:9){
  print(paste(i,"단"))
  for (j in 1:9) {
    print(paste(i,"x",j,"=",i*j))
  }
}

# for 연습문제 3 - Nested for - loop 


#
##
###
####
##### 그리기

for (i in 1:5) {
  line <- ''
  for (k in 1:i) {
    line <- paste0(line, '#')  
  }
  print(line)
}

#####
####
###
##
# 그리기

for (i in 5:1) {
  line <- ''
  for (k in 1:i) {
    line <- paste0(line, '#')  
  }
  print(line)
}


#####
 ####
  ###
   ##
    # 그리기
for (i in 1:5) {
  line <- ''
  if (i != 1) {
    for (k in 1:(i-1)) {
      line <- paste0(line, ' ')
    }
  }
  for (k in i:5) {
    line <- paste0(line, '#')
  }
  print(line)
}

   #
  ###
 #####
#######
 #####
  ###
   #

while (T) { # 마름모 모양 
  for (i in 1:4) {
    line <- ''
    if( i != 4) {
      for (k in 1:(4-i)) { 
        line <- paste0(line, " ")
      }
    }
    for (l in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  for (i in 3:1) {
    line <- ''
    for (k in 1:(4-i)) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  break
}

#######
 #####
  ###
   #
  ###
 #####
########

while (T) { # 모래시계 모양
  for (i in 4:1) {
    line <- ''
    if( i != 4) {
      for (k in 1:(4-i)) { 
        line <- paste0(line, " ")
      }
    }
    for (l in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  for (i in 2:4) {
    line <- ''
    if (i != 4) {
      for (k in 1:(4-i)) {
        line <- paste0(line, " ")
      }
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  break
}

# for 연습문제 4 - 약수 구하는 함수
getDenominator <- function(x) {
  den <- c(1)
  if(x >= 2) {
    for (i in 2:x) {
      if ( x %% i == 0)
        den <- c(den,i)
    }
  }
  return(den)
}
getDenominator(854)




