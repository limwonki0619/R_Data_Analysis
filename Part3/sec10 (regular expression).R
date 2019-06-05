getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")
setwd("D:/limworkspace/R_lecture/Part3")
getwd()

#--------------------------------------------------------------#
#------------------- section 10 : 정규표현식 ------------------#
#--------------------------------------------------------------#

# 10.1 정규식에서 사용되는 주요 기호들과 의미 - 검색해보자------------------------------------------------

# 10.2 특정패선만 골라내기 - grep(pattern, a) // str_detect와 기능이 비슷 

char <- c('apple','Apple','APPLE','banana','grape')
grep('apple',char1)

char2 <- c('apple','banana')
grep(char2, char)
grep(paste(char2,char),value=T)

grep('pp', char)                        # 매칭되는 단어의 위치 찾기 
grep('pp', char, value = T)             # 매칭되는 단어 찾기

grep('^A', char, value = T)             # 대문자 A로 시작하는 단어 찾기 
grep('e$', char, value = T)             # 소문자 e로 끝나는 단어 찾기


char3 <- c('grape1','apple1','apple','orange','Apple')
grep('ap', char3, value = T)            # ap가 포함된 단어 찾기
grep('[1-9]', char3, value = T)         # 숫자가 포함된 단어 찾기 
#grep('\\d', char3, value = T)

grep('[A-Z]', char3, value = T)         # 대문자가 포함된 단어 찾기 
#grep('[[:upper:]]', char3, value = T)  # 대문자가 포함된 단어 찾기 


# 10.3 문자열의 길이 알아보기 - nchar(a)

nchar('apple')            
nchar("이젠컴퓨터학원")

# 10.4 문자열 붙이기 - paste('a','b')   # a와 b를 붙이기 // str_c 함수와 비슷 

paste('lim','won','ki')                 # 빈칸이 기본값
paste('lim','won','ki', sep = '')       # 빈칸도 없음 = paste0와 같은기능 
paste('lim','won','ki', sep = '//')     # 특정문자를 사이에 끼워넣을 수 있음

# 10.5 문자열 일부분 가져오기 - substr(data, start,end)

substr('abc123',1,3)
substr('abc123',3,4)

# 10.6 문자열을 특정 문자로 분리 - strsplit('문자열', split='기준문자') // list형태로 출력

strsplit('2014/11/22', split = '/')

# 10.7 특정패턴이 처음 나오는 위치 가져오기 - regexpr('pattern', text)

grep("-",'010-1234-4567')
regexpr('-','010-1234-4567')
