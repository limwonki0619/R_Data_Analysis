# dplyr 연습문제 - mpg data 활용 

install.packages(c("ggplot2","dplyr"))
library(c(ggplot2,dplyr))
str(mpg)

# 연습문제 1 

mpg4down <- mpg %>% 
                filter(displ <= 4) %>% 
                summarise(mean = mean(hwy)) 

mpg5up <- mpg %>% 
              filter(displ >= 5) %>% 
              summarise(mean = mean(hwy))

mpg4down; mpg5up

# 연습문제 2 

filter(mpg, manufacturer %in% c('audi','toyota')) %>%
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty))

mpg %>% filter( manufacturer %in% c('audi','toyota')) %>%
        group_by(manufacturer) %>% 
        summarise(mean_cty = mean(cty))

# 연습문제 3

mpg %>% filter(manufacturer %in% c('chevrolet','ford','honda')) %>%
        summarise(mean_hwy = mean(hwy))

# 연습문제 4 

mpg4 <- mpg %>% select(class,cty); head(mpg4)

# 연습문제 5

mpg4 %>% filter(class %in% c('suv','compact')) %>%
         group_by(class) %>%
         summarise(mean_cty = mean(cty))

# 연습문제 6

mpg %>% filter(manufacturer == 'audi') %>% 
        select(manufacturer,model,hwy) %>% 
        arrange(desc(hwy)) %>% 
        head(5)

# 연습문제 7

mpg %>% select(manufacturer, cty, hwy, model, class) %>%
        mutate(합산연비변수 = cty + hwy, 평균연비변수 = 합산연비변수/2) %>% 
        arrange(desc(평균연비변수)) %>% 
        head(3)

# 연습문제 8-9

mpg %>% select(class, cty) %>% 
        group_by(class) %>% 
        summarise(mean_cty = mean(cty)) %>% 
        arrange(desc(mean_cty))

# 연습문제 10

mpg %>% select(manufacturer, hwy) %>% 
        group_by(manufacturer) %>% 
        summarise(mean_hwy = mean(hwy, na.rm=T)) %>%
        arrange(desc(mean_hwy)) %>% 
        head(3) 


# 연습문제 11

str(mpg)
mpg %>% select(manufacturer,class,model) %>% 
        filter(class == 'compact') %>%
        group_by(manufacturer) %>% 
        mutate(판매량 = 1) %>% 
        summarise(판매량 = sum(판매량)) %>% 
        arrange(desc(판매량))


str(mpg)
mpg %>% select(manufacturer,class,model) %>% 
        filter(class == 'compact') %>%
        group_by(manufacturer) %>% 
        summarise(count = n()) %>%
        arrange(desc(count))


