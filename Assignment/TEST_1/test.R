library(extrafont)

loadfonts() # 설치된 폰트 확인 

windowsFonts(hanna=windowsFont("BM HANNA 11yrs old")) # 폰트이름 변경 
windowsFonts(dohyeon=windowsFont("BM DoHyeon"))
windowsFonts(jalnan=windowsFont("Jalnan"))
windowsFonts(binggrae=windowsFont("Binggrae Taom"))


# 문제 1

vec1 <- 1:6
vec2 <- 10:5
vec3 <- rep(1:3,each=2)
vec4 <- rep(1:3,time=2)
vec5 <- seq(1,11,2)

# 문제 2
# 2-1)
df_score <- data.frame(이름 = c("강경학","김태균","이성열","정은원"),
                       중간 = c(90,78,94,70),
                       기말 = c(50,60,90,92))

# 2-2)
df_score$평균 <- apply(df_score[,2:3],1,mean)



# 문제 3
df_score$등급 <- ifelse(df_score$평균 >= 90,"A",
                 ifelse(df_score$평균 >= 80, "B",
                 ifelse(df_score$평균 >= 70,"C",
                 ifelse(df_score$평균 >= 60,"D","F"))))

# 문제 4

sum <- 0
oddSum <- function(x) {
  for (i in seq(1,x,2)) {
    sum <- sum + i
  }
  return(sum)
}
oddSum(100)



# 문제 5

library(dplyr)

setosa <- iris %>% 
  filter(Species=="setosa") %>% 
  select(Sepal.Width) 

boxplot(setosa$Sepal.Width)$stat # boxplot의 울타리 내 값과 그래프 출력 

mean(setosa$Sepal.Width); sd(setosa$Sepal.Width) # 이상치 제거 전 평균과 표준편차

setosa2 <- ifelse(setosa$Sepal.Width < boxplot(setosa$Sepal.Width)$stat[1] | 
                  setosa$Sepal.Width > boxplot(setosa$Sepal.Width)$stat[5], NA, setosa$Sepal.Width)

# setosa2와 같은 코드 
setosa3 <- ifelse(boxplot(setosa$Sepal.Width)$stat[1] <= setosa$Sepal.Width & 
                          setosa$Sepal.Width <= boxplot(setosa$Sepal.Width)$stat[5],
   setosa$Sepal.Width, NA)


mean(setosa2, na.rm = T); sd(setosa2, na.rm = T) # 이상치 제거 후 평균과 표준편차


# 문제 6 : toyota에서 제작한 모델 중 시내주행연비(cty)와 고속도로주행연비(hwy)의 
#          산술평균이 가장 좋은 3가지 모델과 평균연비 
library(ggplot2)
str(mpg)

mpg %>% 
  filter(manufacturer=="toyota") %>% 
  select(manufacturer,model, hwy, cty) %>%
  group_by(model) %>%
  summarise(mean_hwy_cty = mean(hwy+cty)/2) %>% # 산술평균 주의
  arrange(desc(mean_hwy_cty)) %>% head(3)

((20+20+19+17+20+17)/6)+((15+16+15+15+16+14)/6)

# 문제 7 : R 내장 데이터인 'mpg'를 이용하여 다음의 그래프를 그리시오

# 7-1) SUV자동차의 시내연비가 높은 7개 회사와 시내 연비
mpg %>%
  filter(class=="suv") %>% 
  select(manufacturer,class,cty) %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty))

# 7-2) 막대 그래픠 형식의 컬러 그래프를 그리시오 
mpg %>%
  filter(class=="suv") %>% 
  select(manufacturer,class,cty) %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>% 
  head(7) %>%
  ggplot(aes(x=reorder(manufacturer, -mean_cty), y=mean_cty,fill=manufacturer)) +
    geom_bar(stat = "identity") +
     geom_text(aes(x=manufacturer,y=mean_cty-0.5, label=round(mean_cty,1), size = 3), color="white", family ="hanna") +
     theme_bw(base_family = "hanna", base_size = 18) +
     theme(axis.text.x = element_text(vjust=0.5)) +
     theme(axis.title.x = element_blank()) +
     theme(legend.position = "none") +
     labs(title = "SUV자동차의 시내연비 TOP7", y = "시내 평균연비") +
     theme(plot.title = element_text(family = "jalnan",face="bold",hjust=0.5,size = 15, color = "grey20"))
   
# 문제 8 : R 내장 데이터인 'diamonds'를 이용하여 다음의 그래프를 그리시오
library(ggplot2)

# 8-1 clarity의 도수를 보여주는 그래프 
diamonds %>% 
  select(clarity) %>%
  group_by(clarity) %>%
  summarise(count = n()) %>%
    ggplot(aes(x=reorder(clarity, -count), y=count/1000, fill=clarity)) +
    geom_bar(stat = "identity",width = 0.8) + 
    geom_text(aes(x=clarity,y=(count/1000)-0.3, label=round(count/1000,1), size = 3), color="white", family ="hanna") +
     theme_bw(base_family = "hanna", base_size = 18) +
     theme(axis.text.x = element_text(vjust=0.5)) +
     theme(axis.title.x = element_blank()) +
     theme(legend.position = "none") +
     labs(title = "Clarity별 도수", y = "갯수(단위: 천 개)") +
     theme(plot.title = element_text(family = "jalnan",face="bold",hjust=0.5,size = 15, color = "grey20"))


# 8-2 clarity에 따른 가격의 변화를 보여주는 그래프 
diamonds %>%
  select(clarity,price) %>%
  group_by(clarity) %>%
  summarise(mean_price = mean(price)) %>%
    ggplot(aes(x=reorder(clarity, -mean_price),y=mean_price,fill=clarity)) + 
    geom_bar(stat="identity") +
     theme_bw(base_family = "hanna", base_size = 18) +
     theme(axis.text.x = element_text(vjust=0.5)) +
     theme(axis.title.x = element_blank()) +
     theme(legend.position = "none") +
     labs(title = "Clarity별 평균가격변화", y = "가격") +
     theme(plot.title = element_text(family = "jalnan",face="bold",hjust=0.5,size = 15, color = "grey20"))




# 문제 9 : 실습 데이터 중 '야구성적.csv' 파일을 이용하여 
baseball <- read.csv("C:/Users/1pc/Desktop/실습용_데이터/야구성적.csv")

# 9-1)
baseball %>% 
  mutate(OPS = 출루율+장타율,
         연봉대비OPS = OPS/연봉*100)

# 9-2
baseball %>% 
  mutate(OPS = 출루율+장타율,
         연봉대비OPS = OPS/연봉*100) %>% 
  ggplot(aes(x=선수명,y=연봉대비OPS,group=선수명,color=선수명)) +
    geom_point(size=4) +
    geom_segment(aes(x=선수명,xend=선수명,y=0,yend=연봉대비OPS), color="grey50") +
    geom_text(aes(x=선수명,y=연봉대비OPS+5,label=round(연봉대비OPS,1),family="dohyeon")) +
      theme_bw(base_family = "hanna", base_size = 18) +
      theme(axis.text.x = element_text(angle=45, vjust=0.5)) +
      theme(axis.title.x = element_blank()) +
      theme(legend.position = "none") +
      labs(title = "프로야구 선수별 연봉대비OPS") +
      theme(plot.title = element_text(family = "jalnan",face="bold",hjust=0.5,size = 15, color = "grey20"))

  
