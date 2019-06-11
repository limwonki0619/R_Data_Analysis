getwd()
setwd("D:/limworkspace/R_lecture/Part4")
setwd("D:/limworkspace/R_lecture/Part4/data")
setwd("D:/limworkspace/R_lecture/Part4/graph")
getwd()

#--------------------------------------------------------------#
#-------------------- Part 4 : Visualization-------------------#
#-------------------- Section 2 : ggplot2  --------------------#
#--------------------------------------------------------------#

# https://www.r-graph-gallery.com/all-graphs/ : ggplot2 sample code

# 색상 ---------------------------------------------------------

c("MediumTurquoise","Coral","DeepSkyblue","salmon","LightSkyBlue","Pink1",
  "IndianRed2","PaleGreen2","Plum","LightGoldenrod1","Sienna","OliveDrab",
  "CadetBlue2","Mediumpurple1","PaleVioletRed1","Gray40")

colors <- c("MediumTurquoise","Coral","LightGoldenrod1","DeepSkyblue")


# 2. Welcom to ggplot2 world -------------------------------------------------------------------------------------------------------------
install.packages("ggplot2")
library(ggplot2)

korean <- read.table("data/학생별국어성적_new.txt", header=T, sep=","); korean

ggplot(korean, aes(x=이름, y=점수)) +              # positional argument
       geom_point()                                # aes(aesthetic mapping)에는 x,y축 데이터, 점의 모양, 점의 크기, 점의 색이 올 수 있다

ggplot(data=korean, mapping=aes(x=이름, y=점수)) + # keyword argument
       geom_point()                                # geometric object 


# 2.1 막대그래프 : geom_bar() ------------------------------------------------------------------------------------------------------------

ggplot(data=korean, mapping=aes(x=이름, y=점수, fill = 이름)) + 
  geom_bar(stat = "identity") +                                              # stat는 주어진 데이터에서 geom에 필요한 데이터를 생성
  theme_bw() +                                                               #   
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1, 
                                   size = 8, face = "bold.italic"))   # 테마 수정은 element 객체를 수정, h : 좌우 v : 위아래 
?element_text

# stat 옵션에는 count(각 항목의 빈도 수), density(각 항목의 밀도 수) 등이 올 수 있다 p506 

score_kem <- read.csv("학생별과목별성적_국영수_new.csv", header=T)

library(dplyr)

arrange(score_kem, 이름, 과목) %>%
              group_by(이름) %>%
              summarise(누적합계 = sum(점수), 
                     label = sum(점수)-0.5*점수) %>% 
                      ggplot(aes(x=이름, y=점수, fill=과목)) + 
                      geom_bar(stat="identity") +
                      geom_text(aes(y=label, label=paste0(점수,"점")), colour="black", size=4)

summarise(group_by(df, key1), mean=mean(data1))
ddply(score_kem, "이름", transform, 누적합계=cumsum(점수))
# 2.2 클리블랜드 점 그래프 : geom_segment() ------------------------------------------------------------------------------------------------------------

score_eng <- read.table("학생별전체성적_new.txt", header=T, sep=",") %>% select(이름,영어)
ggplot(score_eng, aes(x=영어, y=reorder(이름,영어))) +
  geom_segment(aes(yend=이름),xend=0, color="blue") +
  geom_point(size=4, color="green") + 
  theme_bw() +
  theme(panel.grid.major.x = element_blank())


# 2.3 산점도 : geom_point() ------------------------------------------------------------------------------------------------------------

mtcars
str(mtcars)

ggplot(mtcars, aes(x=hp, y=mpg)) + 
  geom_point(aes(color=factor(am), size=wt, shape=factor(am))) +
  geom_line()


ggplot(mtcars, aes(x=hp, y=mpg)) + 
  geom_point(color="red") +
  geom_line(color="grey40",linetype="dashed")  # 선 추가하기 

ggplot(mtcars, aes(x=hp, y=mpg)) + 
  geom_point(color="red") + 
  labs(x="마력", y="연비(mile/gallon)") # x축 y축 라벨명 바꾸기 

ggplot(mtcars, aes(x=hp, y=mpg)) + 
  geom_point(aes(color=factor(am), size=wt, shape=factor(am))) +
  scale_colour_manual(values = c("red","green")) # 그룹별 색 지정


# 2.3  : geom_line() : 주로 시계열 자료에 쓰이는 함수 ------------------------------------------------------------------------------------
three <- read.csv("학생별과목별성적_3기_3명.csv")
three %>% arrange(이름, 과목) %>% 
          ggplot(aes(x=과목, y=점수, color=이름, group=이름, fill=이름)) +  # ggplot내에 aes가 있을 경우 자동으로 그룹 구분이 가능
          geom_line() + 
          geom_point(size=3, shape=22)
  
three %>% arrange(이름, 과목) %>% 
  ggplot(aes(x=과목, y=점수, group=이름, fill=이름)) +  # ggplot내에 aes가 있을 경우 자동으로 그룹 구분이 가능
  geom_line() +                                         # line색상도 ggplot내에 지정할 경우 각각 생성 
  geom_point(size=3, shape=22) +
  theme_bw() +
  ggtitle("학생별 과목별 성적") +
  theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "darkblue"))   # title의 글씨체, 글씨 모양, 가운데 정렬, 크기, 색상을 설정합니다.

# 2.4 geom_area() : 선 아래 면적까지 나타내는 함수 ----------------------------------------------------------------------------------------

dis <- read.csv("1군전염병발병현황_년도별.csv", stringsAsFactors=F)
class(dis)

ggplot(dis, aes(x=년도별, y=장티푸스, group=1)) + 
  geom_area(fill="DeepSkyblue", alpha=0.4) + # 면적테두리 색  
  geom_line(color="Deepskyblue") # line 색상



arrange(score_kem, 이름, 과목) %>%
  group_by(이름) %>%
  summarise(누적합계 = sum(점수))

