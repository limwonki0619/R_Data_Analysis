getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part4")
setwd("D:/limworkspace/R_Data_Analysis/Part4/data")
setwd("D:/limworkspace/R_Data_Analysis/Part4/graph")
getwd()

#--------------------------------------------------------------#
#------------------ Part 4 : Visualization --------------------#
#------------------ Section 1 : 시각화 기본 -------------------#
#--------------------------------------------------------------#

# 1. 시각화 기초함수 ---------------------------------------------------------------------------------------------

# plot 함수의 다양한 옵션들 --------------------------------------------------------------------------------------

#  main        메인제목
#  sub         서브제목
#  xlab, ylab  축 라벨 설정 // ann=F 축 라벨 사용 안함 // 
#  tmag        제목 등에 사용되는 문자의 확대율 지정 
#  axes=F      x,y축 표시 안함
#  axis        x,y축을 사용자의 지정값으로 표시 
#  xlim, ylim  x,y축 한계값 지정하기

# 그래프타입 선택 ------------------------------------------------------------------------------------------------

# type="p"    점 모양 그래프(기본값)
#       l     선 모양 (꺾은선 그래프)
#       b     점과 선 모양
#       c     "b"에서 점을 생략한 모양 
#       o     점과 선을 중첩해서 그린 모양
#       h     각 점에서 x축 까지의 수직선 그래프 
#       s     왼쪽 값을 기준으로 계단모양으로 연결한 그래프
#       S     오른쪽 값을 기준으로 계단모양으로 연결한 그래프
#       n     축만 그리고 그래프는 그리지 않음 

# 선의 모양 선택 -------------------------------------------------------------------------------------------------

# lty="blank"    // 0   투명선
#     "solid"    // 1   실선
#     "dashed"   // 2   대쉬선
#     "dotted"   // 3   점선
#     "dotdash"  // 4   점선과 대쉬선
#     "longdash" // 5   긴 대쉬선
#     "twodash"  // 6   2개의 대쉬선 

# 색, 기호 등  ----------------------------------------------------------------------------------------------------

# col = 1, col = "blue" 기호의 색 지정 
# pch = 0, pch="문자"   점의 모양을 지정합니다
# bg = " blue"          그래프의 배경색을 지정 
# lwd ="3"              선의 굵기를 지정
# cex = "3"             점이나 문자의 굵기 지정 

# R 색상표

# 1.1 plot(x, y, 옵션) --------------------------------------------------------------------------------------------

plot(1:5)
plot(5:1)
plot(c(2,2,2))                              # y축 값을 동일하게 설정해서 출력하기
x <- seq(-3,3,0.01)
plot(x,dnorm(x, mean=0, sd=1), type = "l")

x <- 1:3
y <- 4:2
plot(x,y)                                   # x축, y축 지정하기
plot(x,y,xlim = c(0,5), ylim = c(0,5))      # x,y축 한계값 지정 
plot(x,y,xlim = c(0,5), ylim = c(0,5),
         xlab = "x축 값", ylab = "y축 값",
         main = "Plot Test") 

v1 <- c(100,130,120,160,150)
plot(v1, type="o", col="red", ylim = c(0,200),
     axes = F, ann = F)

axis(1, at=1:5, lab=c("MON","TUE","WED","THU","FRI")) # x축 : 1
axis(2, ylim=c(0,200))                                # y축 : 2

title(main = "FRUIT", col.main = "red", font.main=3)  # 기본 plot 함수는 축, 레이블 등등을 하나하나 지정해줘야 함 
title(xlab="DAY", col.lab="Black")
title(ylab="PRICE", col.lab="blue")


# 1.1.1 여러 그래프 그리기 - par(mfrow = c(nr,nc)) nr:행의 갯수, nc 열의 갯수 --------------------------------------------

par(mfrow = c(2,3))
plot(v1, type="o")
plot(v1, type="s")
plot(v1, type="l")
pie(v1)
barplot(v1)
hist(v1)

par(mfrow = c(1,1))   # 원위치

# 1.1.2 그래프 여백 조절하기 - par(mgp = c(0,1,0)) - mpg(라벨위치, 지표값위치, 지표선위치) -------------------------------

par(mgp = c(3.25,2,1))
plot(v1, type="o", xlab = "X")

# oma 옵션 - par(mga=c(2,1,0,0))

par(oma = c(0,1,0,1)) # (아래, 왼쪽, 위, 오른쪽)
plot(v1, type="o", xlab = "X")

par(oma = c(0,0,0,0)) # (아래, 왼쪽, 위, 오른쪽)

# 1.1.3 그래프 중첩시키기 - par(new=T) ----------------------------------------------------------------------------------

v1 <- 1:5
v2 <- 5:1
v3 <- 3:7
par(mgp = c(2,1,0))
plot(v1, type = "s", col="red", ylim = c(1,7), ylab="")
par(new=T)  # 중복 허용 
plot(v2, type = "o", col="blue", ylim = c(1,7), ylab="")
par(new=T)  # 중복 허용 
plot(v3, type = "l", col="green", ylim = c(1,7), ylab="")

# 1.1.4 그래프 범례 추가하기 - legend(x축 위치, y축 위치, 내용, cex=글자크기, col=색상, pch=크기, lty=선모양) -----------

par(mgp = c(2,1,0))
plot(v1, type = "s", col="red", ylim = c(1,10), ylab="")
par(new=T)  # 중복 허용 
plot(v2, type = "o", col="blue", ylim = c(1,10), ylab="")
par(new=T)  # 중복 허용 
plot(v3, type = "l", col="green", ylim = c(1,10), ylab="")
legend(4.15, 9.5, c("v1","v2","v3"),
       cex=0.9, col=c("red","blue","green"), lty=1)

# 1.2 barchart : 막대그래프 그리기 --------------------------------------------------------------------------------------

# barchart 옵션 

# angle, density, col  막대를 칠한느 선분의 각도, 선분의 수, 선분의 색 지정
# legned             범례
# names              각 막대의 라벨을 정한느 문자열 벡터를 지정
# width              각 막대의 상대적인 폭을 벡터로 지정
# space              각 막대 사이의 간격을 지정
# beside             TRUE : 각각의 값마다 막대를 그린다, FALSE : 막대를 중첩해서 그린다
# horiz              TRUE : 막대를 옆으로 높힌다         FALSE : 기본 

x <- matrix(c(5,4,3,2), nrow=2)
par(mfrow=c(3,3))
barplot(x, beside=T, names=c(5,3), col=c("MediumTurquoise","Coral"))    # 막대값 각각 그래프 생성
barplot(x, beside=F, names=c(5,3), col=c("DeepSkyblue","salmon"))       # 막대값을 중첩해서 생성 
barplot(x, horiz=T, names=c(5,3), col=c("Orchid","MediumSpringGreen"))  # 색상 변경   
barplot(x, horiz=F, names=c(5,3), col=c("LightSkyBlue","Pink1"))        
barplot(x, horiz=F, names=c(5,3), col=c("IndianRed2","PaleGreen2"))     
barplot(x, horiz=F, names=c(5,3), col=c("Plum","LightGoldenrod1"))      
barplot(x, horiz=F, names=c(5,3), col=c("Sienna","OliveDrab"))  
barplot(x, horiz=F, names=c(5,3), col=c("CadetBlue2","Mediumpurple1"))  
barplot(x, horiz=F, names=c(5,3), col=c("PaleVioletRed1","Gray40"))  

par(mfrow=c(1,1))

banana <- seq(100,200,20)
cherry <- seq(100,150,10)
orange <- seq(150,200,10)

qty <- data.frame(banana, cherry, orange)
barplot(as.matrix(qty), main = "Fruit`s Sales QTY",
        beside = T, 
        col=rainbow(nrow(qty)),
        ylim = c(0,400))

legend(14, 400, c("MON","TUE","WED","THU","FRI"), # 왼쪽상단 기준으로 생각 
       cex=0.8, # 글자크기 
       fill=rainbow(nrow(qty))) # 범례색상 채우기 


barplot(t(qty), 
        main = "Fruit`s Sales QTY", # t는 전치행렬 transpose 행 -> 열 
        ylim = c(0,900),
        col=rainbow(length(qty)),
        space = 0.1,
        cex.axis = 0.8,
        las=1,
        names.arg = c("MON","TUE","WED","THU","FRI","SAT"), 
        cex=0.8)

legend(0.2, 800, names(qty), cex=0.7, fill=rainbow(length(qty)))

qty; t(qty) # 전치행렬!! 

peach <- c(180,200,250,198,170)
colors <- c()

for (i in 1:length(peach)) { # for문으로 색상 지정 
  if(peach[i] >= 200) {
    colors <- c(colors, "red")
  }
  else if(peach[i] >= 180) {
    colors <- c(colors, "yellow")
  }
  else {
    colors <- c(colors, "green")
  }
}

barplot(peach, main="Peach Sales QTY",
        names.arg = c("MON","TUE","WED","THU","FRI"),
        col=colors)

# 1.3 히스토그램 그래프 그리기 : hist() - 구간에 따른 도수 나타내기 ------------------------------------------------------

height <- c(182,175,167,172,163,178,181,166,159,155)
par(mfrow=c(1,2))

barplot(height)
hist(height)

par(mfrow=c(1,1))


# 1.4 파이차트 그리그 : pie() --------------------------------------------------------------------------------------------

# 파이차트 옵션

# angle, density, col        pie 부분을 구성하는 각도, 수, 색상을 지정 
# labels                     각 pie 부분의 이름을 지정
# radius                     원의 크기를 지정 
# clockwise                  시계방향으로 회전할지(T), 반 시계방향(F)으로 회전할지 지정 
# init.angle                 시작되는 지점의 각도를 지정 


par(mfrow=c(2,2))
p1 <- seq(10,40,10)
pie(p1, radius=1)
pie(p1, radius=1, init.angle = 90)
pie(p1, radius=1, init.angle = 90, col=rainbow(length(p1)))
pie(p1, radius=1, init.angle = 90, col=rainbow(length(p1)),
        label = c("Week 1", "Week 2", "Week 3", "Week 4"))

par(mfrow=c(1,1))

pct <- round(p1/sum(p1)*100,1)
lab1 <- c("Week 1","Week 2","Week 3", "Week 4")
lab2 <- paste0(lab1,"\n", pct,"%")

pie(p1, radius=0.5, init.angle = 90, col=rainbow(length(p1)),
    label = lab2)
legend(0.7, 1.0, c("Week 1","Week 2","Week 3", "Week 4"),
       cex=0.5, fill=rainbow(length(p1)))

# pie3D() - plotrix 패키지 

install.packages("plotrix")
library(plotrix)

p1 <- seq(10,50,10)
f_day <- round(p1/sum(p1)*100,1)
f_label <- paste0(f_day, "%")
pie3D(p1, main="3D pie Chart",
      col=rainbow(length(p1)),
      cex=0.1, 
      labels=f_label,         # labels !! 
      explode=0.1)            #
?title

# 1.5 상자차트 - boxplot() ---------------------------------------------------------------------------------------------------

# boxplot 옵션들 

# col        박스 내부의 색을 지정 
# names      각 막대의 라벨을 지정할 문자벡터를 지정
# range      박스 끝에서 수염까지의 길이를 지정 (기본 1.5)
# width      박스의 폭을 지정 
# notch      TRUE로 지정할 경우 상자의 허리 부분을 가늘게 표시
# horizontal TRUE로 지정하면 상자를 수평으로 그린다 

str(iris)

boxplot(iris[,1:4], col = c("CadetBlue2","Mediumpurple1","Coral","DeepSkyblue"),
        horizontal = T)

# 1.6 관계도 그리기 - igraph() 함수 ------------------------------------------------------------------------------------------

install.packages("igraph")
library(igraph)

?igraph
g1 <- graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6))
plot(g1)


name <- c("서진수", "일지매", "김유신", "손흥민", "노정호", "이순신", "유관순", "신사임당", "강감찬", "광개토", "정몽주")
pemp <- c("서진수", "서진수", "일지매", "김유신", "김유신", "서진수", "이순신", "유완순", "서진수", "강감찬", "광개토")

emp <- data.frame(이름=name, 상사이름=pemp)
g <- graph.data.frame(emp, directed = T)    # directed = T (화살표 표시) F (화살표 제거)

plot(g, layout=layout.fruchterman.reingold,
        vertex.size = 8,                    # 라벨 크기 
        edge.arrow.size =0.5,               # 화살표 크기 
        vertex.label = NA )                 # 라벨 삭제

# igraph 선 관련 옵션 

# edge.color        선의 색상
# edge.width        선의 폭
# edge.lty          선의 유형 // solid, dashed, dotted

# edge.label.family 선 레이블 종류 // serif, sans, mono
# edge.label.font   선 레이블 형태 // 1 일반 2 볼드 3 이탤릭 4 볼드 이탤릭 
# edge.label.color  선 레이블 색상 

# edge.arrow.size   화살의 크기
# edge.arrow.width  화살의 폭 
# edge.arrow.mode   화살의 모양 

# 점 관련 옵션 

# vertex.size           점 크기 지정
# vertex.frame.color    점 윤곽의 색 
# vertex.color          점의 색 지정
# vertex.shape          점 형태 지정

# vertex.label.family   점 레이블 종류
# vertex.label.cex 점   레이블 크기
# vertex.label.degree   점 레이블 방향 
# vertex.label          점 레이블 
# vertex.label.font     점 레이블 폰트
# vertex.label.dist     점 중심과의 거리
# vertex.label.color    점 레이블 색상

# 1.7 d3Network -----------------------------------------------------------------------------------------------------------

install.packages("devtools")
library(devtools)
install.packages("d3Network")
library(d3Network)
install.packages("RCurl")
library(RCurl)
name <- c('Angela Bassett','Jessica Lange','Winona Ryder','Michelle Pfeiffer',
          'Whoopi Goldberg','Emma Thompson','Julia Roberts','Sharon Stone','Meryl Streep',
          'Susan Sarandon','Nicole Kidman')
pemp <- c('Angela Bassett','Angela Bassett','Jessica Lange','Winona Ryder','Winona Ryder',
          'Angela Bassett','Emma Thompson', 'Julia Roberts','Angela Bassett',
          'Meryl Streep','Susan Sarandon')
emp <- data.frame(이름=name,상사이름=pemp)
d3SimpleNetwork(emp, width=600, height=600, file="D:/limworkspace/R_lecture/Part4/d3.html")

g <- read.csv("data/군집분석.csv", header =T)
graph <- data.frame(학생=g$학생, 교수=g$교수)

g <- graph.data.frame(graph, directed = T)

plot(g, layout=layout.fruchterman.reingold, # circle, kamada.kawai 등등 다양한 layout이 있음
        vertex.size=3,
        edge.arrow.size = 0.25,
        vertex.color = "DeepSkyblue",
        vertex.label = NA)

library(stringr)

V(g)$name
gubun1 <- V(g)$name
gubun <- str_sub(gubun1, start=1, end=1)

# 색 구분 짓기

colors <- c()
sizes <- c()
shape <- c()
for (i in 1:length(gubun)) { # for문으로 색상, 크기, 모양 지정 
  if(gubun[i]=="S") {
    colors <- c(colors, "PaleVioletRed1")
    sizes <- c(sizes, 4)
    shape <- c(shape, "circle")
  }
  else {
  colors <- c(colors, "DeepSkyblue")
  sizes <- c(sizes, 6)
  shape <- c(shape, "square")
  }
}

plot(g, layout = layout.auto,
        vertex.size = sizes,
        edge.arrow.size = 0.01,
        vertex.color = colors,
        vertex.label = NA,
        vertex.shape = shape) # 점 모양 변경 

virus1 <- read.csv("data/메르스전염현황.csv", header =T)
d3SimpleNetwork(virus1, width=1200, height = 900, file ="D:/limworkspace/R_lecture/Part4/mers.html" )

# 참고카페 : http://cafe.naver.com/theareum/243

# 1.8 treemap - 기준값의 면적을 보여줌 --------------------------------------------------------------------------------------

install.packages("treemap")
library(treemap)

total <- read.csv("data/학생시험결과_전체점수.csv", header=T)
treemap(total,vSize = "점수", index=c("점수","이름"))
treemap(total,vSize = "점수", index=c("조","이름"))
treemap(total,vSize = "점수", index=c("점수","이름","조"))


str(total)

# 1.9 stars 함수로 비교 분석하기 ---------------------------------------------------------------------------------------------

total <- read.table("data/학생별전체성적_new.txt", header=T,sep= ",")
class(total)

row.names(total) <- total$이름
total2 <- total[,-1]
stars(total, flip.labels= FALSE,
      draw.segments = TRUE,                         # TRUE 색 입히기 나이팅게일 차트, FALSE 색 없애기
      frame.plot = FALSE,                           # TRUE 테두리 생성, FALSE 테두리 삭제 
      full = FALSE,                                  # TRUE 원, FALSE 반원 차트
      main = "학생별 과목별 성적분석 - STAR CHART")

lab <- names(total2)
value <- table(lab)
color <- c("black","red","green","blue","cyan","violet")
pie(value, labels = lab, col=color, radius = 0.1, cex = 0.6)

# 1.10 radarchart 함수로 비교 분석하기 ---------------------------------------------------------------------------------------

install.packages("fmsb")
library(fmsb)

layout <- data.frame(분석력 = c(5,1),
                     창의력 = c(15,3),
                     판단력 = c(3,0),
                     리더쉽 = c(5,1),
                     사교성 = c(5,1))

set.seed(123) # 랜덤수 생성시 생성된 값 고정시키기
# runif(10) : 0~1 사이의 숫자 10개 // 균등분포(uniform distribution)
# runif(10,1,5) : 1~5사이의 숫자 10개 출력 

# rnorm(3) : 표준정규분표에서 3개 출력 
# rnorm(3,10,2) 평균이 10, 표준편차가 2인 정규분포에서 랜덤한 숫자 3개 출력 

data1 <- data.frame(분석력 = runif(3, 1, 5),
                    창의력 = rnorm(3, 10, 2),
                    판단력 = c(0.5, NA, 3),
                    리더쉽 = runif(3, 1, 5),
                    사교성 = c(5.2, 5, 4))

data2 <- rbind(layout, data1)
op <- par(mar=c(1,0.5,3,1), mfrow=c(2,2)) # 여백과 배치 조정 

radarchart(data2, axistype = 1, seg=5, plty=1, title = "첫번째 타입")
radarchart(data2, axistype = 2, pcol=topo.colors(3), plty=1, title = "두번째 타입")
radarchart(data2, axistype = 3, pty=32, plty=1, axislabcol="grey40", na.itp=FALSE ,title = "세번째 타입")
radarchart(data2, axistype = 0, plwd=1:5, pcol=1, title = "네번째 타입")

par(mfrow=c(1,1))

# 1.11 저 수준 작도 함수 (기존에 그려진 그래프에 추가적인 선이나 설명을 넣는 그래프) --------------------------

# 점           points
# 직선         lines, segments, abline
# 격자         grid
# 화살표       arrows
# 직사각형     rect
# 문자         text, mtext, title
# 테두리와 축  box, axis
# 범례         legend
# 다각형       polygon

var1 <- 1:5
plot(var1)
segments(2,2,3,3) # 2,2에서 3,3을 잇는 선 그리기 
arrows(5,5,4,4)  # 5,5에서 4,4를 잇는 선 그리기
text(2,4,"labels") # (2,4( 지점에 labels 텍스트 삽입
text(2,3,"test", srt=45) # (3,2) 지점에 test 문자 45도 기울여 삽입
title("THIS IS TEST","SUB")

plot(1:15)
abline(h=8)
rect(1,6,3,8)
arrows(1,1,5,5)


# 연습문제 1. 품종별로 iris데이터에서 꽃받침 넓이와 길이 및 꽃잎의 넓이와 길이를 산점도로 나태내라   
summary(iris)
str(iris)
library(dplyr) 

# 산점도를 그릴 때 중요한 건 비교가능하게 scale 설정하기 *****

par(mfrow=c(3,2))
iris %>% filter(Species=="setosa") %>% 
         select(Sepal.Length, Sepal.Width) %>% 
         plot(pch=16, col="Plum", main = "Setosa - Sepal", 
              xlim = c(4, 8.1), ylim = c(1.9, 4.5))

iris %>% filter(Species=="setosa") %>% 
         select(Petal.Length, Petal.Width) %>% 
         plot(pch=16, col="MediumTurquoise", main = "Setosa - Petal",
              xlim = c(0.8, 7), ylim = c(0, 2.6))

iris %>% filter(Species=="versicolor") %>% 
         select(Sepal.Length, Sepal.Width) %>% 
         plot(pch=16, col="Sienna", main = "versicolor - Sepal",
              xlim = c(4, 8.1), ylim = c(1.9, 4.5))

iris %>% filter(Species=="versicolor") %>% 
         select(Petal.Length, Petal.Width) %>% 
         plot(pch=16, col="LightGoldenrod1", main = "versicolor - Petal",
              xlim = c(0.8, 7), ylim = c(0, 2.6))

iris %>% filter(Species=="virginica") %>% 
         select(Sepal.Length, Sepal.Width) %>% 
         plot(pch=16, col="Gray40", main = "virginica - Sepal",
              xlim = c(4, 8.1), ylim = c(1.9, 4.5))

iris %>% filter(Species=="virginica") %>% 
         select(Petal.Length, Petal.Width) %>% 
         plot(pch=16, col="Coral", main = "virginica - Petal",
              xlim = c(0.8, 7), ylim = c(0, 2.6))

# 2. 품종별 꽃받침의 평균 길이와 넓이 및 꽃잎의 평균 길이와 넓이를 바 차트로 나타내라
par(mfrow=c(1,2))
str(iris)
colors <- c("MediumTurquoise","Coral","LightGoldenrod1","DeepSkyblue")
iris %>% group_by(Species) %>% 
         summarise_each(list(mean), 
                        Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) %>%  select(-Species) %>%
         as.matrix() %>% t() %>%  barplot(beside = T, col=colors, ylim = c(0,10), xlab = "Species", ylab = "avg",
                                          names.arg = c("setosa", "versicolor", "virginica"),
                                          main = "품종별 꽃받침의 넓이와 길이 및 꽃잎의 넓이와 길이") 
legend("topright", names(iris[,1:4]), cex=0.8, fill=colors)



iris %>% group_by(Species) %>% 
         summarise_each(list(mean), 
                        Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) %>%  select(-Species) %>%
         as.matrix()  %>% t() %>%  barplot(beside = F, col=colors, ylim = c(0,25), xlab = "Species", ylab = "avg",
                                           names.arg = c("setosa", "versicolor", "virginica"),
                                           main = "품종별 꽃받침의 넓이와 길이 및 꽃잎의 넓이와 길이")
legend("topright", names(iris[,1:4]), cex=0.7, fill=colors)


?legend

# 3. 품종별 꽃받침의 넓이와 길이 및 꽃잎의 넓이와 길이를 상자그림으로 

library(reshape)
par(mfrow=c(1,3))

iris %>% filter(iris$Species=='setosa') %>% select(-Species) %>% boxplot(col=colors, main = "setosa") 
iris %>% filter(iris$Species=='versicolor') %>% select(-Species) %>% boxplot(col=colors, main = "versicolor")
iris %>% filter(iris$Species=='virginica') %>% select(-Species) %>% boxplot(col=colors, main = "virginica")







