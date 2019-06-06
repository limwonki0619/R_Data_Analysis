getwd()
setwd("D:/limworkspace/R_lecture/Part3/data")
setwd("D:/limworkspace/R_lecture/Part3")
getwd()

#--------------------------------------------------------------#
#------------------- section 10 : 정규표현식 ------------------#
#--------------------------------------------------------------#

# 10.1 정규식에서 사용되는 주요 기호들과 의미 - 검색해보자-----------------------------------------------------------------------------

# 10.2 특정패선만 골라내기 - grep(pattern, a) // str_detect와 기능이 비슷 -------------------------------------------------------------
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


# 10.3 문자열의 길이 알아보기 - nchar(a) ---------------------------------------------------------------------------------------------

nchar('apple')            
nchar("이젠컴퓨터학원")

# 10.4 문자열 붙이기 - paste('a','b')   # a와 b를 붙이기 // str_c 함수와 비슷 --------------------------------------------------------

paste('lim','won','ki')                 # 빈칸이 기본값
paste('lim','won','ki', sep = '')       # 빈칸도 없음 = paste0와 같은기능 
paste('lim','won','ki', sep = '//')     # 특정문자를 사이에 끼워넣을 수 있음

# 10.5 문자열 일부분 가져오기 - substr(data, start,end) ------------------------------------------------------------------------------

substr('abc123',1,3)
substr('abc123',3,4)

# 10.6 문자열을 특정 문자로 분리 - strsplit('문자열', split='기준문자') // list형태로 출력 -------------------------------------------

strsplit('2014/11/22', split = '/')

# 10.7 특정패턴이 처음 나오는 위치 가져오기 - regexpr('pattern', text) ---------------------------------------

grep("-",'010-1234-4567')
regexpr('-','010-1234-4567')

# 자주 쓰이는 정규식 표현 ------------------------------------------------------------------------------------

# https://statkclee.github.io/ds-authoring/index.html 정규식 실습

library(stringr)
setwd("D:/limworkspace/R_lecture/Part3/data/STAT545-UBC.github.io")
list.files()

gDat <- read.delim("gapminderDataFiveYear.txt")

grep("^gap",list.files(), value = T)
grep("")

# 문자열 내부 패턴 위치 --------------------------------------------------------------------------------------

# \\d Digit, 0, 1, 2 ...
# \\D 숫자가 아닌것
# \\s 공백
# \\S 공백이 아닌 것
# \\w 단어
# \\W 단어가 아닌 것
# \\t Tab
# \\n New line 
# ^A  대문자 A로 시작되는 글자
# e$  소문자 e로 끝나는 글자
# \   탈출문자
# | 두개 이상의 조건을 동시에 지정

text1 <- c("abcd", "cdab", "cabd", "c abd", "abc ab")
grep("ab", text1, value = T)  # ab가 포함된 모든 문자 출력
grep("^ab", text1, value = T) # ab로 시작되는 문자 출력
grep("ab$", text, value = T)  # ab로 끝나는 문자 출력 
grep(".txt$", list.files(), value = T) # .txt로 끝나는 문자 출력

# 정량자 -----------------------------------------------------------------------------------------------------

# i+        i가 최소 1회는 나오는 경우
# i*        i가 최소 0회 이상 나오는 경우
# i?        i가 최소 0회에서 최대1회만 나오는 경우
# i{n}      i가 연속적으로 n회 나오는 경우
# i{n, m}   i가 n~m회 나오는 경우
# i{n,}     i가 n회 이상 나오는 경우

text2 <- c("a", "ab", "acb", "accb", "acccb", "accccb", "acccpcb")

grep("ac*b", text2, value = T)     # text에서 acb 패턴은 찾는데 c문자는 적어도 0번 매칭 (0번 이상 ~)
grep("ac+b", text2, value = T)     # acb 패턴 중 c가 적어도 1번 매칭되는 경우 (1번 이상 ~ )
grep("ac?b", text2, value = T)     # acb 패턴 중 c가 많아요 1번 매칭되는 경우 (0~1번)
grep("ac{2}b", text2, value = T)   # acb 패턴 중 c가 연속적으로 2번만 매칭되는 경우 
grep("ac{2,}b", text2, value = T)  # acb 패턴 중 c가 연속적으로 2번 이상 나오는 경우
grep("ac{2,3}b", text2, value = T) # acb 패턴 중 c가 2~3번 매칭되는 경우


# 연산자 ----------------------------------------------------------------------------------------------------

# .      어떤 문자 하나와 매칭
# [...]  문자리스트, [] 내부에 지정된 문자중 하나와 매칭, 문자범위를 지정하는데 -도 사용 가능 
# [^...] 반전문자 리스트, [] 내부에 있는 문자를 제외한 문자를 매칭 
#    |   or 연산자, 어느쪽에든 패턴을 매칭 
#    \   정규표현식 메타문자가 갖는 특수한 의미를 억제

# [ab]  a 또는 b
# [^ab] a또는 b를 제외한 모든 문자
# [0-9] 모든 숫자
# [A-Z] 대문자 A부터 대문자 Z까지 영문자
# [a-z] 소문자 a부터 소문자 z까지 영문자
# [A-z] 대문자 A부터 소문자 z까지 모든 영문자

text3 <- c("^ab", "ab", "abc", "abd", "abe", "ab 12")
grep("ab.", text3, value = T)     # ab패턴과 아무 문자가 결함한 형태만 출력 
grep("ab[c-e]", text3, value = T) # ab패턴과 c ~ e문자가 결합한 형태만 출력 
grep("ab[^c]", text3, value = T)  # ab패턴과 c가 결합한 형태를 제외한 나머지 출력 
grep("\\^ab", text3, value = T)   # ^ab패턴만을 출력 단, ^를 출력하기 위해 \\를 사용 
grep("abc|abd", text3, value = T) # abc 또는 abd 패턴을 출력
gsub("(ab) 12", "\\1 34", text3)  # ab패턴을 찾아 12를 34로 바꾼다(?)


# 문자열 클래스 ---------------------------------------------------------------------------------------------

# [:alnum:]  문자와 숫자가 나오는 경우  [:alpha:] and [:digit:]
# [:alpha:]  문자가 나오는 경우 [:lower:] and [:upper:]
# [:blank:]  공백이 있는 경우 ex) tab space
# [:cntrl:]  제어문자가 있는 경우 ex) \n \r 등 
# [:digit:]  digit 0~9
# [:graph:]  Graphical character 
# [:lower:]  소문자가 있는 경우
# [:upper:]  대문자가 있는 경우
# [:print:]  출력가능한 모든 문자 
# [:punch:]  특수문자, 구두점 문자 등  ex) ! " # $ % - ; 등등
# [:space:]  공백문자
# [:xdigit:] 16진수가 있는 경우


# 패턴에 대한 모드 ------------------------------------------------------------------------------------------

# 정규표현식에 대해 서로다른 구문 표준이 존재한다. 
# 1. POSIX 확장 정규표현식 (R에서 기본설정)
# 2. 펄(Perl) 정규표현식
# grep, sub 같은 R base 함수에서 perl = F/T 옵션을 통해 모드전환이 가능하다 


# 패턴의 고정 -----------------------------------------------------------------------------------------------

# R base 함수에서 fixed = T/F 옵션으로 명세하거나 stringr 패키지에서 fixed()함수로 감싼다.
# 예를 들어 정규표현식을 "A.b"로 정의하면 "A" 다음에 임의 문자하나 다음 "b"패턴을 갖는 문자열을 매칭하지만
# 고정패턴(fixed=T)로 정의하면 문자그대로 "A.b"패턴을 매칭한다

text4 <- c("Axbc", "A.bc")
grep("A.b", text4, value = T)             # A 다음 모든 문자 b 패턴을 찾는다
grep("A.b", text4, value = T, fixed = T)  # A.b 패턴을 찾는다 


