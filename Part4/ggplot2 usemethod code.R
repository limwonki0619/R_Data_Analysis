getwd()
setwd("D:/limworkspace/R_Data_Analysis/Part4")

# 폰트적용하기 ----------------------------------------------

install.packages("extrafont")
library(extrafont)

font_import(pattern = 'TmonMonsori') #폰트설치 
font_import(pattern = 'Jalnan')
font_import(pattern = 'BMDOHYEON')
font_import(pattern = 'BM') 
font_import(pattern = 'Binggrae') 
y
loadfonts() # 설치된 폰트 확인 


# 테스트 ------------------------------------------------------------

windowsFonts(hanna=windowsFont("BM HANNA 11yrs old")) # 폰트이름 변경 
windowsFonts(dohyeon=windowsFont("BM DoHyeon"))
windowsFonts(jalnan=windowsFont("Jalnan"))
windowsFonts(tb=windowsFont("TmonMonsori Black"))
windowsFonts(binggrae=windowsFont("Binggrae Taom"))
windowsFonts(nbg=windowsFont("나눔바른고딕"))

library(dplyr)
library(ggplot2)

iris %>% 
  ggplot(aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point() +
  theme_bw(base_family = "나눔바른고딕", base_size = 10) +
  theme(legend.position = "top") +
  labs(title="붓꽃 데이터 한글 글꼴 적용", color="붓꽃 종류") +
  theme(plot.title = element_text(family = "jalnan", face = "bold", hjust = 0.5, size = 15, color = "grey20"))

### **ggplot2 그래프 커스텀 하기** 
  
#####  **0. 기본 그래프 만들기**
  
##### **1. 타이틀(title) 커스텀 하기**
  
# 1.1 타이틀 입력하고 꾸미기

# 1.2 타이틀 여러 줄로 나누기

#####  **2. 축(Axis) 커스텀 하기**


# 2.1 축 타이틀 꾸미기

# 2.2 축 타이틀 바꾸기

# 2.3 축 타이틀에 수식 넣기

# 2.4 축 표현 범위 설정하기

# 2.5 축 라벨 잘게 쪼개기

# 2.6 축 라벨 바꾸기

# 2.7 축 라벨 옆으로 눕히기

# 2.8 축 위치 바꾸기

#####  **3. 범례(Legend) 커스텀 하기**

# 3.1 범례 지우기

# 3.2 범례 꾸미기

# 3.3 범례 테두리 꾸미기

# 3.4 범례 위치 바꾸기

# 3.5 범례 위치를 그래프 안으로 넣기

# 3.6 범례 타이틀만 지우기

# 3.7 범례 타이틀 바꾸기


#####  **4. 그래프(plot) 커스텀 하기**

# 4.1 그래프 안에 글자/선/도형 넣기

# 4.2 그래프X축, Y축 바꿔 그리기

# 4.3 흑백으로 나타내기

# 4.4 팔레트 적용하기

# 4.5 원하는 색상으로 바꾸기

# 4.6 테마 적용하기


#####  **[부록] theme()함수의 elements 설명**
