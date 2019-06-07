library(reshape)
library(dplyr)

boxplot(iris$Sepal.Length~iris$Species)

# 이상치 = Q1-1.5*IQR 보다 작거나
#          Q3+1.5*IQR 보다 큰 값
# IQR(Inter-Quartile Range)
# 참고 : https://m.blog.naver.com/PostView.nhn?blogId=2000051148&logNo=221157875274&proxyReferer=https%3A%2F%2Fwww.google.com%2F

iris %>% select(Sepal.Length, Species) %>% filter(Species =="setosa") %>% 
         summarise(Sepal.Length_median = median(Sepal.Length)) %>% 
         filter(Sepal.Length >= Sepal.Length_median)
