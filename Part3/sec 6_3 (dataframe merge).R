#--------------------------------------------------------------#
#               코딩에서 가장 중요한 것 두 가지                  #
#                                                              #
#                        1. Indentation                        #
#                                                              # 
#                        2. Comment                            #
#--------------------------------------------------------------#


#--------------------------------------------------------------#
#-------------- section 6 : R Data frame 다루기 ----------------#
#--------------------------------------------------------------#


# 6.5.1 벡터로부터 데이터 프레임 생성하기 --------------------------------------------------------------

no <- c(1:4)
name <- c('apple','peach','banana','grape')
price <- c(500,200,100,50)
qty <- c(5,2,4,7)

sales <- data.frame(NO = no,
                    NAME = name,
                    PRICE = price,
                    QTY = qty); sales

# 6.5.2 행렬로부터 데이터 프레임 생성하기 ---------------------------------------------------------------

sales2 <- matrix(c(1,'Apple',500,5,
                   2,'peach',200,2,
                   3,'banana',100,4,
                   4,'grape',50,7), nrow=4, byrow=T)    # 데이터 모양은 같으나 데이터 형태의 차이가 있다.

df1 <- data.frame(sales2); df1
names(df1) <- c('NO','NAME','PRICE','QTY'); df1         # 데이터프레임의 라벨명 붙이기


# 6.5.3 데이터 프레임에서 원하는 데이터만 조회하기 - 기본 패키지 ----------------------------------------

sales$NAME; class(sales$NAME)                           # data.frame의 Key 값은 기본적으로 factor 형태다.
sales[1,3]                                              # data.frame의 1행 3열 값을 출력한다.
sales[1,]                                               # data.frame의 1행, 모든열의 값을 출력한다. 
sales[,3]                                               # data.frame의 모든 행, 3열의 값을 출력한다.
sales[c(1,3),]                                          # data.frame의 1, 3행과 모든 열의 값을 출력한다. 
sales[,-c(1,4)]                                         # data.frame의 모든 행과 1, 4열을 제외한 값을 출력한다. 

str(sales)                                              # data.frame의 행 개수, 변수 개수, 데이터 형태 등을 볼 수 있다.

# 6.5.4 특정 조건에 맞는 데이터만 조회하기 - 기본 패키지 (subset) ---------------------------------------

subset(sales, qty<5)                                    # subset(x, condition) 
subset(sales, price==500)                               # sales 에서 price가 500인 obs를 출력한다. 
subset(sales, price!=500)                               # sales 에서 price가 500이 아닌 obs를 출력한다. 
subset(sales, name=='grape')                            # sales 에서 name이 grape인 obs를 출력한다. 단, 문자는 ""가 필수다.

subset(sales, select = NAME)                            # select 옵션으로 원하는 열만 조회 가능
subset(sales, select = -NAME)                           # 제외도 가능 
sales[which(sales$PRICE >= 150),]                       # index로 특정 조건에 맞는 행 추출 

# 6.5.5 데이터 프레임에서 특정 컬럼(열)들만 골라 새로운 형태 만들기 - subset ------------------------------

no <- c(1:5)
name <- c("서진수",'주시현','최경우','이동근','윤정웅')
address <- c('서울','대전','포항','경주','경기')
tel <- c(111,222,333,444,555)
hobby <- c('독서','미술','놀고먹기','먹고놀기','노는애감시하기')

member <- data.frame(NO=no,
                     NAME=name,
                     ADDRESS=address,
                     TEL=tel,
                     HOBBY=hobby); member

member2 <- subset(member, select=c(NO,NAME,TEL)); member2           # member 데이터에서 NO, NAME, TEL 변수만 추출하기 
member3 <- subset(member, select= -TEL); member3                    # member 데이터에서 TEL 변수만 빼고 추출하기 

colnames(member3) <- c('번호오','이르음','주우소','X_DD..취미'); member3
colnames(member3)[4] <- "취미"; str(member3)                        # 임의의 변수명을 선택해 바꾸기                   
colnames(member3)[1:3] <- c("번호","이름",'주소'); str(member3)     # 다수도 가능 

# 6.5.6 데이터 프레임 합치기 - rbind, cbind, merge ------------------------------------------------------

# 6.5.6.1 rbind, cbind

no <- c(1:3)
name <- c('apple','banana','peach')
price <- c(100,200,300)

df1 <- data.frame(NO = no,
                  NAME = name,
                  PRICE = price); df1

no <- c(10,20,30)
name <- c('train','car','airplane')
price <- c(1000,2000,3000)

df2 <- data.frame(NO = no,
                  NAME = name,
                  PRICE = price); df2


df3 <- cbind(df1,df2); df3
df3$NAME                                                # 앞에있는 과일만
df3[,5]                                                 # 뒤에있는 탈 것들

df4 <- rbind(df1,df2); df4

name <- c('apple','banana','cherry')
price <- c(300,200,100)
df5 <- data.frame(name = name,
                  price = price); df5

name <- c('apple','cherry','berry')
qty <- c(10,20,30)
df6 <- data.frame(name = name,
                  qty = qty); df6

new <- data.frame(name="mango",price=400)
df5 <- rbind(df5, new); df5

df5 <- rbind(df5, data.frame(name="mango",price=400)); df5
df5 <- cbind(df5, data.frame(quantity=c(10,20,30,40,50))); df5

# 6.5.6.2 Merge 
# dataset

# 1. Inner_join : 특정기준에서 A와 B 둘다 포함된 항목만 병합
merge(df5, df6, all=F)

# 2. Outer_join : A와 B전체를 병합
merge(df5, df6, all=T)

# 3. Left_join : A를 기준으로 B를 병합
merge(df5, df6, all.x = T)
merge(df5, df6, by='name',all.x = T)

# 4. Right_join : B를 기준으로 A를 병합 
merge(df5, df6, all.y = T)
merge(df5, df6, by=,'name',all.y = T)


# 연습해보기 : 참고 (https://m.blog.naver.com/PostView.nhn?blogId=coder1252&logNo=220953760651&proxyReferer=https%3A%2F%2Fwww.google.com%2F)

merge_df1<-data.frame(name = c('Yoon', 'Seo', 'Park', 'Lee', 'Kim', 'Kang'),
                age = c(30, 31, 22, 24, 28, 25)); merge_df1

merge_df2<-data.frame(name = c('Park', 'Lee', 'Kim', 'Kang', 'Ahn', 'Go'),
                gender=c('f', 'f', 'm', 'm', 'f', 'm'),
                city = c('Seoul', 'Incheon', 'Seoul', 
                         'Busan', 'Gwangju', 'Deagu')); merge_df2
# test 1 : Inner_join
merge(merge_df1,merge_df2,by='name',all=F)   # name을 기준으로 df1, df2에 공통으로 들어있는 이름에 대해서만 조인

# test 2 : Outer_join
merge(merge_df1,merge_df2,all=T)             # 아무 기준 없이 df1, df2 모두 합치기

# test 3 : Left_join
merge(merge_df1,merge_df2,by='name',all.x=T) # df1의 name 기준으로 조인

# test 4 : Right_join
merge(merge_df1,merge_df2,by='name',all.y=T) # df2의 name 기준으로 조인 

# 6.5.7 기타 데이터 프레임 관련 함수 - ncol, nrow, rownames, colnames ------------------------------

# ncol() : 열의 개수 
ncol(sales)

# nrow  : 행의 개수 
nrow(sales)

# names : 열의 이름 
names(sales)

# rownames : 행의 이름
rownames(sales) 

# colnames : 열의 이름
colnames(sales) 이름

# dataframe[c(1,3,2,4),] : 행에서 데이터 출력 순서 변경 
sales[c(1,3,2,4),]

# dataframe[,c(1,3,2,4)] : 열에서 데이터 출력 순서 변경 
sales[,c(1,3,2,4)]

rm(list = ls())
