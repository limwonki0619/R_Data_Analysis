library(reshape)
library(dplyr)

boxplot(iris$Sepal.Length~iris$Species)

# 이상치 = Q1-1.5*IQR 보다 작거나
#          Q3+1.5*IQR 보다 큰 값
# IQR(Inter-Quartile Range)
# 참고 : https://m.blog.naver.com/PostView.nhn?blogId=2000051148&logNo=221157875274&proxyReferer=https%3A%2F%2Fwww.google.com%2F
str(iris)
summary(iris)


setosa <- iris %>% filter(Species=="setosa") %>% select(-Species)
boxplot(setosa)$stats
for (i in 1:4) {
  setosa[,i] <- ifelse(setosa[,i] < boxplot(setosa[,i])$stats[1] | setosa[,i] > boxplot(setosa[,i])$stats[5], NA, setosa[,i])
}
boxplot(setosa, na.rm=T, main = "이상치 제거 setosa")


versicolor <- iris %>% filter(Species=="versicolor") %>% select(-Species)
boxplot(versicolor)$stats
for (i in 1:4) {
  versicolor[,i] <- ifelse(versicolor[,i] < boxplot(versicolor[,i])$stats[1] | versicolor[,i] > boxplot(versicolor[,i])$stats[5], NA, versicolor[,i])
}
boxplot(versicolor, na.rm=T, main = "이상치 제거 versicolor")


virginica <- iris %>% filter(Species=="virginica") %>% select(-Species)
boxplot(virginica)$stats
for (i in 1:4) {
  virginica[,i] <- ifelse(virginica[,i] < boxplot(virginica[,i])$stats[1] | virginica[,i] > boxplot(virginica[,i])$stats[5], NA, virginica[,i])
}
boxplot(virginica, na.rm=T, main = "이상치 제거 virginica")

par(mfrow=c(1,3))


