library(ggplot2)
library(dplyr)
install.packages("dplyr")


# 연습문제 1 
str(mpg)

ggplot(mpg,aes(x=cty, y=hwy)) + 
  geom_point(size=0.9, color="OliveDrab") +
    theme_bw() +
    labs(x="도시 연비(cty)", y="고속도로 연비(hwy)") +
    ggtitle("mpg 데이터의 도시 연비(cty)와 고속도로 연비(hwy)의 산점도") +
    theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "black"))



#연습문제 2
str(midwest)

midwest %>% filter(poptotal <= 500000) %>% 
            filter(popasian <= 10000) %>%
  ggplot(aes(x=poptotal/10000, y=popasian/1000)) + 
  geom_point(size=0.9, color="OliveDrab") + 
    theme_bw() +
    labs(x="전체 인구 (만 명)", y="아시아 인구 (천 명)") +
    ggtitle("미국 전체인구와 아시아인의 산점도") +
    theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "black"))

# 연습문제 3
filter(mpg, class=="suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>% head(5) %>% 
    ggplot(aes(x=paste0(1:5,". ",manufacturer), y=mean_cty, fill=manufacturer)) +
    geom_bar(stat = "identity", width = 0.5) +
      labs(x="제조사", y="평균 도시 연비") +
      theme_bw() +     
      theme(legend.position = "none") + # 범례 삭제
      theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1, size = 10, face = "bold.italic")) + 
      ggtitle("mpg 데이터의 제조사(class)별 suv 평균 도시 연비(cty)") +
      theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "black"))

# ggplot(data, aes(reorder(manufacturer, -mean_cty),  # 내림차순 
# y=mean_cty, fill=manufacturer)) + geom_col() 


# 연습문제 4
mpg %>% 
  select(class) %>% 
  group_by(class) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>% 
    ggplot(aes(x=paste0(1:7,". ",class), y=n, fill=class)) + 
    geom_bar(stat = "identity", width = 0.5) +
      labs(x="자동차 종류", y="빈도") +
      theme_bw() +                         
      theme(legend.position = "none") + # 범례 삭제
      theme(axis.text.x = element_text(angle=45, hjust=1, vjust=1, size = 10, face = "bold.italic")) +
      ggtitle("자동차 종류별 빈도") +
      theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "black"))

# 도수를 자동으로 셀 수 있음 


# 연습문제 5
str(economics)

ggplot(economics, aes(x=date, y=psavert)) + 
  geom_line(color="MediumTurquoise") +
    theme_bw() +
    labs(x="시간",y="개인 저축률") +
    ggtitle("시간에 따른 개인 저축률 변화") +
    theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "black"))



# 연습문제 6 
mpg %>% 
  select(cty, class) %>%
  filter(class %in% c("compact","subcompact","suv")) %>%
  group_by(class) %>% 
    ggplot(aes(x=class, y=cty, fill=class)) + 
    geom_boxplot() +
      theme_bw() +
      theme(legend.position = "none") + # 범례삭제
      labs(x="차량 종류",y="도시 연비") +
      ggtitle("차량 종류에 따른 도시 연비 Box Plot") +
      theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "black"))

# 연습문제 7 
# 7-1
str(diamonds)

diamonds %>% 
  group_by(cut) %>% 
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
    ggplot(aes(x=paste0(1:5,". ",cut), y=n, fill=cut)) + 
    geom_bar(stat="identity", width = 0.5) +
      theme_bw() +
      labs(x="커팅 방법", y="도수") +
      ggtitle("커팅 방법에 따른 도수") +
      theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "black")) +
      theme(legend.position = "none")


# 7-2
diamonds %>% 
  group_by(cut) %>% 
  summarise(mean_cut_price = mean(price)) %>%
  arrange(desc(mean_cut_price)) %>%
    ggplot(aes(x=paste0(1:5,". ",cut), y=mean_cut_price, fill=cut)) + 
    geom_bar(stat="identity", width = 0.5) + 
      theme_bw() +
      labs(x="커팅 방법", y="가격") +
      theme(legend.position = "none") +
      ggtitle("커팅 방법에 따른 가격 변화") +
      theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "black"))


# 7-3
diamonds %>%
  group_by(cut,color) %>%
  summarise(mean_cut_color_price = mean(price)) %>% 
  arrange(desc(mean_cut_color_price)) %>%
    ggplot(aes(x=color, y=mean_cut_color_price, fill=color)) +
    geom_bar(stat="identity") +
      facet_wrap(~cut) +
      theme_bw() +
      labs(x="색상", y="가격") +
      theme(legend.position = "none") +
      ggtitle("커팅 방법에 따른 가격 변화") +
      theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "black"))


